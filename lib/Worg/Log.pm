#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;
use Worg::Common;

package Log {
    sub run {
        my $in = shift;
        my (@dhmx, @tags, @people);
        my $tags_common = Tags::tags();
        my $ymd = '\d{4}\/\d\d?\/\d\d?';
        my $time = '\d\d?:\d\d?';
        my $time_local = 'time';
        for my $dhm (@$in) {
            if ($dhm =~ /^(\# .+)$/) {
                push @dhmx, "\n$1\n\n";
            } elsif ($dhm =~ /^\* (\d\d?:\d\d)\t\[(.+)\](.+)$/) {
                my ($t, $in_tags, $c) = ($1, $2, $3);
                my $separate_tags;
                if ($in_tags =~ /^((.+),)+(.+)$/) {
                    my @separate = split /,/, $1;
                    my @separate2;
                    for (@separate) {
                        push @separate2, "#$_";
                    }
                    my $separate = join '', @separate2;
                    $separate_tags = "$separate#$3";
                } else {
                    $separate_tags = "#$in_tags";
                }
                push @dhmx, "\t$t\t\t$separate_tags$c\n";
            } elsif ($dhm =~ /^\* (\d\d?:\d\d)\t(.+)$/) {
                push @dhmx, "\t$1\t\t$2\n";
            } else {
                push @dhmx, "";
            }
        }
        my $extract = Common::core(\@dhmx);
        Common::treat($extract);
    }
}

1;



