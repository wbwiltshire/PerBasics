#!/usr/bin/perl
## Person Module using Moose

## Moose gives you strict and warnings by default

package Classes::Person;
use Moose;

##define method for firstname (string)
has 'fisttname' => (
        is => 'rw',
	    isa => 'Str',
);

##define method for lastname (string)
has 'lastname' => (
        is => 'rw',
	    isa => 'Str',
);

#indicate successful module load
return 1;