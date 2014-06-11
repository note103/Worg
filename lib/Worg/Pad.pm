#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;

package Pad {
    sub run {
        my @port;
        my $tags = Tags::tags();
        my $in = shift;
        my (@line, @line2, @line3, @line4);
        my $time = 'time';
        for my $line (@$in) {
            if ($line =~ /^(\*\*\*|<!--|-->)$/) {
                push @line2, "\n>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n\n";
            } elsif ($line =~ /^\> (.+) (.+)$/) {
                push @line2, "# $1\t$2\n\n";
            } elsif ($line =~ /^(\d{4}\/\d\d?\/\d\d?) (.+)$/) {
                push @line2, "$1\t\t$2\t\t\t\t\n";
            } elsif ($line =~ /^(\d\d?:\d\d?:?\d?\d?)$/) {
                $time = $1;
                push @line2, "\t$1\t\t\t\t\t\n";
            } elsif ($line =~ /^(.+)(\d{4}\/\d\d?\/\d\d?) (\d\d?:\d\d?:?\d?\d?)$/) {
                $time = $3;
                push @line2, "$2\t$3\t\t\t\tdone\t$1\n";
            } elsif ($line =~ /^(.+)(\d{4}\/\d\d?\/\d\d?)$/) {
                push @line2, "$2\t$time\t\t\t\tdone\t$1\n";
            } elsif ($line =~ /^(.*?)(\d\d?:\d\d?:?\d?\d?)$/) {
                $time = $2;
                push @line2, "\t$2\t\t\t\tdone\t$1\n";
            } elsif ($line =~ /^(.+)$/) {
                push @line2, "\t$time\t\t\t\tdone\t$1\n";
            } else {
                push @line2, "";
            }
        }
        
        for my $line2 (@line2) {
            my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($tags)(.*)\$";
            if ($line2 =~ /${key}/i) {
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
                                    push @line3, "$out6";
                                } else {
                                    push @line3, "$out5";
                                }
                            } else {
                                push @line3, "$out4";
                            }
                        } else {
                            push @line3, "$out3";
                        }
                    } else {
                        push @line3, "$out2";
                    }
                } else {
                    push @line3, "$out1";
                }
            } else {
                push @line3, "$line2";
            }
        }
        
        my $people = Tags::people();
        for my $line3 (@line3) {
            my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($people)(.*)\$";
            if ($line3 =~ /${key}/i) {
                my $next1 = "$1\t$2\t$7\t$4\t$5\t$6$8\n";
                my $out1 = "$1\t$2\t$7\t$4\t$5\t$6$7$8\n";
                my $word = "$6$7$8";
                if ($next1 =~ /${key}/i) {
                    my $next2 = "$1\t$2\t$3,$7\t$4\t$5\t$6$8\n";
                    my $out2 = "$1\t$2\t$3,$7\t$4\t$5\t$word\n";
                    if ($next2 =~ /${key}/i) {
                        my $out3 = "$1\t$2\t$3,$7\t$4\t$5\t$word\n";
                        push @line4, "$out3";
                    } else {
                        push @line4, "$out2";
                    }
                } else {
                    push @line4, "$out1";
                }
            } else {
                push @line4, "$line3";
            }
        }
        
        my @line5;
        my $rate = 'best|good';
        for my $line4 (@line4) {
            my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)($rate)(.*)\$";
            if ($line4 =~ /${key}/i) {
                my $next1 = "$1\t$2\t$3\t$7\t$5\t$6$8\n";
                my $out1 = "$1\t$2\t$3\t$7\t$5\t$6$7$8\n";
                my $word = "$6$7$8";
                if ($next1 =~ /${key}/i) {
                    my $next2 = "$1\t$2\t$3\t$4,$7\t$5\t$6$8\n";
                    my $out2 = "$1\t$2\t$3\t$4,$7\t$5\t$word\n";
                    if ($next2 =~ /${key}/i) {
                        my $out3 = "$1\t$2\t$3\t$4,$7\t$5\t$word\n";
                        push @line5, "$out3";
                    } else {
                        push @line5, "$out2";
                    }
                } else {
                    push @line5, "$out1";
                }
            } else {
                push @line5, "$line4";
            }
        }
        
        my @line6;
        for my $line5 (@line5) {
            if ($line5 =~ s/#($tags)//gi) {
                    push @line6, "$line5";
            } else {
                push @line6, "$line5";
            }
        }
        
        my @ex;
        for my $ex (@line6) {
            if ($ex =~ /^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]+)$/) {
                my $next = $ex;
                if ($next =~ /^([^\t]*)\t([^\t]*)\t(.+)\t([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]+)$/) {
                    push @ex, "* $2\t[done,$3]$7";
                } else {
                    push @ex, "* $2\t[done]$7";
                }
            } else {
                push @ex, "$ex";
            }
        }
        
        my @ex2;
        for my $last (@ex) {
            if ($last =~ /(.+) +$/ ) {
                push @ex2, "$1\n";
            } else {
                push @ex2, "$last";
            }
        }
        
        for my $last2 (@ex2) {
            if ($last2 =~ /(.+) +$/ ) {
                push @port, "$1\n";
            } else {
                push @port, "$last2";
            }
        }
        return \@port;
    }
}

1;


