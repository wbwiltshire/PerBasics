#!/usr/bin/perl
## User Module using Moose

## Moose gives you strict and warnings by default

package Classes::User;
use DateTime;
use Moose;
use feature 'say';

extends 'Classes::Person';

##define method for firstname (string)
has 'password' => (
        is => 'rw',
	    isa => 'Str',
);

##define method for lastname (string)
has 'lastLogin' => (
        is => 'rw',
	    isa => 'DateTime',
		handles => { 'lastLoginDate' => 'date' },
);

sub login {
  #get first two parameters
  my $self = shift;
  my $pw = shift;
  
  return 0 if $pw ne $self->password;
  $self->lastLogin( DateTime->now() );
  say "Login successful!";
  return 1;
}
#indicate successful module load
return 1;