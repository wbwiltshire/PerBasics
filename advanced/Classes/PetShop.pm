#!/usr/bin/perl
## PetShop Module using Moose

## Moose gives you strict and warnings by default

package Classes::PetShop;
use Moose;
use Classes::Pet;

##define methods which for an array of strings
 has 'pets' => (
        is => 'rw',
	    isa => 'ArrayRef[Classes::Pet]',
		auto_deref => 1
);

#indicate successful module load
return 1;