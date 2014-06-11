#!/usr/bin/env perl
use strict;
use warnings;
use DateTime;

package Date {
    sub date {
        print "Input 'dd' or 'dn'.\n";
        while (my $set = <>) {
            if ($set =~ /^(dd)$/) {
                return d2d();
            } elsif ($set =~ /^(dn)$/) {
                return d2n();
            } elsif ($set =~ /^(q)$/) {
                print "Bye!\n";
                last;
            } else {
                print "\nPlease input 'dd' or 'dn'. If you shut down, press 'q'.\n";
            }
        }
    }
    sub d2d {
        print "What date?\n";
        my $date = <STDIN>;
        chomp $date;
        
        if ($date =~ /^(20\d\d)[\/-](\d\d?)[\/-](\d\d?)$/) { 
            print "What numbers?\n";
            my $num = <STDIN>;
            chomp $num;
        
            my $calc1 = DateTime->new( 
                year => $1, month => $2, day => $3,
            );
            $calc1->subtract(days => $num);
            print $calc1->ymd.": subtract\n";
            
            my $calc2 = DateTime->new( 
                year => $1, month => $2, day => $3,
            );
            $calc2->add(days => $num);
            print $calc2->ymd.": add\n"; 
            
        }
    }
    sub d2n {
        print "What date first?\n";
        my $date1 = <STDIN>;
        chomp $date1;
        if ($date1 =~ /^(20\d\d)[\/-](\d\d?)[\/-](\d\d?)$/) { 
            my $calc1 = DateTime->new(
                year => $1, month => $2, day => $3,
            );
        
            print "What date second?\n";
            my $date2 = <STDIN>;
            chomp $date2;
            if ($date2 =~ /^(20\d\d)[\/-](\d\d?)[\/-](\d\d?)$/) { 
                my $calc2 = DateTime->new(
                    year => $1, month => $2, day => $3,
                );
                
                my $subtract = $calc1->delta_days($calc2);
                print $subtract->in_units('days')."\n";
            }
        }
    }
}

1;


