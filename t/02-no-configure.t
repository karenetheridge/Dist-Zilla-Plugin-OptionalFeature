use strict;
use warnings;

use Test::More;
use if $ENV{AUTHOR_TESTING}, 'Test::Warnings';
use Test::Fatal;
use Test::DZil;
use Path::Tiny;

{
    like( exception {
        Builder->from_config(
            { dist_root => 't/does_not_exist' },
            {
                add_files => {
                    path(qw(source dist.ini)) => simple_ini(
                        [ GatherDir => ],
                        [ Prereqs => TestRequires => { Tester => 0 } ],   # so we have prereqs to test for
                        [ OptionalFeature => FeatureName => {
                                -phase => 'configure',
                                -description => 'desc',
                                A => 0,
                            }
                        ],
                    ),
                },
            },
        ) },
        qr/^optional features may not use the configure phase/,
        'configure phase prereqs cannot be used in optional_features',
    );
}

done_testing;
