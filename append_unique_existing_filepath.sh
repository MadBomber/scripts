#!/bin/sh

debug() {
  echo "DEBUG: $@" >&2  # Redirect to stderr
}

append_unique_existing_filepath() {
    var_name="$1"
    filepath="$2"

    # Check if the filepath exists
    if [ ! -e "$filepath" ]; then
        debug "Filepath does not exist: $filepath"
        return
    fi

    # Get the current value of the variable using eval
    current_value="$(eval "echo \$$var_name")"
    
    # Check if the value is already in the variable
    if [ -z "$current_value" ]; then
        # If the variable is empty, set it directly
        eval "$var_name=\"$filepath\""
    elif [ "$(echo "$current_value" | grep -c -w "$filepath")" -eq 0 ]; then
        # If not already present, append the new value
        eval "$var_name=\"$current_value:$filepath\""
    fi
}

# Example usage
any_variable=""

append_unique_existing_filepath "any_variable" "one"
append_unique_existing_filepath "any_variable" "two"
append_unique_existing_filepath "any_variable" "three"
append_unique_existing_filepath "any_variable" "one"
append_unique_existing_filepath "any_variable" "five"
append_unique_existing_filepath "any_variable" "two"
append_unique_existing_filepath "any_variable" "three"
append_unique_existing_filepath "any_variable" "one"

echo
echo $any_variable
