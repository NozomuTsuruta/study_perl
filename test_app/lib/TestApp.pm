package TestApp;
use Mojo::Base 'Mojolicious', -signatures;

# This method will run once at server start
sub startup ($self) {
    our $DB_NAME = "test";
    our $DB_USER = "postgres";
    our $DB_PASS = "";
    our $DB_HOST = "127.0.0.1";
    our $DB_PORT = "5432";

    # Load configuration from config file
    my $config = $self->plugin('NotYAMLConfig');

    # Configure the application
    $self->secrets( $config->{secrets} );

    # Router
    $self->plugin('SecureCORS');
    my $r = $self->routes->to( 'cors.origin' => '*' );
    my $dbh =
      DBI->connect( "dbi:Pg:dbname=$DB_NAME;host=$DB_HOST;port=$DB_PORT",
        "$DB_USER", "$DB_PASS" )
      or die "$!\n Error: failed to connect to DB.\n";
    $dbh->do(
        "CREATE TABLE IF NOT EXISTS todos (
			id int(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
			text varchar(255) NOT NULL
	        ) ENGINE=InnoDB;"
    );

    # Normal route to controller
    $r->get('/read')->to('Example#read');
    $r->post('/create')->to("Example#create");
    $r->post('/update')->to("Example#update");
    $r->post('/delete')->to("Example#delete");
    $r->options('/');
}

1;
