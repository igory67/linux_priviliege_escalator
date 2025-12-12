#!/bin/bash

print_2title "Users with capabilities"
if [ -f "/etc/security/capability.conf" ]; then
    grep -v '^#\|none\|^$' /etc/security/capability.conf 2>/dev/null \
    | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN}," \
    | sed -${E} "s,$nosh_usrs,${SED_BLUE}," \
    | sed -${E} "s,$knw_usrs,${SED_GREEN}," \
    | sed "s,$USER,${SED_RED},"
    else echo_not_found "/etc/security/capability.conf"
    fi
    echo ""