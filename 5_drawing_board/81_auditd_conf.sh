#!/bin/bash

print_2title "Auditd configuration (limit 50)"
if [ -f "/etc/audit/auditd.conf" ]; then
	grep -v "^#" /etc/syslog.conf 2>/dev/null | sed -${E} "s,.*,${SED_RED}.g" | head -n 50
else
	echo_not_found "auditd config"
fi	
