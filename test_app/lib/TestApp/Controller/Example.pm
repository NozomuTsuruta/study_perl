package TestApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::Headers;
use Data::Dumper;

sub read ($self) {
    my $self = shift;

    my $id   = $self->req->param("id");
    my $text = $self->req->param("text");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { id => $id, text => $text } );
}

sub create {
    my $self = shift;

    my $id   = $self->req->param("id");
    my $text = $self->req->param("text");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { id => $id, text => $text } );
}

sub update {
    my $self = shift;

    my $id   = $self->req->param("id");
    my $text = $self->req->param("text");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { id => $id, text => $text } );
}

sub delete {
    my $self = shift;

    my $id   = $self->req->param("id");
    my $text = $self->req->param("text");

    # my $params_hash = $self->req->params->to_hash;
    $self->render( json => { id => $id, text => $text } );
}

1;
