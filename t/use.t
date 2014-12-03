#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

BEGIN { use_ok 'Worg'; }
BEGIN { use_ok 'Worg::Chat'; }
BEGIN { use_ok 'Worg::Common'; }
BEGIN { use_ok 'Worg::Done'; }
BEGIN { use_ok 'Worg::Rewrite'; }
BEGIN { use_ok 'Worg::Slack'; }
BEGIN { use_ok 'Worg::Tags'; }

done_testing();

1;
