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

## require keyword indicates to load a module
require Commands::Radio;

Commands::Radio::On();
Commands::Radio::Play("My Italian Restaurant");
Commands::Radio::Off();

say "";
use Classes::Pet;
use Classes::PetShop;

my $buster = Classes::Pet->new (
    name => 'Buster', 
	type => 'cat'
);

my $spot = Classes::Pet->new (
    name => 'Spot',
	type => 'dog'
);	
my $petShop = Classes::PetShop->new (
		pets => [ $buster, $spot ]
    ); 

my $pets = $petShop->pets;
#say "The pet shop has [@$pets].";
say "The pet shop has [",
    join(" ", map { $_->type } $petShop->pets ),
	"].";
	
use Classes::User;

my $user = Classes::User->new (
  firstname => 'Bill',
  lastname => 'Gates',
  password => 'Microsoft',
);

$user->login('Microsoft');
say "last login: " .$user->lastLoginDate;