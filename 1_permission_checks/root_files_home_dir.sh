#!/bin/bash

print_2title "Searching root owned files in homes up to 30"

(find $HOMESEARCH -user root 2>/dev/null | head -n 30 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g") \
|| echo_not_found
echo ""