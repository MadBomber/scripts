-- row_to_json.sql
-- See: https://blog.bigbinary.com/2018/05/29/generating-json-using-postgresql-json-function.html

-- get all fields on the row
select row_to_json(table_name) from table_name;

-- get selected fields in the row
select row_to_json(sub_table_name)
from (
  select id, field_one, field_two, field_three, field_four from table_name
) sub_table_name;

