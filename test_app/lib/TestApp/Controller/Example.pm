package TestApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::Headers;
use Data::Dumper;

# This action will render a template
sub welcome ($self) {

    # Render template "example/welcome.html.ep" with message
    $self->render(
        msg => 'Welcome to the Mojolicious real-time web framework!' );
}

sub index {
    my $self    = shift;
    my $headers = Mojo::Headers->new;
    $headers = $headers->access_control_allow_origin('https://example.com');

    my $name  = $self->req->param("name");
    my $email = $self->req->param("email");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { name => $name, email => $email } );
}

1;
