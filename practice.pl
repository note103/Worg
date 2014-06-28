#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use Worg;
use Worg::Chat;
use Worg::Pad;
use Worg::Tags;

my $msg = "Input (p[ad]|c[hat]|q[uit]).";
print "$msg\n";
my $again = "\nAnything else?\n$msg\n";
my $bar;
while (my $in = <>) {
    if ($in =~ /^(p|pad|c|chat)$/) {
        if ($1 =~ /^(c|chat)$/) {
            $bar = Worg::chat();
        } elsif ($1 =~ /^(p|pad)$/) {
            $bar = Worg::pad();
        }
        out();
    } elsif ($in =~ /^(q|quit)$/) {
        print "Bye bye!\n";
        last;
    } else {
        print "\nPlease select correct one.\n"
    }
    last;
}

sub out {
    open my $fh, '>>', 'data/out.md' or die $!;
    print $fh "-->>\n";
    for my $line (@$bar) {
        print $fh "$line";
    }
    print $fh "<<--\n";
    print "done!!\n";
    close $fh;
}
