use Test::More;
use FindBin;
use lib "$FindBin::Bin/lib";

use strict;
use warnings;

plan tests => 2;

eval "use MyTest1";

like $@,qr/MyFilter1->ppi_filter did not return a document/;

eval "use MyTest2";

is MyTest2->foo,84;

