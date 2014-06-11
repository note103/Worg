#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Chat;
use Worg::Pad;
use Worg::Tags;

package Worg {
    my @set;
    open my $fh, '<', 'data/note.md' or die $!;
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
    close $fh;

}

1;
