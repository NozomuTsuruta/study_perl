package TestApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::Headers;
use Data::Dumper;

sub read ($self) {
    my $self = shift;

    my $name  = $self->req->param("name");
    my $email = $self->req->param("email");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { name => $name, email => $email } );
}

sub create {
    my $self = shift;

    my $name  = $self->req->param("name");
    my $email = $self->req->param("email");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { name => $name, email => $email } );
}

sub update {
    my $self = shift;

    my $name  = $self->req->param("name");
    my $email = $self->req->param("email");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { name => $name, email => $email } );
}

sub delete {
    my $self = shift;

    my $name  = $self->req->param("name");
    my $email = $self->req->param("email");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { name => $name, email => $email } );
}

1;
