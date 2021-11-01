use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('TestApp');
$t->get_ok('/read')->status_is(200);
$t->post_ok('/create')->status_is(200);
$t->post_ok('/update')->status_is(200);
$t->post_ok('/delete')->status_is(200);

done_testing();
