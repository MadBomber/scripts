scripts
=======

Some of my everyday scripts that I like to keep sync'ed across machines.

This is really just old stuff I needed to park in a place that I could find it
again if I needed it.

Filename                          Description
--------------------------------- ---------------------------------------------
Gemfile                           Used by bundle to install for common gems
Gemfile.lock                      Used by bundle
README.md                         this file
_old_stuff_and_1offs/             directory of old stuff
ack*                              Search for PATTERN in each source file in the tree from cwd on down.
anagram_code.rb*                  plaything
anagrams.rb*                      plaything
aw*                               greps the all_words.txt file
blessing.rb*                      use text-to-speech to say a blessing
bp.rb*                            blood pressure reporting
classpath*                        runs $CLASSPATH value through the colon_splitter
cloc-1.07.pl                      count lines of code
cloc.pl*                          count lines of code
clone_all.rb*                     clones all my github repos
code*                             uses tmux to setup a source file coding session
colon_split*                      splits STDIN based on ':' character
comment_gemfile*                  Adds single line description of gem to the Gemfile
convert_html_to_text.rb*          Extracts text from an HTML file
cr2lf*                            Changes <CR> characters to <LF> characters in a file
create_install_gemset*            Creates a bash script to install gems from an RVM gemset
csv_reader.rb*                    print to STDOUT a formatted report of a CSV file
ct.rb*                            colortail ??
delete_all_gems.s*                does a 'gem uninstall' for all installed gems
describe_gems.rb*                 prints out a description for a set of gems from STDIN

docx_appender.rb*                 append paragraphs to an MS Word file
docx_breakup.rb*                  breakup a large MS Word file into a bunch of smaller ones
docx_brf.rb*                      bible reference finder (brf) in an MS Word file
docx_draft_layout.rb*             print an MS Word file in a draft layout
docx_extract_bodytext.rb*         extract paragraphs of style 'bodytext' from an MS Word file
docx_rm_blank_paragraphs.rb*      remove blank paragraphs from an MS Word file
docx_rm_para_with_styles.rb*      remove paragraphs with a certain style from an MS Word file
docx_style_fixer.rb*              replace the paragraph style definitions of one MS Word file with those from another
docx_style_lister.rb*             list the paragraph styles used in an MS Word file
docx_to_txt.rb*                   convert an MS Word file into a text file
docx_translate.rb*                translate an MS Word file from one language to another using google translate

dumppdf*                          doesn't work
e*                                shortcut to launch sublime text editor
erb2haml*                         convert erb files into haml files
fake.rb*                          generate some lorem text using the wordy gem
file_templates/                   directory of template files used by the 'new' command
filename_fu.rb*                   manipulate the filenames of - pretty useless outside of a specific convention
fw*                               grep the dictionary.txt file
gem_ctags.rb*                     build a .tags file for all ruby gems in the Gemfile
gemd*                             shortcut to the describe_gems.rb program -- prints description of gems
gemt*                             prints a short (1 line) description of a list of gems (like rake -T)
imbibler.rb*                      extract text from biblegateway.com of a specific bible chapter
init_ramcache.sh*     outdated    copy stuff to /ramcache
json*                             pretty print a *.json file
json2yaml.rb*                     convert *.json file into a *.yaml file
killall_ruby*                     killall current ruby processes
latest_gems*                      shortcut to latest_gems.rb
latest_gems.rb*                   get a list of the latest gems from rubygems.org
latin2ascii.py*                   does something with text encoding
launch_background_jobs*           shortcut to launch_background_jobs.rb
launch_background_jobs.rb*    outdated  launches a set of background jobs like ejabber and rabbitmq
lflf2lf*                          removes duplicate <LF> characters
lib/                              directory of reusable methods etc. most have been moved to the lib_ruby repo
lipsum.rb*                        prints some lorem ipsum text; not as generic as fake.rb
magic_8_ball.rb*                  uses text to speech to say random answer from the 1950s toy
mbox_finder.rb*                   Finds mbox files and prints out subject and date lines
merge2*                           uses kdiff3 to merger 2 files into a combined output file
my_docx_style_fixer.rb*           a more generic ?? version of docx_style_fixer.rb
my_qa*                            some static analysis of ruby code - rubocop is better
nc.sh*                   outdated
new*                              shortcut to new.rb
new.rb*                           creates a new file from a template
new_rails_app.s*                  creates a new rails project using rails composer
newgit_project*                   creates a new git-backed project structure (the git stuff only)
normalize_pathnames.rb*           changes filenames by replacing special characters with underscore
note.rb*                          Adds a timestamped note to the $HOME/_notes.txt file
number*                           print the English name of a number of any size
path*                             sends $PATH to colon_spliter.rb
pdf2txt*                          extracts text from a pdf file
phpinfo*                          prints configuration information about the current PHP environment
picnic_gems.rb*                   installs a list of gems from a text file
ping_monitor*       outdated      pings a hard coded list of hosts
pinger.rb*          outdated      looks for active IP addresses on a hardcoded subnet
platform*                         uses the gem ohai to maintain a file $HOME/platform.json
ppsql.rb*           failure       an attempt to pretty pring sql files
printenv*                         report system environment things
projxslt.rb*                      Used by ruby2html.rb
prompt_string.rb        outdated       
rails_boilerplate.sh*   outdated  
rawk.rb*                          gives statistics for Ruby on Rails log files.
release.rb*                       Build and release a gem via @rultor in github
relink_home_dirs.rb*   (frank only)  Creates symbolic links in $HOME for the common directories
rename_db_columns.rb*             normalizes column names created by the tool csvsql
replace_home_dots.rb*  (frank only)  saves existing $HOME dot files then replaces them with dot_files content 
retirement_home/                  A directory where old programs go like _old_stuff_and_1offs/
reverse_gem_depends.rb*  (not ready)  I forgot
rpp*                              Ruby pretty printer
rsync_itunes_backup.s  outdated   Uses rsync to keep a backup of the itunes directory
rtags*                            generates .tags file from ruby code
ruby2html.rb*          outdated   colorizes ruby code into an HTML file
ruby2html.xml*                    used by ruby2html.rb
ruby2html.xsl*
ruler*                            prints a character ruler on the terminal
rultor_init_project.rb*           inits a project directory for use on github with the rultor tool
rxref*                 outdated   cross reference a ruby file -- unfinished
s3_downloader.rb*                 download a file from AWS S3 service
s3_uploader.rb*                   upload a file to the AWS S3 service
set_upstream.rb*                  set the upstream remote of a git clone
sgi*                              print general info about a version controled project (svn/git)
squish_gem_list.rb*               reduce the gems in a list based upon dependencies
start_postgresql.sh    outdated   start the postgresql server
stop_postgresql.sh     outdated   stop the postgresql server
summarize_file.rb*                provide a text summary of the content of a file
sw*                               does the same as fw - grep the file dictionary.txt
sync_upstream.rb*                 syncs the local git clones with their upstream remotes
tcat412.pl*            outdated   implements a 'cat' function within TWiki
test_rubies.sh*        outdated   runs Rspec for a project against several ruby versions using rvm
uninstall_all_gems.rb*            uninstalls all gems
unset_proxy.s*                    unsets all proxy environment variables
wcml_brf.rb*                      bible reference finder for *.wcml files (Adobe Incopy/woodwing)
wcml_draft_layout.rb*             prints a draft layout of a *.wcml file
where*                            uses the $PATH to find all versions of a program and execs it with --version
wl*                               uses $wl to find all words/lines in a file of a specific length
yaml2json.rb*                     converts *.yaml files into *.json files
