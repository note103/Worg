#!/usr/bin/env perl
use strict;
use warnings;

package Tags {
    sub tags {
        return 'source|食器|掃除|洗|メール|amazon|books|buy|coffee|docker|drink|eat|english|git|lunch|mail|mojolicious|money|mysql|nail|papix|perlentrance|perl|postgres|programming|rails|ruby|twitter|vagrant|vim|wash|youtube';
    }
    sub change_tags {
        return '|食器|掃除|洗|メール|papix|';
    }
    sub change_words {
        return {
            '食器' => 'dish',
            '掃除' => 'cleaning',
            '洗' => 'wash',
            'メール' => 'mail',
            'papix' => 'perlentrance',
        };
    }
}

1;


