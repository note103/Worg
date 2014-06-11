#!/usr/bin/env perl
use strict;
use warnings;

package Ex2hash {
    sub run {
        my @port;
        open my $fh, '<', 'data/note.md' or die $!;
        for my $in (<$fh>) {
            if ($in =~ /^([^\t]+)\t(.+)$/) {
                push @port, "  \"$1\": \"$2\"\n";
            }
        }
        close $fh;

        open my $fh_out, '>', 'data/bucket.md' or die $!;
        print $fh_out "{\n";
        print $fh_out '  "0": "0"',"\n";
        for my $line (@port) {
            print $fh_out "$line";
        }
        print $fh_out "}";
        close $fh_out;
    }
}

1;


