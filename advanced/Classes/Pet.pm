#!/usr/bin/perl
## Pet Module using Moose

## Moose gives you strict and warnings by default

package Classes::Pet;
use Moose;

##define method for name (string)
has 'name' => (
        is => 'rw',
	    isa => 'Str',
		required => 1,
);

##define method for type (string)
has 'type' => (
        is => 'rw',
	    isa => 'Str',
		default => 1,
);

#indicate successful module load
return 1;