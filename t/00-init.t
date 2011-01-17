use strict;
use warnings;
use Test::More tests => 12;

BEGIN {
    use_ok('Carp');
    use_ok('URI');
    use_ok('LWP::UserAgent');
    use_ok('HTTP::Request::Common');
    use_ok('Class::Data::Accessor');
    use_ok('WWW::Pastebin::Base::Retrieve');
    use_ok('WWW::Pastebin::Sprunge::Retrieve');
    use_ok('WWW::Pastebin::Sprunge::Create');
}

my $writer = new_ok('WWW::Pastebin::Sprunge::Create');
my $reader = new_ok('WWW::Pastebin::Sprunge::Retrieve');

can_ok($writer, qw(
    new
    paste
    paste_uri
    ua
    _make_request_args
    _set_error
) );


can_ok($reader, qw(
    new
    retrieve
    error
    content
    results
    ua
    uri
    id
    _make_uri_and_id
    _parse
    _get_was_successful
    _set_error
) );
