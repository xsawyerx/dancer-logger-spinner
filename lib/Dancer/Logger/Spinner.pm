use strict;
use warnings;
package Dancer::Logger::Spinner;
# ABSTRACT: Show a spinner in the console on Dancer log messages!

use base 'Dancer::Logger::Abstract';

sub init {
    my $self = shift;
    $self->{'spinner_chars'} = [ '\\', '|', '/', '-', 'x' ];
    $self->{'spinner_count'} = 0;
}

sub _log {
    my $self = shift;
    $self->advance_spinner();
}

sub advance_spinner {
    my $self  = shift;
    my $count = $self->{'spinner_count'};
    my @chars = @{ $self->{'spinner_chars'} };

    # these chars lifted from Brandon L. Black's Term::Spinner
    print STDERR "\010 \010";
    print STDERR $chars[$count];

    # if we reached over the array end, let's get back to the start
    ++$count > $#chars and $count = 0;

    # increment the counter and update the hash
    $self->{'spinner_count'} = $count;
}

sub DESTROY {
    print STDERR "\n";
}

1;

__END__

