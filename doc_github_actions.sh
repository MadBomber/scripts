#!/usr/bin/env bash
# ~/scripts/doc_github_actions.sh
# Uses `aia` to document github action workflow YAML files
# that are in the current directory.
#
# gem install aia
# ... grab the prompt file: github_actions_doc
#

for file in *.yml; do
    # Check if there are any .yml files
    if [ ! -e "$file" ]; then
        echo "No .yml files found in the current directory."
        exit 0
    fi

    base_file="${file%.yml}"
    output_file="${base_file}.md"
    toc_file="${base_file}_toc.md"

    echo "Processing $file ..."

    # ACTION="$file" && 
    aia github_actions_doc "$file" -o "$output_file"    
done

