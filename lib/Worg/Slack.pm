#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;
use Worg::Common;

package Slack {
    sub run {
        my $in = shift;
        my (@dhmx, @dhmx2);
        my $tags_common = Tags::tags();
        my $time = '\d\d?:\d\d?';
        my $time_local = 'time';
        my $user = 'user';
        for my $dhm (@$in) {
            if ($dhm =~ /^(\S+) \[($time)\] ?$/) {
                $time_local = $2;
                $user = $1;
            } elsif ($dhm =~ /^----- ([^ ,]+),? (\S+) (\d+)(\D+), (\d{4}) -----$/) {
                my $day = $1;
                my $month = $2;
                my $date = $3;
                my $year = $5;
                if ($month =~ s/January/1/) {
                } elsif ($month =~ s/September/9/) {
                } elsif ($month =~ s/October/10/) {
                } elsif ($month =~ s/November/11/) {
                }
                push @dhmx, "\n# $year/$month/$date\t$day\n\n";
            } elsif ($dhm =~ /^\[($time)\] *?$/) {
                $time_local = $1;
            } elsif ($dhm =~ /^(kadomatsu|ak) *?$/) {
                $user = $1;
            } elsif ($dhm =~ /^(.+)$/) {
                push @dhmx, "\t$time_local\t\t$user: $1\n";
            } else {
                push @dhmx, "";
            }
        }
        my $extract = Common::core(\@dhmx);
        Common::treat($extract);
    }
}

1;


