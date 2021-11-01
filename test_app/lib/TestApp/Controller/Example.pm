package TestApp::Controller::Example;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::Headers;
use Data::Dumper;
use DBI;

our $DB_NAME = "test";
our $DB_USER = "postgres";
our $DB_PASS = "";
our $DB_HOST = "127.0.0.1";
our $DB_PORT = "5432";

sub read {
    my $self = shift;
    my $dbh =
      DBI->connect( "dbi:Pg:dbname=$DB_NAME;host=$DB_HOST;port=$DB_PORT",
        "$DB_USER", "$DB_PASS" )
      or die "$!\n Error: failed to connect to DB.\n";
    my $sth = $dbh->prepare("SELECT * FROM todos;");
    $sth->execute();

    my $ary_ref = $sth->fetchrow_arrayref();

    # my ( $a, $b ) = @$ary_ref;
    $sth->finish();
    $dbh->disconnect();

    $self->render( json => $ary_ref );
}

sub create {
    my $self = shift;
    my $text = $self->req->param("text");
    print $text;
    my $dbh =
      DBI->connect( "dbi:Pg:dbname=$DB_NAME;host=$DB_HOST;port=$DB_PORT",
        "$DB_USER", "$DB_PASS" )
      or die "$!\n Error: failed to connect to DB.\n";
    my $sth = $dbh->prepare("INSERT INTO todos(text) VALUES(?);");
    $sth->execute($text);
    $sth = $dbh->prepare("SELECT * FROM todos;");
    $sth->execute();
    my $ary_ref = $sth->fetchrow_arrayref();
    $sth->finish();
    $dbh->disconnect();

    $self->render( json => $ary_ref );
}

sub update {
    my $self = shift;

    my $id   = $self->req->param("id");
    my $text = $self->req->param("text");

    my $dbh =
      DBI->connect( "dbi:Pg:dbname=$DB_NAME;host=$DB_HOST;port=$DB_PORT",
        "$DB_USER", "$DB_PASS" )
      or die "$!\n Error: failed to connect to DB.\n";
    my $sth = $dbh->prepare("UPDATE todos SET text=? WHERE id=?;");
    $sth->execute( $text, $id );
    $sth = $dbh->prepare("SELECT * FROM todos;");
    $sth->execute();
    my $ary_ref = $sth->fetchrow_arrayref();
    $sth->finish();
    $dbh->disconnect();

    $self->render( json => $ary_ref );
}

sub delete {
    my $self = shift;

    my $id = $self->req->param("id");

    my $dbh =
      DBI->connect( "dbi:Pg:dbname=$DB_NAME;host=$DB_HOST;port=$DB_PORT",
        "$DB_USER", "$DB_PASS" )
      or die "$!\n Error: failed to connect to DB.\n";
    my $sth = $dbh->prepare("DELETE FROM todos WHERE id=?;");
    $sth->execute($id);
    $sth = $dbh->prepare("SELECT * FROM todos;");
    $sth->execute();
    my $ary_ref = $sth->fetchrow_arrayref();
    $sth->finish();
    $dbh->disconnect();

    $self->render( json => $ary_ref );
}

1;
