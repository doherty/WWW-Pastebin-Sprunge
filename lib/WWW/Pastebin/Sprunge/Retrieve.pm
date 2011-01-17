use strict;
use warnings;

package WWW::Pastebin::Sprunge::Retrieve;
# ABSTRACT: retrieves pastes from the sprunge.us pastebin

use URI;
use base 'WWW::Pastebin::Base::Retrieve';

=head1 SYNOPSIS

    use strict;
    use warnings;
    use WWW::Pastebin::Sprunge::Retrieve;

    my $paster = WWW::Pastebin::Sprunge::Retrieve->new();

    my $content = $paster->retrieve('http://sprunge.us/84Pc') or die $paster->error();

    print $content;

=head1 DESCRIPTION

The module provides interface to retrieve pastes from
L<http://sprunge.us> website via Perl.

=cut

sub _make_uri_and_id {
    my $self = shift;
    my $in   = shift;

    my $id;
    if ( $in =~ m{ (?:http://)? (?:www\.)? sprunge.us/ (\S+?) (?:\?\w+)? $}ix ) {
        $id = $1;
    }
    $id = $in unless (defined $id);

    return ( URI->new("http://sprunge.us/$id"), $id );
}

sub _parse {
    my $self    = shift;
    my $content = shift;
    my $id      = $self->id;

    if (!defined($content) or !length($content)) {
        return $self->_set_error('Nothing to parse (empty document retrieved)');
    }
    elsif ($content eq "$id not found") {
        return $self->_set_error('No such paste');
    }
    else {
        $self->results($content);
        return $self->results($content);
    }
}

sub content {
    my $self = shift;

    return $self->results;
}


=head1 METHODS

=head2 C<new>

    my $paster = WWW::Pastebin::Sprunge::Retrieve->new();

    my $paster = WWW::Pastebin::Sprunge::Retrieve->new(
        timeout => 10,
    );

    my $paster = WWW::Pastebin::Sprunge::Retrieve->new(
        ua => LWP::UserAgent->new(
            timeout => 10,
            agent   => 'PasterUA',
        ),
    );

Constructs and returns a new WWW::Pastebin::Sprunge::Retrieve object.
Takes two arguments, both are I<optional>. Possible arguments are
as follows:

=head3 C<timeout>

    ->new( timeout => 10 );

B<Optional>. Specifies the C<timeout> argument of L<LWP::UserAgent>'s
constructor, which is used for retrieving. B<Defaults to:> C<30> seconds.

=head3 C<ua>

    ->new( ua => LWP::UserAgent->new( agent => 'Foos!' ) );

If the C<timeout> argument is not enough for your needs, feel free
to specify the C<ua> argument which takes an L<LWP::UserAgent> object
as a value. B<Note:> the C<timeout> argument to the constructor will
not do anything if you specify the C<ua> argument as well. B<Defaults to:>
plain boring default L<LWP::UserAgent> object with C<timeout> argument
set to whatever C<WWW::Pastebin::Sprunge::Retrieve>'s C<timeout> argument is
set to as well as C<agent> argument is set to mimic Firefox.

=head2 C<retrieve>

    my $content = $paster->retrieve('http://sprunge.us/SCLg') or die $paster->error();

    my $content = $paster->retrieve('SCLg') or die $paster->error();

Instructs the object to retrieve a paste specified in the argument. Takes
one mandatory argument which can be either a full URI to the paste you
want to retrieve or just its ID.

On failure returns either C<undef> or an empty list depending on the context
and the reason for the error will be available via C<error()> method.
On success, returns the pasted text.

=head2 C<error>

    $paster->retrieve('SCLg')
        or die $paster->error;

On failure C<retrieve()> returns either C<undef> or an empty list depending
on the context and the reason for the error will be available via C<error()>
method. Takes no arguments, returns an error message explaining the failure.

=head2 C<id>

    my $paste_id = $paster->id;

Must be called after a successful call to C<retrieve()>. Takes no arguments,
returns a paste ID number of the last retrieved paste irrelevant of whether
an ID or a URI was given to C<retrieve()>

=head2 C<uri>

    my $paste_uri = $paster->uri;

Must be called after a successful call to C<retrieve()>. Takes no arguments,
returns a L<URI> object with the URI pointing to the last retrieved paste
irrelevant of whether an ID or a URI was given to C<retrieve()>

=head2 C<results>

    my $last_results_ref = $paster->results;

Must be called I<after> a successful call to C<retrieve()>. Takes no arguments,
returns the exact same string as the last call to C<retrieve()> returned.
See C<retrieve()> method for more information.

=head2 C<content>

    my $paste_content = $paster->content;

    print "Paste content is:\n$paster\n";

Must be called after a successful call to C<retrieve()>. Takes no arguments,
returns the actual content of the paste. B<Note:> this method is overloaded
for this module for interpolation. Thus you can simply interpolate the
object in a string to get the contents of the paste.

=head2 C<ua>

    my $old_LWP_UA_obj = $paster->ua;

    $paster->ua( LWP::UserAgent->new( timeout => 10, agent => 'foos' );

Returns a currently used L<LWP::UserAgent> object used for retrieving
pastes. Takes one optional argument which must be an L<LWP::UserAgent>
object, and the object you specify will be used in any subsequent calls
to C<retrieve()>.

=cut

1;

__END__
