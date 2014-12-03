#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;
use 5.012;

package Common {
    my $tags_common = Tags::tags();
    sub core {
        my @tags;
        my @temp;
        my $dhmx = shift;
        for my $tags (@$dhmx) {
            my $key = "\^([^\t]*\t[^\t]*)\t([^\t]*)\t([^\t]*)($tags_common)(.*)\$";
            if ($tags =~ /${key}/i) {
                my $next1 = "$1\t$4\t$3$5\n";
                my $out1 = "$1\t$4\t$3$4$5\n";
                my $word = "$3$4$5";
                if ($next1 =~ /${key}/i) {
                    my $next2 = "$1\t$2,$4\t$3$5\n";
                    my $out2 = "$1\t$2,$4\t$word\n";
                    if ($next2 =~ /${key}/i) {
                        my $next3 = "$1\t$2,$4\t$3$5\n";
                        my $out3 = "$1\t$2,$4\t$word\n";
                        if ($next3 =~ /${key}/i) {
                            my $next4 = "$1\t$2,$4\t$3$5\n";
                            my $out4 = "$1\t$2,$4\t$word\n";
                            if ($next4 =~ /${key}/i) {
                                my $next5 = "$1\t$2,$4\t$3$5\n";
                                my $out5 = "$1\t$2,$4\t$word\n";
                                if ($next5 =~ /${key}/i) {
                                    my $out6 = "$1\t$2,$4\t$word\n";
                                    push @tags, "$out6";
                                } else {
                                    push @tags, "$out5";
                                }
                            } else {
                                push @tags, "$out4";
                            }
                        } else {
                            push @tags, "$out3";
                        }
                    } else {
                        push @tags, "$out2";
                    }
                } else {
                    push @tags, "$out1";
                }
            } else {
                push @tags, "$tags";
            }
        }
        my @extract;
        for my $extract (@tags) {
            if ($extract =~ s/#($tags_common)//gi) {
                    push @extract, "$extract";
            } else {
                push @extract, "$extract";
            }
        }
        return \@extract;
    }
    sub treat {
        my $extract = shift;
        my $tags_change = Tags::change_tags();
        my @tags_treat;
        for my $extract_tag (@$extract) {
            if ($extract_tag =~ /^([^\t]*)\t([^\t]*)\t([^\t]*)\t([^\t]+)$/) {
                my $next = $extract_tag;
                if ($next =~ /^([^\t]*)\t([^\t]*)\t([^\t]+)\t([^\t]+)$/) {
                    my $lcstr = lc($3);
                    my @tags_all = split /,/, $lcstr;
                    my (@uqxs,@uqx,@uqn);
                    for my $tags_all (@tags_all) {
                        if ($tags_all =~ /{$tags_change}/) {
                            push @uqxs, $tags_all;
                        } else {
                            push @uqn, $tags_all;
                        }
                    }
                    @uqx = map {Tags::change_words()->{$_}} @uqxs;
                    my $synthe = join ',', @uqx, @uqn;
                    my @synthe = split /,/, $synthe;
                    my %hash  = map { $_, 1 } @synthe;
                    my @unique = sort keys %hash;
                    my $uqstr = join ',', @unique;
                    push @tags_treat, "* $2\t[$uqstr]$4";
                } else {
                    push @tags_treat, "* $2\t$4";
                }
            } else {
                push @tags_treat, "$extract_tag";
            }
        }
        my @port;
        for my $cut_endwhite (@tags_treat) {
            if ($cut_endwhite =~ /(.+) +$/ ) {
                push @port, "$1\n";
            } else {
                push @port, "$cut_endwhite";
            }
        }
        my @autolink;
        for my $autolink (@port) {
            if ($autolink =~ s/([^\<\>"])((http:|https:)[^ \s]+)/$1<a href = "$2" target="_blank">$2<\/a>/g ) {
                push @autolink, "$autolink";
            } else {
                push @autolink, "$autolink";
            }
        }
        my @anchor;
        for my $anchor (@autolink) {
            if ($anchor =~ /^(\D*)\# ((\d{4})[\/-](\d\d?)[\/-](\d\d?))(\D*)$/) {
                push @anchor, "$1\# $3-$4-$5\<a name=\"$2\"\>\<\/a\>$6";
            } else {
                push @anchor, "$anchor";
            }
        }
        my @index;
        for my $index (@anchor) {
            if ($index =~ /\# (\d{4})[\/-](\d\d?)[\/-](\d\d?)/) {
                push @index, "[$1/$2/$3](\#$1-$2-$3)<br>\n";
            } else {
                push @index, "";
            }
        }

        my @reindex = reverse @index;
        my @blank = ("\n");
        my @convert = (@anchor, @blank, @reindex);

        my @cut_tail_blank;
        for my $cut_tail_blank (@convert) {
            if ($cut_tail_blank =~ s/[ \t]*$//g) {
                push @cut_tail_blank, "$cut_tail_blank";
            } else {
                push @cut_tail_blank, "$cut_tail_blank";
            }
        }

        my @replace_blank;
        for my $replace_blank (@cut_tail_blank) {
            if ($replace_blank =~ s/　/ /g) {
                push @replace_blank, "$replace_blank";
            } else {
                push @replace_blank, "$replace_blank";
            }
        }

        my @re_date;
        my $ymd = 'ymd';
        for my $re_date (@replace_blank) {
            if ($re_date =~ /\# (\d{4})[\/-](\d\d?)[\/-](\d\d?)(.*)/) {
                $ymd = "$1-$2-$3";
                push @re_date, $re_date;
            } elsif ($re_date =~ /^\* (\d\d:\d\d)[ \t](.*)$/) {
                push @re_date, "* $ymd $1\t$2\n";
            } else {
                push @re_date, $re_date;
            }
        }

        my @re_name;
        for my $re_name (@re_date) {
            if ($re_name =~ s/a name="(\d{4})\/(\d\d?)\/(\d\d?)"/a name="$1-$2-$3"/) {
                push @re_name, $re_name;
            } else {
                push @re_name, $re_name;
            }
        }

        return \@re_name;
    }
}

1;
