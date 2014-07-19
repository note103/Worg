#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use Worg;
use Worg::Chat;
use Worg::Pad;
use Worg::Log;
use Worg::Tags;

my $msg = "Input (p[ad]|c[hat]|l[og]|q[uit]).";
print "$msg\n";
my $again = "\nAnything else?\n$msg\n";
my $bar;
while (my $in = <>) {
    if ($in =~ /^(p|pad|c|chat|l|log)$/) {
        if ($1 =~ /^(c|chat)$/) {
            $bar = Worg::chat();
        } elsif ($1 =~ /^(p|pad)$/) {
            $bar = Worg::pad();
        } elsif ($1 =~ /^(l|log)$/) {
            $bar = Worg::log();
        }
        out();
        last;
    } elsif ($in =~ /^(q|quit)$/) {
        print "Bye bye!\n";
        last;
    } else {
        print "\nPlease select correct one.\n"
    }
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
