#!/bin/sh
tail -2 $0 | cut -b3-

# rename -vn 's/[][ .,_-]*//g' *
# rename -vn 's/(.*)(...)$/$1.$2/' *
