#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;
use Worg::Common;

package Chat {
    sub run {
        my $in = shift;
        my @dhm;
        my $time = '\d\d?:\d\d?';
        my $time_local = 'time';
        my $day = '\D+';
        my $num = '\d\d?';
        for my $dhm (@$in) {
            if ($dhm =~ /^\[($time)\] (.+): (.*)$/) {
                $time_local = $1;
                push @dhm, "today\t$1\t\t#mob$3\n";
            } elsif ($dhm =~ /^\[($time)\] (.+): (.*)$/) {
                $time_local = $1;
                push @dhm, "today\t$1\t\t#mob$3\n";
            } elsif ($dhm =~ /^\[($num)月-($num) ($time)\] (.+): (.*)$/) {
                $time_local = $3;
                push @dhm, "$1/$2\t$3\t\t#mob$5\n";
            } elsif ($dhm =~ /^\s+($day)($num)月 ($num), (\d{4})$/) {
                push @dhm, "$4/$2/$3\t$1\n";
            } elsif ($dhm =~ /\[\[($day)($num)月 ($num), (\d{4})\]\]$/) {
                push @dhm, "$4/$2/$3\t$1\n";
            } elsif ($dhm =~ /^\[($num)月-($num) ($time)\] (.+): (.*)$/) {
                $time_local = $3;
                push @dhm, "$1/$2\t$3\t\t#mob$5\n";
            } elsif ($dhm =~ /^\s+($num)月-.+($time)$/) {
                $time_local = $2;
                push @dhm, "";
            } elsif ($dhm =~ /^$/) {
                push @dhm, "";
            } elsif ($dhm =~ /^\s+(.*)$/) {
                push @dhm, "\t$time_local\t\t#mob$1\n";
            } elsif ($dhm =~ /\n/) {
                push @dhm, "";
            } else {
                push @dhm, "\t$time_local\t\t#mob$dhm\n";
            }
        }
        my @dhmx;
        my ($lastdate, $year);
        my $ymd = '\d{4}\/\d\d?\/\d\d?';
        for my $day2en (@dhm) {
            if ($day2en =~ /^((\d{4})\/\d\d?\/\d\d?)\t(.+)$/){
                $lastdate = $1;
                $year = $2;
                if ($day2en =~ /^($ymd)\t日曜日 $/){
                        push @dhmx, "\n# $1\tSunday\n\n";
                } elsif ($day2en =~ /^($ymd)\t月曜日 $/){
                        push @dhmx, "\n# $1\tMonday\n\n";
                } elsif ($day2en =~ /^($ymd)\t火曜日 $/){
                        push @dhmx, "\n# $1\tTuesday\n\n";
                } elsif ($day2en =~ /^($ymd)\t水曜日 $/){
                        push @dhmx, "\n# $1\tWednesday\n\n";
                } elsif ($day2en =~ /^($ymd)\t木曜日 $/){
                        push @dhmx, "\n# $1\tTursday\n\n";
                } elsif ($day2en =~ /^($ymd)\t金曜日 $/){
                        push @dhmx, "\n# $1\tFriday\n\n";
                } elsif ($day2en =~ /^($ymd)\t土曜日 $/){
                        push @dhmx, "\n# $1\tSaturday\n\n";
                }
            } else {
                push @dhmx, "$day2en";
            }
        }
        my $extract = Common::core(\@dhmx);
        my @date_stamp;
        if (defined $lastdate) {
            for my $date_out (@$extract) {
                if ($date_out =~ /^(today)(.+)$/) {
                    push @date_stamp, "$lastdate$2\n";
                } elsif ($date_out =~ /^(\d\d?\/\d\d?)(.+)$/) {
                    push @date_stamp, "$year\/$1$2\n";
                } else {
                    push @date_stamp, "$date_out";
                }
            }
        } else {
            for my $date_out (@$extract) {
                push @date_stamp, "$date_out";
            }
        }
        Common::treat(\@date_stamp);
    }
}

1;
