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
    sub done {
        return Done::run($set);
    }
    sub slack {
        return Slack::run($set);
    }
    sub rewrite {
        return Rewrite::run($set);
    }
    close $fh;

}

1;
