#!/usr/bin/env perl
use strict;
use warnings;

package Worg {
    my @set;
    open my $fh, '<', 'data/in.md' or die $!;
    for my $line (<$fh>) {
        push @set, $line;
    }
    my $set = \@set;
    sub chat {
        return Chat::run($set);
    }
    sub pad {
        return Pad::run($set);
    }
    sub log {
        return Log::run($set);
    }
    close $fh;

}

1;
