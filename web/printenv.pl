#!perl

use strict;
use CGI;

cgi_webpage();

sub cgi_webpage {
    my $page = CGI->new;
    
    print $page->header("text/html");
    print $page->start_html("SimplePerl website");
    print $page->h1("HTTP environment:<br/><br/>");
    for my $var ( sort keys %ENV ) {
         printf "%s = \"%s\"<br\>", $var, $ENV{$var};
    }
    print $page->end_html;
};
