#!/usr/bin/env perl
use strict;
use warnings;

package Notes {
    my $msg = "Please input 'v[iew]' or 'm[emo]' or 'q[uit]'.\n";
    my $msg2 = "Please input 'i[n]' or 'o[ut]', 'q[uit]'.\n";
    sub set {
        print "$msg";
        while (my $switch = <>) {
            if ($switch =~ /^(v|view)$/) {
                view();
                print "$msg";
            } elsif ($switch =~ /^(m|memo)$/) {
                memo();
                print "$msg";
            } elsif ($switch =~ /^(q|quit)$/) {
                last;
            } else {
                print "$msg";
            }
        }
    }
    sub view {
        print "$msg2";
        while (my $switch = <>) {
            if ($switch =~ /^(i|in)$/) {
                open my $fh, '<', 'data/in.md' or die $!;
                while (my $eyes = <$fh>) {
                    print "$eyes";
                }
            } elsif ($switch =~ /^(o|out)$/) {
                open my $fh, '<', 'data/out.md' or die $!;
                while (my $eyes = <$fh>) {
                    print "$eyes";
                }
            } elsif ($switch =~ /^(q|quit)$/) {
                last;
            } else {
                print "$msg2";
            }
            print "$msg2";
        }
    }
    sub memo {
        open my $fh, '<', 'data/out.md' or die $!;
        while (my $eyes = <$fh>) {
            print "$eyes";
        }
        print "Write something or input 'end' and press enter.\n";
        while (my $hands = <>) {
        open my $fh2, '>>', 'data/out.md' or die $!;
            if ($hands =~ /^end$/) {
                print "Bye!\n";
                last;
            } else {
                print $fh2 "$hands";
            }
        close $fh2;
        }
        close $fh;
    }
}

1;

