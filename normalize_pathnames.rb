#!/usr/bin/env ruby
###########################################
###
##  File: normalize_pathnames.rb
##  Desc: renames directory and file names such that any
##        embedded special characters are translated to an underscore.
#
$debug    = ARGV.include?('-d') || ARGV.include?('--debug')
$changed  = 0

require 'pathname'

def normalize_filename( pn, from_chars, to_chars )

  return(pn) unless Pathname  == pn.class
      
  p = pn.dirname
  f = pn.basename.to_s
  
  if f.tr_s!(from_chars, to_chars)
    $changed += 1
    f = f[0,f.size-to_chars.size] while f.end_with?(to_chars)
    f.gsub!(to_chars+'.', '.')
    p2 = p + f
    pn.rename(p2)
    return(p2)
  end
  
  return(pn)
  
end # end of def normalize_filename



def normalize_directory(  dir, 
                          from_chars= "\-[]+ ',()",
                          to_chars  = "_"
                       )
  
  new_dir = normalize_filename( dir, from_chars, to_chars )

  new_dir.children.each do | filename |
  
    if filename.directory?
      normalize_directory( filename, from_chars, to_chars ) 
    else
      normalize_filename(  filename, from_chars, to_chars )
    end

  end # end of dir.children.each do | filename |

end # end of def normalize_directory



##################################
## main

normalize_directory( Pathname.pwd )

puts "Changed #{$changed} file and directory names."

__END__
# test script
rm -fr one_two
mkdir -p one\ two/three\ four
touch one\ two/three\ four/five\ six.txt
touch one\ two/three\ four/seven\ \-\ eight\ .txt
touch one\ two/three\ four/nine\ \-\ ten\(10\)\ .txt

normalize_pathnames.rb

ls -R

