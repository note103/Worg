#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use Worg;
use Worg::Chat;
use Worg::Done;
use Worg::Slack;
use Worg::Rewrite;
use Worg::Tags;

my $msg = "Input (c[hat]|d[one]|s[lack]|r[ewrite]|q[uit]).";
print "$msg\n";
my $again = "\nAnything else?\n$msg\n";
my $bar;
while (my $in = <>) {
    if ($in =~ /^(c|chat|d|done|s|slack|r|rewrite)$/) {
        if ($1 =~ /^(c|chat)$/) {
            $bar = Worg::chat();
        } elsif ($1 =~ /^(d|done)$/) {
            $bar = Worg::done();
        } elsif ($1 =~ /^(s|slack)$/) {
            $bar = Worg::slack();
        } elsif ($1 =~ /^(r|rewrite)$/) {
            $bar = Worg::rewrite();
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
    print $fh "\n<<--\n\n";
    print "done!!\n";
    close $fh;
}
