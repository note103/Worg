#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;

package Chat {
    sub run {
        my (@port, @lines);
        my $tags = Tags::tags();
        my $day = '\D+';
        my $num = '\d\d?';
        my $time = '\d\d:\d\d';
        my $user = 'Hiroaki Kadomatsu|note103'; #個別に書き換え
        my $status = 'task|done|start|stop';
        my $catch_time = 'catch';
        
        my $in = shift;
        for my $line (@$in) {
            if ($line =~ /^\[($time)\] ($user): (.*)($status)(.*)$/) {
                $catch_time = $1;
                push @lines, "today\t$1\t\t\t\t$4\t$3$4$5\n";
            } elsif ($line =~ /^\[($time)\] ($user): (.*)$/) {
                $catch_time = $1;
                push @lines, "today\t$1\t\t\t\t\t$3\n";
            } elsif ($line =~ /^\[($num)月-($num) ($time)\] ($user): (.*)($status)(.*)$/) {
                $catch_time = $3;
                push @lines, "$1/$2\t$3\t\t\t\t$6\t$5$6$7\n";
            } elsif ($line =~ /^\s+($day)($num)月 ($num), (\d{4})$/) {
                push @lines, "$4/$2/$3\t$1\n";
            } elsif ($line =~ /\[\[($day)($num)月 ($num), (\d{4})\]\]$/) {
                push @lines, "$4/$2/$3\t$1\n";
            } elsif ($line =~ /^\[($num)月-($num) ($time)\] ($user): (.*)$/) {
                $catch_time = $3;
                push @lines, "$1/$2\t$3\t\t\t\t\t$5\n";
            } elsif ($line =~ /^\s+($num)月-.+($time)$/) {
                $catch_time = $2;
                push @lines, "";
            } elsif ($line =~ /^$/) {
                push @lines, "";
            } elsif ($line =~ /^\s+(.*)($status)(.*)$/) {
                push @lines, "\t$catch_time\t\t\t\t$2\t$1$2$3\n";
            } elsif ($line =~ /^\s+(.*)$/) {
                push @lines, "\t$catch_time\t\t\t\t\t$1\n";
            } elsif ($line =~ /\n/) {
                push @lines, "";
            } else {
                push @lines, "\t$catch_time\t\t\t\t\t$line\n";
            }
        }
        
        #set tags, people, rate
        my (@lines2, @lines3, @lines4);
        my ($lastday, $year);
        my $date = '\d{4}\/\d\d?\/\d\d?';
        
        for my $line2 (@lines) {
            my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($tags)(.*)\$";
            if ($line2 =~ /^((\d{4})\/\d\d?\/\d\d?)\t(.+)$/){
                $lastday = $1;
                $year = $2;
                if ($line2 =~ /^($date)\t日曜日 $/){
                        push @lines2, "\n# $1\tSunday\n\n";
                } elsif ($line2 =~ /^($date)\t月曜日 $/){
                        push @lines2, "\n# $1\tMonday\n\n";
                } elsif ($line2 =~ /^($date)\t火曜日 $/){
                        push @lines2, "\n# $1\tTuesday\n\n";
                } elsif ($line2 =~ /^($date)\t水曜日 $/){
                        push @lines2, "\n# $1\tWednesday\n\n";
                } elsif ($line2 =~ /^($date)\t木曜日 $/){
                        push @lines2, "\n# $1\tTursday\n\n";
                } elsif ($line2 =~ /^($date)\t金曜日 $/){
                        push @lines2, "\n# $1\tFriday\n\n";
                } elsif ($line2 =~ /^($date)\t土曜日 $/){
                        push @lines2, "\n# $1\tSaturday\n\n";
                }
            } elsif ($line2 =~ /${key}/i) {
                my $next1 = "$1\t$7\t$3\t$4\t$5\t$6$8\n";
                my $out1 = "$1\t$7\t$3\t$4\t$5\t$6$7$8\n";
                my $word = "$6$7$8";
                if ($next1 =~ /${key}/i) {
                    my $next2 = "$1\t$2,$7\t$3\t$4\t$5\t$6$8\n";
                    my $out2 = "$1\t$2,$7\t$3\t$4\t$5\t$word\n";
                    if ($next2 =~ /${key}/i) {
                        my $next3 = "$1\t$2,$7\t$3\t$4\t$5\t$6$8\n";
                        my $out3 = "$1\t$2,$7\t$3\t$4\t$5\t$word\n";
                        if ($next3 =~ /${key}/i) {
                            my $next4 = "$1\t$2,$7\t$3\t$4\t$5\t$6$8\n";
                            my $out4 = "$1\t$2,$7\t$3\t$4\t$5\t$word\n";
                            if ($next4 =~ /${key}/i) {
                                my $next5 = "$1\t$2,$7\t$3\t$4\t$5\t$6$8\n";
                                my $out5 = "$1\t$2,$7\t$3\t$4\t$5\t$word\n";
                                if ($next5 =~ /${key}/i) {
                                    my $out6 = "$1\t$2,$7\t$3\t$4\t$5\t$word\n";
                                    push @lines2, "$out6";
                                } else {
                                    push @lines2, "$out5";
                                }
                            } else {
                                push @lines2, "$out4";
                            }
                        } else {
                            push @lines2, "$out3";
                        }
                    } else {
                        push @lines2, "$out2";
                    }
                } else {
                    push @lines2, "$out1";
                }
            } else {
                push @lines2, "$line2";
            }
        }
        
        my $people = Tags::people();
        for my $line3 (@lines2) {
            my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($people)(.*)\$";
            if ($line3 =~ /${key}/i) {
                my $next1 = "$1\t$2\t$7\t$4\t$5\t$6$8\n";
                my $out1 = "$1\t$2\t$7\t$4\t$5\t$6$7$8\n";
                my $word = "$6$7$8";
                if ($next1 =~ /${key}/i) {
                    my $next2 = "$1\t$2\t$3, $7\t$4\t$5\t$6$8\n";
                    my $out2 = "$1\t$2\t$3, $7\t$4\t$5\t$word\n";
                    if ($next2 =~ /${key}/i) {
                        my $out3 = "$1\t$2\t$3, $7\t$4\t$5\t$word\n";
                        push @lines3, "$out3";
                    } else {
                        push @lines3, "$out2";
                    }
                } else {
                    push @lines3, "$out1";
                }
            } else {
                push @lines3, "$line3";
            }
        }
        
        my $rate = 'best|good';
        for my $line4 (@lines3) {
            my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($rate)(.*)\$";
            if ($line4 =~ /${key}/i) {
                my $next1 = "$1\t$2\t$3\t$7\t$5\t$6$8\n";
                my $out1 = "$1\t$2\t$3\t$7\t$5\t$6$7$8\n";
                my $word = "$6$7$8";
                if ($next1 =~ /${key}/i) {
                    my $next2 = "$1\t$2\t$3\t$4, $7\t$5\t$6$8\n";
                    my $out2 = "$1\t$2\t$3\t$4, $7\t$5\t$word\n";
                    if ($next2 =~ /${key}/i) {
                        my $out3 = "$1\t$2\t$3\t$4, $7\t$5\t$word\n";
                        push @lines4, "$out3";
                    } else {
                        push @lines4, "$out2";
                    }
                } else {
                    push @lines4, "$out1";
                }
            } else {
                push @lines4, "$line4";
            }
        }
        
        #output
        my @line5;
        if (defined $lastday) {
            for my $output (@lines4) {
                if ($output =~ /^(today)(.+)$/) {
                    push @line5, "$lastday$2\n";
                } elsif ($output =~ /^(\d\d?\/\d\d?)(.+)$/) {
                    push @line5, "$year\/$1$2\n";
                } else {
                    push @line5, "$output";
                }
            }
        } else {
            for my $output (@lines4) {
                push @line5, "$output";
            }
        }
        
        my @line6;
        for my $line5 (@line5) {
            if ($line5 =~ s/#($status|$tags)//gi) {
                    push @line6, "$line5";
            } elsif ($line5 =~ /^([^\=]*)(======)(.*)$/) {
                    push @line6, "$1\[maintenance\]maintenance\n";
            } else {
                push @line6, "$line5";
            }
        }
        
        my @ex;
        for my $ex (@line6) {
            if ($ex =~ /^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]+)$/) {
                my $next = $ex;
                if ($next =~ /^([^\t]*)\t([^\t]*)\t(.+)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]+)$/) {
                    push @ex, "* $2\t[$3]$7";
                } else {
                    push @ex, "* $2\t$7";
                }
            } else {
                push @ex, "$ex";
            }
        }
        
        for my $last (@ex) {
            if ($last =~ /(.+) +$/ ) {
                push @port, "$1\n";
            } else {
                push @port, "$last";
            }
        }
        return \@port;
    }
}

1;
