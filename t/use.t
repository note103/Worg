#!/usr/bin/env perl
use strict;
use warnings;

use Test::More;
use Worg;
use Worg::Chat;
use Worg::Pad;
use Worg::Tags;
use Date;
use Ex2hash;

BEGIN { use_ok 'Worg'; }
BEGIN { use_ok 'Worg::Chat'; }
BEGIN { use_ok 'Worg::Pad'; }
BEGIN { use_ok 'Worg::Tags'; }
BEGIN { use_ok 'Date'; }
BEGIN { use_ok 'Ex2hash'; }

done_testing();

1;

