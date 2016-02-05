use strict;
use warnings;
use Test::More;
use Test::Exception;

BEGIN {
    use_ok( 'SMS::Send' );
    use_ok( 'SMS::Send::BR::Facilitamovel');
}

throws_ok sub { my $sender = SMS::Send->new('BR::Facilitamovel') },
    qr/_login missing/,
    'sender construction without _login and _password throws exception';

throws_ok sub { my $sender = SMS::Send->new('BR::Facilitamovel',
    _login => 'foo' ) },
    qr/_password missing/,
    'sender construction without _password throws exception';

throws_ok sub { my $sender = SMS::Send->new('BR::Facilitamovel',
    _password => 'foo' ) },
    qr/_login missing/,
    'sender construction without _login throws exception';

ok(
    my $sender = SMS::Send->new('BR::Facilitamovel',
        _login    => 'foo',
        _password => 'bar',
    ), 'sender construction ok'
);

done_testing;

