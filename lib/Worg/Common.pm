#!/usr/bin/env perl
use strict;
use warnings;
use Worg::Tags;

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
                if ($next =~ /^([^\t]*)\t([^\t]*)\t(.+)\t([^\t]+)$/) {
                    my $lcstr = lc($3);
                    my @arr = split /,/, $lcstr;
                    my %hash  = map { $_, 1 } @arr;
                    my @unique = keys %hash;
                    my (@uqxs,@uqx,@uqn);
                    for my $uq (@unique) {
                        if ($uq =~ /{$tags_change}/) {
                            push @uqxs, $uq;
                        } else {
                            push @uqn, $uq;
                        }
                    }
                    @uqx = map {Tags::change_words()->{$_}} @uqxs;
                    my %hash2  = map { $_, 1 } @uqx;
                    my @unique2 = keys %hash2;
                    my $uqstr = join ',', @uqn, @unique2;
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
        return \@port
    }
}

1;
__END__


