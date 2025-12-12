#!/bin/bash

source /home/serveruser1/Linpeas_my/global.sh

#mail apps
print_2title "CHECKING MAIL APPS"
ls /bin /sbin /usr/bin /usr/local/bin /usr/local/sbin /etc 2>/dev/null | grep -E -w -i "$mail_apps" | sort | uniq
echo ""


print_2title "CHECKING MAILS"
(find /var/mail/ /var/spool/mail/ /private/var/mail -type f -ls 2>/dev/null | head -n 50 | sed "s,$USER,${SED_RED},g" | sed -${E} "s,$sh_usrs,${SED_RED}," | sed -${E} "s,$nosh_usrs,${SED_BLUE},g" | sed -${E} "s,$knw_usrs,${SED_GREEN},g" | sed "s,root,${SED_GREEN},g" ) || echo_not_found
echo ""
