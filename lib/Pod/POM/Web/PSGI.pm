package Pod::POM::Web::PSGI;

use strict;
use warnings;

our $VERSION;
BEGIN {
    $VERSION = '0.001';
}

# This is not a real module: this file is run either:
# - as a PSGI application script (like .psgi)
# - as a CGI script (loaded by the PSGI application)

if (exists $ENV{'GATEWAY_INTERFACE'}) {
    # Launched as a CGI script
    require Pod::POM::Web;
    Pod::POM::Web->handler
} else {
    # Lauched as a PSGI script
    require File::Spec;
    #require CGI::Emulate::PSGI;
    #require CGI::Compile;
    require Plack::App::WrapCGI;

    # The PSGI application, returned as the last value
    Plack::App::WrapCGI->new(script => __FILE__)->to_app
}
__END__

=head1 NAME

Pod::POM::Web::PSGI - Run Pod::POM::Web as a PSGI application

=head1 SYNOPSIS

Run L<Pod::POM::Web> as a L<PSGI> application with L<plackup>:

    plackup -e 'require Pod::POM::Web::PSGI'

Load Pod::POM::Web as a PSGI application:

    my $app = require Pod::POM::Web::PSGI;

=head1 DESCRIPTION

This is a wrapper for L<Pod::POM::Web> to transform it as a L<PSGI> application.
This allow then to integrate Pod::POM::Web in a bigger web application, by
mounting it for example with L<Plack::Builder>.


Note that the current implementation is only a PSGI wrapper around
Pod::POM::Web loaded as a CGI (using L<Plack::App::WrapCGI>). This is absolutely
inefficient. So B<consider this just as a proof of concept>.

=head1 SEE ALSO

=over 4

=item *

L<Pod::POM::Web>

=item *

L<PSGI>, L<Plack>, L<Plack::Builder>

=back

=head1 AUTHOR

Olivier MenguE<eacute>, C<dolmen@cpan.org>

=head1 COPYRIGHT & LICENSE

Copyright E<copy> 2011 Olivier MenguE<eacute>.

This library is free software; you can distribute it and/or modify it
under the same terms as Perl 5 itself.

=cut
