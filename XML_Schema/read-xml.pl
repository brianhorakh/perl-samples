#!/usr/bin/perl

=head2 DESCRIPTION

	Example of reading xml using schema

=cut

use warnings;
use strict;

use Data::Dumper;

use XML::Compile::Schema;
use XML::Compile::Util qw( pack_type );

my $schema = XML::Compile::Schema->new();

# https://channel.despegar.com/v1/hotels/schema
$schema->importDefinitions( "xsd/despegar-schema.xsd" );

# $schema->printIndex();

my $ns     = 'http://www.despegar.com/hotels/ota/v1/';
my $method = 'OTA_HotelDescriptiveInfoRS';
my $type   = pack_type $ns, $method;


my $read   = $schema->compile(READER => $type);
my $data   = $read->("xml/OTA_HotelDescriptiveInfoRS.xml");


print Dumper $data;

exit 0;

