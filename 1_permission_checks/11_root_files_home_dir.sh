#!/bin/bash

print_2title "Searching root owned files in homes up to 40"

found_files=$(find -type f $HOMESEARCH -user root 2>/dev/null)

found_dirs=$(find -type d $HOMESEARCH -user root 2>/dev/null)

for f in $found_files; do
    ll $f | head -n 40 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g"

for d in $found_dirs; do
    echo "$d" | head -n 40 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g"
#  "found_files" | head -n 40 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g"



echo ""