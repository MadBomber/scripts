#!/usr/bin/env perl
use strict;
use File::Find;
use Getopt::Long;
                  
my $directory = 0;
my $search = 0; 
my @jars;
my $jar_exe = 'jar';
my $ignore = 0;
my $current = 0;
my $zip = 0;
my $eclipse = 0;
my %src;



sub gather_properties {
#gather the properties required
    my $help = 0;
    GetOptions ('help' => \$help, 'directory=s'=>\$directory, 'search=s'=>\$search, 'jar=s' =>\$jar_exe,
    'ignore_case' => \$ignore,'current_jar' =>\$current, 'zip' =>\$zip, 'eclipse' => \$eclipse);
    if ( $help ) {
      print <<END;

Use this script to hunt down classes that may be in some jar file. Use as the example dictates:
jar_search.pl -directory . -search MyClass

jar search will find every jar file in the directory (and it will recurse through the subdirectories and 'jar -tvf' the jar).
It will list the jars it finds that contain the search parameter.

Notes:  If your directory has spaces put it in quotes (ex: -directory "D:\Program Files").
        If your system cannot find the jar executable please tell the script via -jar D:\\java\\jar.exe
        Want to ignore case?  Add in the -ignore_case flag.
        Want to see the current jar the script is examining? Add in -current_jar.
        Want to search .zip files too?  Add in -zip.
	Want to search for multiple java file (i.e. Foo.java and Faa.java)  Do so like this: -search "Foo|Faa"
        Feel free to shorten the options to the minimum string needed for uniqueness (-directory becomes -d).
END

        exit 0;
    }
    #print "$directory -- $search \n";
}

sub build_jar_list {
  unless (-d $File::Find::name) {
     if (($File::Find::name =~ /\.jar$/) || (($zip) && ($File::Find::name =~ /\.zip$/))) {
        find_matches($File::Find::name) unless $eclipse;
	#print "<classpathentry kind=\"lib\" path=\"$File::Find::name\"/>\n" if $eclipse;
     }
     if ($eclipse && ($File::Find::name =~ /\/src\/main/)) {
     	$src{$`}++;
  }
  
 }
}

sub display_project() {
  local $_;
  foreach (keys %src) {
    my @parts = split (/\//,$_);
    my $name = pop (@parts);
    print "<link>\n";
    print "  <name>$name</name>\n";
    print "  <type>2</type>\n";
    print "  <location>$_/src/main</location>\n";
    print "</link>\n";
  }

}

sub find_matches($) {
   my $jar = shift;
   if ($current) {
      print "Examining $jar";
   }
   my @jar_data = `$jar_exe -tvf \"$jar\"` ;
   #("D:\Program Files\IBM\WebSphere Studio\Application Developer\v5.1.2\runtimes\base_v51\lib/wlmclient.jar");
   # `$jar_exe -tvf $jar` || warn "$!\n";
   chomp @jar_data;
   my @matching;
   if ($ignore) {
      @matching = grep {/$search/i} @jar_data;
   } else {
      @matching = grep {/$search/} @jar_data;
   }
   if ($#matching > -1) {
      print "Found the following matches in $jar:\n";
      print join ("\n",@matching);
      print "\n\n";
      return
   }
   print " -- NO MATCHES!!\n" if ($current);
}

gather_properties();
if ($directory && ($search || $eclipse)) { 
   find({wanted => \&build_jar_list,
         no_chdir => 1},$directory);
}
display_project() if $eclipse;
