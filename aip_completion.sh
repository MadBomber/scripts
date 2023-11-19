# scripts/aip_completion.sh
# Setup a prompt completion for use with
# aip.rb

export PROMPTS_DIR=~/.prompts

# Function to generate prompt completions for aip.rb

_aip_completion() {
  # The current word being completed
  local cur_word="${COMP_WORDS[COMP_CWORD]}"

  # Store the previous directory to return to it later
  local initial_pwd=$(pwd)

  # Change directory to the prompts directory
  cd $PROMPTS_DIR

  # Generate a list of relative paths from the ~/.prompts directory (without .txt extension)
  local files=($(find . -name "*.txt" -type f | sed 's|^\./||' | sed 's/\.txt$//'))

  # Change back to the initial directory
  cd "$initial_pwd"

  # Generate possible matches and store them in the COMPREPLY array
  COMPREPLY=($(compgen -W "${files[*]}" -- "$cur_word"))
}


# Register the completion function for the aip command
complete -F _aip_completion aip.rb
