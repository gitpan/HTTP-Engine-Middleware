package HTTP::Engine::Middleware::Role::Logger;
use Mouse::Role;

has 'logger' => (
    is       => 'rw',
    isa      => 'CodeRef',
    required => 1,
    default  => sub { sub {} },
);

sub log {
    my ($self, $msg) = @_;
    $self->logger->( $msg );
}

1;

