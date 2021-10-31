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
    $r->get('/')->to('Example#welcome');
    $r->post('/')->to("Example#index");
    $r->options('/');
}

1;
