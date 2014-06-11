#!/usr/bin/env perl

use strict;
use warnings;
use lib 'lib';
use Worg;
use Worg::Chat;
use Worg::Pad;
use Worg::Tags;
use Worg::Hands;
use Date;
use Ex2hash;

my $msg = "Input 'p' or 'c' or 'd' or 'e' or 'h'.\n";
print "$msg";
my $again = "\nAnything else? \n$msg";
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
    } elsif ($in =~ /^(d)$/) {
        Date::date();
        print "$again";
    } elsif ($in =~ /^(e)$/) {
        Ex2hash::run();
        print "$again";
    } elsif ($in =~ /^(h)$/) {
        Hands::set();
        print "$again";
    } elsif ($in =~ /^(q)$/) {
        print "Bye bye!\n";
        last;
    } else {
        print "\nPlease select correct one.\n"
    }
}

sub out {
    open my $fh, '>>', 'data/bucket.md' or die $!;
    print $fh "\n-->>\n";
    for my $line (@$bar) {
        print $fh "$line";
    }
    print $fh "<<--\n";
    close $fh;
}

__END__

# TODO
* タグがカブって抽出されるのを治したい 2014/06/11 01:17
