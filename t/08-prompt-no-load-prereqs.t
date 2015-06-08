use strict;
use warnings;

use Path::Tiny;
my $code = path('t', '06-prompt.t')->slurp_utf8;

$code =~ s/(^\s+)-prompt => 1,\n\K/$1-load_prereqs => 0,\n/mg;
$code =~ s/load_prereqs => \K1,/0,/mg;
$code =~ s/eval "[^"]+"\n    \|\| //g;
$code =~ s/with -default = 1\K/ and -load_prereqs = 0/g;

eval $code;
die $@ if $@;