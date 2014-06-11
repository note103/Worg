#!/usr/bin/env perl
use strict;
use warnings;

package Hands {
    my $msg = "Please input 'v[iew]' or 'm[emo]' or 'q[uit]'.\n";
    sub set {
        print "$msg";
        while (my $switch = <>) {
            if ($switch =~ /^(v|view)$/) {
                view();
                print "$msg";
            } elsif ($switch =~ /^(m|memo)$/) {
                memo();
                print "$msg";
            } elsif ($switch =~ /^(t|task)$/) {
                task();
                print "$msg";
            } elsif ($switch =~ /^(q|quit)$/) {
                last;
            } else {
                print "$msg";
            }
        }
    }
    sub view {
        open my $fh, '<', 'data/work.md' or die $!;
        while (my $eyes = <$fh>) {
            next if $. == 1;
            print "$eyes";
            last if $eyes =~ /^-->$/;
        }
    }
    sub memo {
        open my $fh, '<', 'data/bucket.md' or die $!;
        while (my $eyes = <$fh>) {
            print "$eyes";
        }
        print "Write something or input 'end' and press enter.\n";
        while (my $hands = <>) {
        open my $fh2, '>>', 'data/bucket.md' or die $!;
            print $fh2 "$hands";
            last if $hands =~ /^end$/;
        close $fh2;
        }
        close $fh;
    }
}

1;

