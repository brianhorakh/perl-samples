package Download;

use warnings;
use strict;

use LWP::UserAgent;
use HTTP::Request;
use Carp qw(carp);

sub new {
	my $class = shift;
	return bless {}, $class;
}

sub run {
	my $self = shift;

	return $self->api_call();
}

	
sub api_call {
	my $self = shift;

	carp "Started api_call()";

	my $url = q{http://uans.net/myip};

	my $req = HTTP::Request->new( POST => $url );
	$req->content_type('text/plain');

	$req->content('some sample content');

	my $lwp = LWP::UserAgent->new();

	my $res = $lwp->request($req);

	carp "Done api_call()";

	return;
}



1;
