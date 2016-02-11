use strict;
use warnings;

package SMS::Send::BR::Facilitamovel;

$SMS::Send::BR::Facilitamovel::VERSION = '0.03';

# ABSTRACT: SMS::Send driver for the Facilita Movel SMS service

use Carp;
use HTTP::Tiny;
use URI::Escape qw( uri_escape );

use base 'SMS::Send::Driver';

sub new {
    my $class = shift;
    my $self = { @_ };

    $self->{$_}
        or croak "$_ missing"
            for qw( _login _password );

    return bless $self, $class;
}

sub send_sms {
    my ($self, %args) = @_;

    my $http = HTTP::Tiny->new(
        default_headers => {

            # to ensure the response is JSON and not the XML default
            'accept'       => 'text/html; charset=ISO-8859-1',
            'content-type' => 'text/html; charset=ISO-8859-1',
        },
        timeout    => 3,
        verify_ssl => 1,
    );

    # remove leading +
    ( my $recipient = $args{to} ) =~ s/^\+//;

    my $message = $args{text};

    my $response = $http->post(
        'https://www.facilitamovel.com.br/api/simpleSend.ft'
        . '?user='
        . uri_escape( $self->{_login} )
        . '&password='
        . uri_escape( $self->{_password} )
        . '&destinatario='
        . uri_escape( $recipient )
        . '&msg='
        . uri_escape( $message )
    );

    # for example a timeout error
    die $response->{content}
        unless $response->{success};

    my @response_message = split /[;]+/, $response->{content};

    return 1
        if $response_message[0] != "6";

    $@ = @response_message;

    return 0;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

SMS::Send::BR::Facilitamovel - SMS::Send driver for the Facilita Movel service

=head1 VERSION

version 0.03

=head1 SYNOPSIS

    use SMS::Send;
    my $sender = SMS::Send->new('BR::Facilitamovel',
        _login    => 'foo',
        _password => 'bar',
    );

    my $sent = $sender->send_sms(
        'text'    => 'This is a test message',
        'to'      => '19991913030',
    );

    # Did the send succeed.
    if ( $sent ) {
        print "Message sent ok\n";
    } else {
        print 'Failed to send message: ', $@->{error_content}, "\n";
    }

=head1 DESCRIPTION

This module currently uses the L<HTTP API|https://www.facilitamovel.com.br>.

=head1 METHODS

=head2 send_sms

It is called by L<SMS::Send/send_sms> and passes all arguments starting with an
underscore to the request having the first underscore removed as shown in the
SYNOPSIS above.

It returns true if the message was successfully sent.

It returns false if an error occurred and $@ is set to a hashref of the following info:

    {
        statusCode      => "...",
        MessageId       => "...",
    }

It throws an exception if a fatal error like a http timeout in the underlying
connection occurred.

=head1 AUTHOR

Mario Celso Teixeira <marioct37@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) CPqD 2016 by Mario Celso Teixeira.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
