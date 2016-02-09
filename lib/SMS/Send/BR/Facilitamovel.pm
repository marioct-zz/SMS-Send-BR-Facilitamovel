use strict;
use warnings;

package SMS::Send::BR::Facilitamovel;

$SMS::Send::BR::Facilitamovel::VERSION = '0.02';

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
            'accept' => 'text/html; charset=ISO-8859-1',
            'content-type' => 'text/html; charset=ISO-8859-1',
        },
        timeout => 3,
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
