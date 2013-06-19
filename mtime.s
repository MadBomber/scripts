find /usr/lib/perl5 -name 'CGI.pm' | ruby -ne 'puts File.mtime("#{$_}").to_s + " " + $_'



