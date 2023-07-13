BEGIN;

CREATE OR REPLACE FUNCTION table_metadata( IN p_source_table regclass ) RETURNS JSONB as $$
DECLARE
    v_output JSONB; -- Full output from this function. It will be jsonb object, with keys: oid, nspname, relname, attname, full_name, and optionally fkeys'
    v_fkeys JSONB; -- Information about foreign keys that given table has defined. It will be array of objects, where each object will contain: source_column, dest_rel (oid of referenced table), and dest_column (name of referenced column).
BEGIN
    -- Get metainformation about the table
    WITH x as (
        SELECT
            c.oid,       -- oid of the table
            n.nspname,   -- name of schema the table is in
            c.relname,   -- name of the table
            a.attname,   -- name of column that is primary key
            format('%I.%I', n.nspname, c.relname) as full_name
        FROM
            pg_class AS c
            JOIN pg_namespace AS n ON c.relnamespace = n.oid
            JOIN pg_index AS i ON i.indrelid = c.oid
            JOIN pg_attribute AS a ON a.attrelid = c.oid AND
            a.attnum = i.indkey[0]
        WHERE
            c.oid = p_source_table AND
            i.indisunique AND
            array_length( i.indkey, 1) = 1 AND
            c.relkind = 'r'
    )
    SELECT to_jsonb(x) INTO v_output FROM x;

    -- If the data was not found, there is not much we can do.
    IF NOT FOUND THEN
        RETURN NULL;
    END IF;

    -- Get information about foreign keys
    with data as (
        SELECT
            s_a.attname AS source_column,
            r_c.oid AS dest_rel,
            r_a.attname AS dest_column
        FROM
            pg_catalog.pg_constraint AS c
            JOIN pg_attribute AS s_a ON c.conrelid = s_a.attrelid AND
            s_a.attnum = c.conkey[1]
            JOIN pg_class AS r_c ON c.confrelid = r_c.oid
            JOIN pg_namespace AS r_n ON r_c.relnamespace = r_n.oid
            JOIN pg_attribute AS r_a ON r_a.attrelid = c.confrelid AND
            r_a.attnum = c.confkey[1]
        WHERE
            c.conrelid = p_source_table AND
            c.contype = 'f' AND
            array_length(
                c.conkey,
                1
            ) = 1 AND
            array_length(
                c.confkey,
                1
            ) = 1
    )
    SELECT jsonb_agg( to_jsonb(d) ) INTO v_fkeys FROM data d;

    -- if there are no fkeys, return output as it was built earlier.
    IF v_fkeys IS NULL THEN
        RETURN v_output;
    END IF;

    -- Fkeys are there, add them to output, and return.
    RETURN jsonb_insert( v_output, array[ 'fkeys' ], v_fkeys );
END;
$$ language plpgsql;

create or replace function get_row_data( IN p_meta JSONB, IN p_column TEXT, IN p_pkey ANYELEMENT) RETURNS JSONB AS $$
declare
    v_output jsonb; -- Full output from function
    v_row jsonb;    -- Found row, as JSON.
    v_fkey jsonb;   -- Helper variable to iterate over, fkeys in the TABLE.
BEGIN
    -- Fetch the row.
    EXECUTE format('SELECT to_jsonb(o) FROM %I.%I o WHERE o.%I = %L', p_meta->>'nspname', p_meta->>'relname', p_meta->>'attname', p_pkey ) INTO v_row;
    v_output := jsonb_build_object( 'row', v_row );

    -- If the table doesn't have fkeys, there is nothing else to process, so return early.
    IF p_meta->'fkeys' IS NULL
    THEN
        RETURN v_output;
    END IF;

    -- At this moment we know that there are fkeys, so let's add dependencies key, so that jsonb_insert will not complain.
    v_output := v_output || jsonb_build_object( 'dependencies', '[]'::jsonb );

    -- Iterate over all fkeys in the TABLE
    for v_fkey IN SELECT e.v FROM jsonb_array_elements(p_meta->'fkeys') e (v) LOOP

        -- If value in the fkey column is null, there is nothing to add from other table
        continue when v_row->>(v_fkey->>'source_column') IS NULL;

        -- If thereis value, add it to dependencies
        v_output := jsonb_insert(
            v_output,
            '{dependencies,0}',
            jsonb_build_object(
                'rel', v_fkey->>'dest_rel',
                'column', v_fkey->>'dest_column',
                'value', v_row->(v_fkey->>'source_column')
            )
        );
    END LOOP;
    RETURN v_output;
END;
$$ language plpgsql;

create or replace function export_data( IN p_source_table regclass, IN p_pkey ANYELEMENT) RETURNS JSONB AS $$
declare
    v_meta jsonb;                  -- metainformation about single table
    v_all_meta jsonb;              -- metainfomation about all tables that are part of export
    v_output jsonb;                -- final output from function
    v_queue jsonb;                 -- jsonb array with queue of rows to fetch
    v_new_elements jsonb := '[]';  -- list that will become new queue on next iteration
    v_row_info jsonb;              -- single element from queue
    v_row_data jsonb;              -- data about fetched row
BEGIN
    -- Get metadata about source TABLE
    v_meta := table_metadata( p_source_table );
    -- Put this metadata in metadata cache
    v_all_meta := jsonb_build_object( p_source_table::oid, v_meta );

    -- Make base output
    v_output := jsonb_build_object(
        'source_table', format('%I.%I', v_meta->>'nspname', v_meta->>'relname'),
        'source_id', p_pkey,
        'data', '{}'::jsonb
    );

    -- Add the row that user requested with options to queue. At this moment, queue will have only one element
    v_queue := jsonb_build_array(
        jsonb_build_object(
            'rel', p_source_table::oid,
            'column', v_meta->>'attname',
            'value', p_pkey
        )
    );

    -- Process the queue, if it's not empty.
    WHILE jsonb_array_length( v_queue ) > 0 LOOP

        -- Iterate over elements in queue, putting each element into v_row_info
        for v_row_info IN SELECT e.v FROM jsonb_array_elements( v_queue ) e(v) LOOP

            -- If metainformation for table for this row is not yet in v_all_meta, add it.
            IF NOT v_all_meta ? (v_row_info->>'rel') THEN
                v_all_meta := jsonb_insert( v_all_meta, array[ v_row_info->>'rel' ], table_metadata( (v_row_info->>'rel')::oid ) );
            END IF;

            -- Get metainfo for currently processed TABLE, to have less typing...
            v_meta := v_all_meta->(v_row_info->>'rel');

            -- Make sure that output/data hash has place for data from this table, otherwise jsonb_insert() of the row will fail.
            IF NOT v_output->'data' ? (v_meta->>'full_name') THEN
                v_output := jsonb_insert( v_output, array[ 'data', v_meta->>'full_name' ], '{}' );
            END IF;

            -- If output already contains data for this row, there is no point in processing.
            continue when v_output->'data'->(v_meta->>'full_name') ? (v_row_info->>'value');

            -- Get row_data for this single row.
            v_row_data := get_row_data( v_meta, v_row_info->>'column', v_row_info->>'value' );

            -- Add row data to output
            v_output := jsonb_insert( v_output, array[ 'data', v_meta->>'full_name', v_row_info->>'value' ], v_row_data->'row' );

            -- If there are no dependencies, go to next element in queue
            continue when v_row_data->'dependencies' IS NULL;

            -- Add current dependencies to v_new_elements
            v_new_elements := v_new_elements || ( v_row_data->'dependencies' );
        END loop;

        -- After processing queue, make sure that all the dependencies will be in queue
        v_queue := v_new_elements;
        -- Zero v_new_elements, so we can detect when there is nothing else to add.
        v_new_elements := '[]';
    END loop;

    -- At this moment all is built :)
    RETURN v_output;
END;
$$ language plpgsql;

commit;
