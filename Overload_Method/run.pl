#!perl

use warnings;
use strict;
use Carp qw(confess carp);

use Download;
use LWP::OverloadedUA;

no strict 'subs';
no strict 'refs';
no warnings 'redefine';

$INC{'LWP::UserAgent.pm'}  = 1;
$LWP::UserAgent::VERSION ||= -1;

*LWP::UserAgent::old_req = \&LWP::UserAgent::request;

*LWP::UserAgent::request = \&LWP::OverloadedUA::request;

my $obj = Download->new();

$obj->run();

exit 0;

