#!/bin/bash

print_2title "ACL files up to 50"
( (getfacl -t -s -R -p /bin /etc $HOMESEARCH /opt /sbin /usr /tmp /root 2>/dev/null) \
|| echo_not_found "files with acls in searched folders" ) \
| head -n 70 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN}," \
| sed -${E} "s,$nosh_usrs,${SED_BLUE}," \
| sed -${E} "s,$knw_usrs,${SED_GREEN}," \
| sed "s,$USER,${SED_RED},"


echo ""