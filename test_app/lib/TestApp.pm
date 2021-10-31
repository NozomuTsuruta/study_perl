package TestApp;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup ($self) {

    # Load configuration from config file
    my $config = $self->plugin('NotYAMLConfig');

    # Configure the application
    $self->secrets( $config->{secrets} );

    # Router
    $self->plugin('SecureCORS');
    my $r = $self->routes->to( 'cors.origin' => '*' );

    # Normal route to controller
    $r->get('/read')->to('Example#read');
    $r->post('/create')->to("Example#create");
    $r->post('/update')->to("Example#update");
    $r->post('/delete')->to("Example#delete");
    $r->options('/');
}

1;
