#!/usr/bin/perl -w

# This script operates in a similar way to the traditional cat except that it
# writes data to the designated TWiki/Web/Topic
#
# Daniel Brogan <Daniel.Brogan@kaz-group.com>
# March 2004

use LWP;
use strict;
use URI::Escape;

my ($user, $password, $silent);

# Create a sub class of LWP::UserAgent that asks for
# user/password if authentication is required.
{
   package RequestAgent;
   @RequestAgent::ISA = qw(LWP::UserAgent);

   sub new {
      my $self = LWP::UserAgent::new(@_);
      $self;
   }

   sub get_basic_credentials {
      if (!$user || !$password) {
         if (!$silent) {
            my($self, $realm, $uri) = @_;
            my $netloc = $uri->host_port;
            print "Enter username for $realm at $netloc: ";
            $user = <STDIN>;
            chomp($user);
            return (undef, undef) unless length $user;
            print "Password: ";
            system("stty -echo");
            $password = <STDIN>;
            system("stty echo");
            print "\n";  # because we disabled echo
            chomp($password);
         } else {
            die ("tcat: unable to prompt for authentication in silent mode\n");
         }
      }
      return ($user, $password);
   }
}

my $ua = RequestAgent->new(
   agent => "TWiki Cat (tcat)",
   keep_alive => 1,
   timeout => 30,
   requests_redirectable => ['GET', 'HEAD', 'POST']
);


my ($web, $topic, $parent, $url, $attach, $file, $filename, $i, $file_text);

&get_cmd_args();

if ($attach) {
   attach_resource($web,$topic,$url,$file,$filename,$file_text);
} else {
   migrate_topic($web,$topic,$url,$parent,$file,$file_text);
}


sub attach_resource {

   ############################################################################
   # SUB:      attach_resource
   #		  ($web,$parent,$url,$file,$filename,$attach_text)
   # PURPOSE:  Attaches the $file or $attach_text to the $parent topic. Uses 
   #           the TWiki mechanisms to attach the file to the topic.
   # ARGS:     $web         - the destination web
   #	       $parent      - the destination topic
   #	       $url         - the url of the TWiki server root
   #	       $file        - the file that is going to be attached [OPTIONAL]
   #	       $filename    - the destination name for the attached file, used 
   #	                      when the attach_text is read from STDIN instead 
   #	                      of being read from $file [OPTIONAL]
   #	       $attach_text - the text of the attachment [OPTIONAL]
   # RETURNS:  nothing
   ############################################################################

   my ($web,$parent,$url,$file,$filename,$attach_text) = @_;

   # get the filename from $file if not using $filename parameter
   if (!($filename)) {
      $filename = $file;
      $filename =~ s/.*\/(.*)/$1/;
   }

   # get the attach_text from $file if $file exists   
   if ($file && -e $file) {
      $attach_text = "";
      open (TEXT, $file) || die ("could not open $file.\n");
      my @text = <TEXT>;
      foreach my $line (@text) {
         $attach_text = $attach_text . $line;
      }
   }
   # attach the attach_text to the topic
   my $response = $ua->post(
      $url . "bin/upload/$web/$parent",
      ['filepath' => [
         undef,
         $filename,
         'Content' => "$attach_text"
         ],
      'filecomment' => '',
      'createlink' => '',
      'hidefile' => '',
      ],
      'Content_Type' => 'form-data',
   );

   # check if attachment worked
   if ($response->is_success) {
      $response = $ua->get($url . "pub/$web/$parent/$filename");
      print "$filename attached successfully to $web/$parent\n"
	 if ($response->is_success);
   } else {
      print "An error has occured attaching $file to $topic.\n";
      print $response->as_string();
   }
}

sub migrate_topic {
   
   ############################################################################
   # SUB:      migrate_topic
   #		  ($web,$dest_topic,$url,$topic_parent,$file,$topic_text)
   # PURPOSE:  Create a topic on the web $web called $topic based on $file or
   #           <STDIN> provided through the $topic_text variable. Uses the 
   #           TWiki mechanisms to create the topic.
   # ARGS:     $web          - the destination web
   #           $dest_topic   - the destination topic
   #           $url          - the url of the TWiki server root
   #           $topic_parent - the parent of the topic to be created
   #           $file         - the file that is going to be attached [OPTIONAL]
   #           $topic_text   - the text of the attachment [OPTIONAL]
   # RETURNS:  nothing
   ############################################################################
   
   my ($web,$dest_topic,$url,$topic_parent,$file,$topic_text) = @_;

   # get file contents if using $file and it exists
   if ($file && -e $file) {
      $topic_text = "";
      my $tmp = $/; undef $/;
      open (TEXT, $file) || die ("could not open $file.\n");
      $topic_text = <TEXT>; 
      close( TEXT );
      $/ = $tmp;

   }

   # set up POST data
   $topic_parent = uri_escape($topic_parent);
   $topic_text = uri_escape($topic_text);
   my $current_dest_url =  $url . "bin/save/$web/$dest_topic";
   my $current_post_data = 
      "cmd=&formtemplate=&topicparent=$topic_parent&text=$topic_text";
   my $request;

   # POST to TWiki
   $request = HTTP::Request->new(POST => $current_dest_url);
   $request->content($current_post_data);
   my $response = $ua->request($request);

   # check success
   if ($response->is_success) {
      $file = "<STDIN>" unless ($file);
      if ($response->title() && $response->title() =~ m/$dest_topic/) {
         print "$topic created successfully using $file.\n" unless ($silent);
      } else {
         print "An error has occured creating the $topic topic using $file.\n";
      }
   } else {
      print "An error has occured creating the $topic topic using $file.\n";
      print $response->as_string();
   }
}

sub get_cmd_args {

   ############################################################################
   # SUB:      get_cmd_args ()
   # PURPOSE:  Collects the command line options, assigns them to variables and
   #           reports/handles any errors
   # RETURNS:  nothing
   ############################################################################

   $file_text = "";
   $attach = 0;
   $silent = 0;
   for ($i = 0; $i <= $#ARGV; $i++) {
      if ($ARGV[$i] eq "-h") {
	 &usage_help();
       } elsif ($ARGV[$i] eq "-v") {
	 print "\ntcat (TWiki Cat) Version 1.0\n" .
               "Copyright 2004, KAZ Group\n" . 
               "Developed by: Daniel Brogan (Daniel.Brogan\@kaz-group.com)\n";
         exit 0;
       } elsif ($ARGV[$i] eq "-w") {
         $i++;
         $web = $ARGV[$i] if (exists($ARGV[$i]));
      } elsif ($ARGV[$i] eq "-p") {
         $i++;
         $parent = $ARGV[$i] if (exists($ARGV[$i]));
      } elsif ($ARGV[$i] eq "-t") {
         $i++;
	 $topic = $ARGV[$i] if (exists($ARGV[$i]));
      } elsif ($ARGV[$i] eq "-u") {
         $i++;
         $url = $ARGV[$i] if (exists($ARGV[$i]));
      } elsif ($ARGV[$i] eq "-n") {
         $i++;
         $filename = $ARGV[$i] if (exists($ARGV[$i]));
      } elsif ($ARGV[$i] eq "-user") {
         $i++;
         $user = $ARGV[$i] if (exists($ARGV[$i]));
      } elsif ($ARGV[$i] eq "-pass") {
         $i++;
         $password = $ARGV[$i] if (exists($ARGV[$i]));
      } elsif ($ARGV[$i] eq "-a") {
         $attach = 1;
      } elsif ($ARGV[$i] eq "-s") {
         $silent = 1;
      } else {
         $file = $ARGV[$i];
      }
   }

   # provide command line argument warnings and errors
   &usage_help("You must specify the TWiki url, the destination web and the " .
        "destination topic.\n")
   	if (!($web) || !($topic) || !($url));
   &usage_help("You must specify a name for the attachment " .
        "(-n AttachmentName) that you are attaching via STDIN.\n") 
	if (!($file) && $attach && !($filename));
   if (!($attach) && !($parent)) {
      print "You have not specified a parent, will use WebHome\n";
      $parent = "WebHome";
   }

   # check file argument exists or read from <STDIN> if none given
   if ($file) {
      die "tcat: could not find $file\n" unless (-e $file);
   } else {
      $file_text = $file_text . "$_\n" while (<STDIN>);
   }

   # check web exisists
   my $response = $ua->get($url . "bin/view/$web/WebHome");
   if (!$response->is_success()) {
      die "tcat: could not find the web $web on the TWiki server $url\n"
   }
}

sub usage_help {

   ############################################################################
   # SUB:      usage_help ($error)
   # PURPOSE:  Displays usage information and optionally displays any usage
   #           errors.
   # ARGS:     $error - optionally contains a usage error message
   # RETURNS:  exits with -1 for errors and 0 otherwise
   ############################################################################

   my ($error) = @_;
   
   print "ERROR: $error\n" if $error;	
   print "USAGE: tcat -u URL_TO_TWIKI -w WEB -t TOPICNAME [OPTIONS] [FILE]\n";
   print "if no FILE argument is given then tcat will read from <STDIN>\n\n";
   print "OPTIONS:\n";
   print "[-a] will attach the FILE or <STDIN> to TOPIC.\n";
   print "[-n NAME] specifies the filename to save the attachment as " .
	 "when reading from <STDIN>.\n";
   print "[-p PARENT] specifies the parent topic (default WebHome). Ignored " .
         "if -a option is used.\n";
   print "[-user TWIKI_UID] specifies the TWiki user id if authentication " .
         "is required.\n";
   print "[-pass PASSWORD] specifies the password used if authentication " . 
          "is required.\n\n";
   print "EXAMPLES:\n";
   print "tcat -u http://localhost/ -w Sandbox -t MyTopic -a document.txt\n";
   print "cat smoke.txt | tcat -u http://localhost/twiki/ -w Main -t " .
         "SmokingPolicy -p HrPolicies\n";
   print "grep -r ohs* /HR/ | tcat -u http://localhost/twiki/ -w Main -t " . 
         "OhsPolicy -a -n SearchResults.txt\n";
   $error ? exit -1 : exit 0;
}
