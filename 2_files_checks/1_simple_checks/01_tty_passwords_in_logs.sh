#!/bin/bash

print_2title "TTY passwords in logs"

aureport --tty 2>/dev/null \
| grep -E "su | sudo " \
| sed -${E} "s,su|sudo,${SED_RED},g"

find /var/log/ -type f -exec grep -RE 'comm="su"|comm="sudo"' '{}' \; 2>/dev/null \
| sed -${E} "s,\"su\"|\"sudo\",${SED_RED},g" \
| sed -${E} "s,data=.*,${SED_RED},g"

echo ""



