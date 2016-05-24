#!/usr/bin/perl

use DBI;
use strict;

my $driver   = "Pg"; 

# Get our configuration information
if (my $err = ReadCfg('pg-basic.conf')) {
    print(STDERR $err, "\n");
    exit(1);
}
my $dsn = "DBI:$driver:dbname=$CFG::CFG{'server'}{'database'};host=$CFG::CFG{'server'}{'hostname'};port=$CFG::CFG{'server'}{'port'}";
#print "database: ". $CFG::CFG{'server'}{'database'} ."\n";

my $dbh = DBI->connect($dsn, $CFG::CFG{'server'}{'user'}, $CFG::CFG{'server'}{'password'}, { RaiseError => 1 }) 
                      or die $DBI::errstr;

print "Opened database successfully\n\n";
RunSelect($dbh);
RunUpdate($dbh);

print "\nClosing database connection\n";
$dbh->disconnect();

# Read a configuration file
#   The arg can be a relative or full path, or
#   it can be a file located somewhere in @INC.
sub ReadCfg
{
    my $file = $_[0];

    our $err;

    {   # Put config data into a separate namespace
        package CFG;

        # Process the contents of the config file
        my $rc = do($file);

        # Check for errors
        if ($@) {
            $::err = "ERROR: Failure compiling '$file' - $@";
        } elsif (! defined($rc)) {
            $::err = "ERROR: Failure reading '$file' - $!";
        } elsif (! $rc) {
            $::err = "ERROR: Failure processing '$file'";
        }
    }

    return ($err);
}
sub RunSelect {
    my $dbh = $_[0];
	
    my $stmt = qq(SELECT id, firstname, lastname, email FROM contact WHERE active=b'1' ORDER BY id;); 
    my $sth = $dbh->prepare( $stmt );
    my $rv = $sth->execute() or die $DBI::errstr;
    if($rv < 0){
       print $DBI::errstr;
    }
    while(my @row = $sth->fetchrow_array()) {
          print "|id:". $row[0] ."|firstname:". $row[1] ."|lastname:". $row[2] ."|email:". $row[3] ."|\n";
    }
}
sub RunUpdate {
    my $dbh = $_[0];
	
    my $stmt = qq(UPDATE contact SET email='wbwiltshire\@hotmail.com' WHERE id=20;);
	my $rv = $dbh->do($stmt) or die $DBI::errstr;
    if( $rv < 0 ){
       print $DBI::errstr;
    }else{
       print "Total number of rows updated : $rv\n";
    }
	
	print "\n";
	RunSelect($dbh);
	print "\n";	

    $stmt = qq(UPDATE contact SET email='Elon\@Tesla.com' WHERE id=20;);
	$rv = $dbh->do($stmt) or die $DBI::errstr;
    if( $rv < 0 ){
       print $DBI::errstr;
    }else{
       print "Total number of rows updated : $rv\n";
    }
		
	print "\n";
	RunSelect($dbh);
	print "\n";	
}