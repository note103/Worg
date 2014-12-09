#!/usr/bin/env perl
use strict;
use warnings;

package Tags {
    sub tags {
        return 'source|食器|掃除|洗|メール|山本|yamamoto|完了|done|amazon|books|buy|coffee|docker|drink|eat|english|git|lunch|mail|mojolicious|money|mysql|nail|perlentrance|perl|postgres|programming|rails|ruby|twitter|vagrant|vim|wash|youtube';
    }
    sub change_tags {
        return '|食器|掃除|洗|メール|山本|完了|';
    }
    sub change_words {
        return {
            '食器' => 'dish',
            '掃除' => 'cleaning',
            '洗' => 'wash',
            'メール' => 'mail',
            '山本' => 'yamamoto',
            '完了' => 'done',
        };
    }
}

1;


