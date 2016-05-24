#!/usr/bin/perl
## Commands::Radio Module

use strict;
use warnings;
use feature 'say';

##Give the module a namespace using the package keyword
package Commands::Radio;

sub On 
{	
	say "The radio is now on";
		
	#return true if worked
	return 1;
}

sub Play 
{
    #unpack song
    my $song = $_[0];
	
	#Print a message to indicate the radio is playing
	say "the radio is now playing '" .$song ."'";
		
	#return true if worked
	return 1;
}

sub Off 
{
	say "The radio is now off";
		
	#return true if worked
	return 1;

}

##signify that module loaded successfully 
return 1;