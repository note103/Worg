#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;
use Worg::Common;
use DDP;

package Done {
    sub run {
        my $in = shift;
        my (@dhmx, @tags, @people);
        my $tags_common = Tags::tags();
        my $ymd = '\d{4}[\/-]\d\d?¥\/-]\d\d?';
        my $time = '\d\d?:\d\d?';
        my $time_local = 'time';
        for my $dhm (@$in) {
            if ($dhm =~ /^\#\# (.+) ?(.*)$/) {
                push @dhmx, "\n# $1\t$2\n\n";
            } elsif ($dhm =~ /^  (.+)$/) {
                push @dhmx, "\t\t\t$1\n";
            } elsif ($dhm =~ /^(.+)($ymd) ($time):?\d?\d?$/) {
                $time_local = $3;
                push @dhmx, "$2\t$3\t\t$1\n";
            } elsif ($dhm =~ /^(.+)($ymd)$/) {
                push @dhmx, "$2\t$time_local\t\t$1\n";
            } elsif ($dhm =~ /^(.*?)($time):?\d?\d?$/) {
                $time_local = $2;
                push @dhmx, "\t$2\t\t$1\n";
            } elsif ($dhm =~ /^(.+)$/) {
                push @dhmx, "\t$time_local\t\t$1\n";
            } else {
                push @dhmx, "";
            }
        }
        my $extract = Common::core(\@dhmx);
        Common::treat($extract);
    }
}

1;


