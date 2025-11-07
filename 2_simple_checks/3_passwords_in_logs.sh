#!/bin/bash

print_2title "Passwords in log files up to 50"
(find /var/log/ /var/logs/ /private/var/log -type f -exec grep -R -H -i "pwd\|passw" "{}" \;) 2>/dev/null \
| sed '/^.\{150\}./d' \
| sort \
| uniq \
| grep -v "File does not exist:\|modules-config/config-set-passwords\|config-set-passwords already ran\|script not found or unable to stat:\|\"GET /.*\" 404\|dpkg" \
| head -n 70 \
| sed -${E} "s,pwd|passw,${SED_RED},"

echo ""
