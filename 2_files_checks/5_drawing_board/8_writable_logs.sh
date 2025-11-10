#!/bin/bash 

print_2title "Log files with weird permissions (up to 50)"
find /var/log -type f -ls 2>/dev/null | \
grep -Ev "root\s+root|root\s+systemd-journal|root\s+syslog|root\s+utmp|root\s+adm|www-data\s+root|syslog\s+adm" | \
sed -${E} "s,.*,${SED_RED},g" | \
head -n 50

echo ""
