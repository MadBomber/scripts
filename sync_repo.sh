#!/usr/bin/env bash

# Function to display usage
usage() {
  echo "Usage: $0 [directory]"
  echo "If no directory is provided, the current working directory will be used."
  exit 1
}

# Check if a command line argument is provided
if [ "$#" -gt 1 ]; then
  usage
fi

# Set the directory to the provided argument or current working directory
TARGET_DIR="${1:-.}"

# Check if the target directory exists
if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Directory '$TARGET_DIR' does not exist."
  exit 1
fi

# Change to the target directory
cd "$TARGET_DIR" || exit

# Check if upstream remote exists
if git remote get-url upstream > /dev/null 2>&1; then
  echo "Fetching from upstream..."
  git fetch upstream

  # Determine the primary branch
  if git show-ref --verify --quiet refs/heads/main; then
    PRIMARY_BRANCH="main"
  elif git show-ref --verify --quiet refs/heads/master; then
    PRIMARY_BRANCH="master"
  else
    echo "No primary branch found (main or master)."
    exit 1
  fi

  echo "Merging changes from upstream/$PRIMARY_BRANCH..."
  git checkout "$PRIMARY_BRANCH"
  git merge "upstream/$PRIMARY_BRANCH"

  echo "Pushing changes to origin..."
  git push origin "$PRIMARY_BRANCH"
else
  echo "No upstream remote found. Skipping sync."
fi
