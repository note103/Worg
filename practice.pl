#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use Worg;
use Worg::Chat;
use Worg::Pad;
use Worg::Tags;
use Worg::Notes;

my $msg = "Input (p|c|e|n|q).\n";
print "$msg";
my $again = "\nAnything else?\n$msg";
my $bar;
while (my $in = <>) {
    if ($in =~ /^(c|p)$/) {
        if ($1 =~ /^(c)$/) {
            $bar = Worg::chat();
            out();
            print "$again";
        } elsif ($1 =~ /^(p)$/) {
            $bar = Worg::pad();
            out();
            print "$again";
        }
    } elsif ($in =~ /^(n)$/) {
        Notes::set();
        print "$again";
    } elsif ($in =~ /^(q)$/) {
        print "Bye bye!\n";
        last;
    } else {
        print "\nPlease select correct one.\n"
    }
}

sub out {
    open my $fh, '>', 'data/out.md' or die $!;
    print $fh "-->>\n";
    for my $line (@$bar) {
        print $fh "$line";
    }
    print $fh "<<--\n";
    close $fh;
}
