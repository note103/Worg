#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;

BEGIN { use_ok 'Worg'; }
BEGIN { use_ok 'Worg::Chat'; }
BEGIN { use_ok 'Worg::Pad'; }
BEGIN { use_ok 'Worg::Tags'; }
BEGIN { use_ok 'Worg::Common'; }
BEGIN { use_ok 'Worg::Notes'; }

done_testing();

1;
