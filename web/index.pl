#!perl

use strict;
use CGI;

#manual_webpage();
cgi_webpage();

sub cgi_webpage {
    my $page = CGI->new;
    
    print $page->header("text/html");
    print $page->start_html("SimplePerl website");
    print $page->h1("Welcome to the SimplePerl website");
    print $page->end_html;
};

sub manual_webpage {
    print "Content-type:text/html\n\n"; 
    print "<!DOCTYPE html><html>";
    print "<head>";  
    print "    <title>SimplePerl website</title>";
    print "</head>";
    print "    <body><h1>Welcome to the SimplePerl website<h1></body>";
    print "</html>";
}

