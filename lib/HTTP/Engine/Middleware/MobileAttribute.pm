package HTTP::Engine::Middleware::MobileAttribute;
use HTTP::Engine::Middleware;
use HTTP::MobileAttribute;

middleware_method 'mobile_attribute' => sub {
    my $self = shift;
    $self->{mobile_attribute} ||= HTTP::MobileAttribute->new( $self->headers );
};

__MIDDLEWARE__

__END__

=head1 NAME

HTTP::Engine::Middleware::MobileAttribute - wrapper for HTTP::MobileAttribute

=head1 SYNOPSIS

    my $mw = HTTP::Engine::Middleware->new({method_class => 'HTTP::Engine::Request'});
    $mw->install(qw/ HTTP::Engine::Middleware::MobileAttribute /);
    HTTP::Engine->new(
        interface => {
            module => 'YourFavoriteInterfaceHere',
            request_handler => $mw->handler( \&handler ),
        }
    )->run();

=head1 DESCRIPTION

This module injects one method named 'mobile_attribute'.
This method returns the instance of HTTP::MobileAttribute.

=head1 AUTHORS

Tokuhiro Matsuno

=head1 SEE ALSO

L<HTTP::MobileAttribute>

=cut
