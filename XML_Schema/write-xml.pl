#!/usr/bin/perl

=head2 DESCRIPTION

	Example of creating xml using schema

=cut

use warnings;
use strict;

use XML::Compile::Schema;
use XML::Compile::Util qw( pack_type );

my $schema = XML::Compile::Schema->new();

# https://channel.despegar.com/v1/hotels/schema
$schema->importDefinitions( "xsd/despegar-schema.xsd" );

# $schema->printIndex();

my $ns     = 'http://www.despegar.com/hotels/ota/v1/';
my $method = 'OTA_HotelDescriptiveInfoRQ';
my $type   = pack_type $ns, $method;

# To print hash schema:
# print $schema->template(PERL => $type);

my $hash = { 
  Version => "1.0",
  HotelDescriptiveInfos =>  { 
    HotelDescriptiveInfo =>  { 
      HotelCode => "98765", 
    }, 
  },
};

#############################################################

# create and use a writer
my $doc    = XML::LibXML::Document->new('1.0', 'UTF-8');
my $write  = $schema->compile( WRITER => $type );
my $xml    = $write->($doc, $hash);
$doc->setDocumentElement($xml);
 
# show result
print $doc->toString(1);


exit 0;

