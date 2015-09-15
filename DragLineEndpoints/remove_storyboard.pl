#!/usr/bin/env perl
use perl5i::2;

open my $fh, '<', 'DragLineEndpoints/Info.plist';

while (<$fh>) {
    print
}

/usr/libexec/PlistBuddy DragLineEndpoints/Info.plist -c "Delete UIMainStoryboardFile"
