#!/usr/bin/env bash

# Function to display usage information
usage() {
  echo
  echo "Usage: `basename $0` [pattern]"
  echo "Search and delete files matching a specified pattern."
  echo
  echo "If no pattern is provided, the script will prompt for one."
  echo "The script will ask for confirmation before deleting each matching file."
  echo
  echo "Options:"
  echo "  -h, --help    Display this help message and exit."
  echo
  echo "Example:"
  echo "  `basename $0` 'temp*'"
  echo "  This command will find and prompt to delete all files starting with 'temp'."
  echo
}

# Check for help option
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  usage
  exit 0
fi

# Check if a regex pattern was passed as a command-line argument
if [ $# -eq 0 ]; then
  # No argument supplied, ask the user for a regex
  echo -n "What? : "
  read regex
  if [ -z "$regex" ]; then
    echo "No regex entered. Exiting."
    exit 1
  fi
else
  # Use the first argument as the regex
  regex="$1"
fi

# Using find with the regex
# Note: Since we're dealing with user input, always be cautious.
find . -name "$regex" -exec rm -i {} +
