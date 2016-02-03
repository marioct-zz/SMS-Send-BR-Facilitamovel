package SMS::Send::Facilitamovel;

use 5.018001;
use strict;
use warnings;
use LWP::UserAgent;
use URI::Escape;

use parent qw(SMS::Send::Driver);

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use SMS::Send::Facilitamovel ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';


# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

SMS::Send::Facilitamovel - An SMS::Send driver for the www.facilitamovel.com.br service

=head1 VERSION
 
Version 0.01

=head1 SYNOPSIS
 
    # create the sender object
    my $sender = SMS::Send::->new('Facilitamovel',
        _username => 'username',
        _password  => 'password',
    );
    # send a message
    my $sent = $sender->send_sms(
        text    => 'You message may use up to 160 chars',
        to'     => '+49 555 4444', # always use the intl. calling prefix
    );
     
    if ( $sent ) {
        print "Sent message\n";
    } else {
        print "Failed to send test message\n";
    }

=head1 DESCRIPTION

L<SMS::Send::Facilitamovel> is an brazilian L<SMS::Send> driver for
the www.facilitamovel.com.br service. It is a paid service which offers very competitive
prices.

=head2 EXPORT

None by default.

=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Mario Celso Teixeira, marioct37@gmail.com

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2016 by Mario Celso Teixeira

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.18.1 or,
at your option, any later version of Perl 5 you may have available.


=cut
