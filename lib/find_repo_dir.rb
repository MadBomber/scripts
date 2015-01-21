# find_repo_dir.rb
require 'pathname'

# recursively inspect the CWD hierarchie looking for a .git
# subdirectory.  The directory name that contains the
# .git subdirectory is taken as the name of the
# github repository.
def find_repo_dir(here=Pathname.pwd)
  if (here + '.git').exist?
    return here
  else
    find_repo_dir(here.dirname) unless '/' == here.to_s
  end
end
