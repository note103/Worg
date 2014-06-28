#!/usr/bin/env perl
use strict;
use warnings;

package Tags {
    sub tags {
        return 'source|食器|掃除|洗|髪切|amazon|books|buy|coffee|docker|drink|eat|english|floss|git|housework|junkudo|lunch|mail|maintenance|memo|mojolicious|money|must|mysql|nail|perl|postgres|programming|rails|reading|rest|ruby|twitter|vagrant|vim|wake|wash|wish|youtube';
    }
    sub change_tags {
        return '|食器|掃除|洗|髪切|papix|';
    }
    sub change_words {
        return {
            source => 'changed',
            '食器' => 'dish',
            '掃除' => 'cleaning',
            '洗' => 'housework',
            '髪切' => 'haircut',
        };
    }
}

1;


