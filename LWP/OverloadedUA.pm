package LWP::OverloadedUA;

use warnings;
use strict;

require LWP::UserAgent;
use base qw(LWP::UserAgent);

use Time::HiRes qw( time );
use Data::Dumper;
use Carp qw(carp);

$Data::Dumper::Indent++;
$Data::Dumper::Deepcopy++;

my $REQUEST_DATA;

sub request {
	my $self    = shift;
	my $request = $_[0];

	carp "Started LWP::OverloadedUA->request()";

	my $start_time = time();

	my $response = $self->old_req(@_);

	my $end_time = time();

	$REQUEST_DATA->{'ExecutionTime'}    = sprintf q{%.4f}, $end_time - $start_time;

	$REQUEST_DATA->{'RequestURL'} = $request->uri();
	$REQUEST_DATA->{'Request'}    = $request->content();
	$REQUEST_DATA->{'Response'}   = $response->content();
	
	$REQUEST_DATA->{'RequestHeaders'}   = $request->headers();
	$REQUEST_DATA->{'ResponseHeaders'}  = $response->headers();

	$REQUEST_DATA->{'RequestContentType'}  = $request->content_type();
	$REQUEST_DATA->{'ResponseContentType'} = $response->content_type();

	
	carp "Ended LWP::OverloadedUA->request()";

	carp Dumper $REQUEST_DATA;
	
	return $response;
}
	

1;
