#!/usr/bin/perl
##Two good Introduction to Perl articles:
##   1) Learn Perl in about 2 hours 30 minutes: https://qntm.org/files/perl/perl.html
##   2) Modern Perl: https://pragprog.com/book/swperl/modern-perl-fourth-edition
##And the Perldoc library: http://perldoc.perl.org/
##
## Packages, Modules, and Object Oriented Perl (Moose) are advanced topics

use strict;
use warnings;
use feature 'say';

# Get our configuration information
if (my $err = ReadCfg('basics.conf')) {
    print(STDERR $err, "\n");
    exit(1);
}

print "name: ". $CFG::CFG{'profile'}{'name'} ."\n";
say "email: "  .$CFG::CFG{'profile'}{'email'};
say "";

### Variables
## Scalar (number, string, and boolean equivalent
my $undef = undef;         # equivalent to null
my $undef2;                # default to null
my $num = 10.5;
my $string = "10.5";

## Weak object typing.  Will treate as a string and a float/integer
print "addition: " .($num + $string) ."\n";
print "concat: " .$num .$string ."\n";

##booleans don't exist
##variable equates to false in the following conditions:
## 1) undef
## 2) number 0
## 3) string ""
#$ 4) string "0"
my $true = 1;
my $false = "0";
if ($true) {
    say "true";
	if ($false) {
	    say "true";
	}
	else {
	    say "false";
	}
}

##operators help determine type
if ($num == $string) {
    say "they're numerically equal";
}
else {
    say "numerically they're not equal";
}
if ($num eq $string) {
    say "they're equal strings";
}
else {
    say "the strings aren't equal";
}
say "";

##arrays use the @ symbol and trailing comma is OK
my @list = ( "banannas", "apples", "oranges", "cherries", );
say $list[0];
print $list[3] ."\n";
print "This array has " .(scalar @list) ." elements\n"; # "This array has 4 elements"
say "The last populated index is ".$#list;              # "The last populated index is 5"
say "Be careful with the \@ in a quoted string";
##push, pop, shift, unshift are used to modify the array
say pop @list;
push @list, "peaches";
say @list;
say shift @list;

##hash variables use the % symbol and represent key/value pairs
my %teams = ( "Bucaneers" => "Football", "Rays" => "Baseball", "Lightning" => "Hockey" );
say "The Rays are a ".$teams{"Rays"} ." team";
my @teams = %teams;                                    # convert to an array
say "@teams";
say scalar reverse "@teams";

##references
my $color = "Orange";
my $scalarRef = \$color;
say "color: " .$color;
say "reference color: " .${ $scalarRef };            # print what's at the reference

##data structures
my %account = (
	"number" => "31415926",
	"opened" => "2016-01-01",
	"owners" => [
		{
			"name" => "Mickey Mouse",
			"DOB"  => "1934-10-20",
		},
		{
			"name" => "Minnie Mouse",
			"DOB"  => "1938-08-11",
		},
	],
);
say "account nbr: " .$account{"number"};
say "owner #1: " .$account{"owners"}->[0]->{"name"};

##conditionals and ternary operators
### short if statement
my $word = "Thisisaverylongword";
say "'", $word, "' is actually enormous" if length $word >= 10;

### ternary operator
my $gain = 48;
say "You gained ", $gain, " ", ($gain == 1 ? "experience point" : "experience points"), "!";

##loops
### next and last are the equivalent of continue and break
my $i = 0;
while ($i < scalar @list) {
  say $i, ": ", $list[$i];
  $i++;
}

foreach my $str ( @list ) {
    say $str;
}

for (my $i = 0; $i < scalar @list; $i++) {
  say $i, ": ", $list[$i];
}

##Subroutines
my $ret = ReadTextFile('basics.conf');

###Beginning of subroutines and functions
# Read a configuration file
#   The arg can be a relative or full path, or
#   it can be a file located somewhere in @INC.
sub ReadCfg
{
    #unpack the argument passed (e.g. filename)
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

sub ReadTextFile 
{
    #unpack file name
    my $file = $_[0];
	
	#Print a message, if the file doesn't exist
	say "file doesn't exist" unless -e $file;
	
	#open file for input
    my $result = open my $fh, "<", $file;

    if(!$result) {
	    die "Couldn't open '".$file."' for reading because: ".$!;
    }
	
    while(!eof $fh) {
	    my $line = readline $fh;
		#truncate the line break;
	    chomp $line;
		say $line;
    }
	
	#file closes automatically when we leave scope, but close file anyway
	close $fh;
	
	#return true if worked
	return 1;
}