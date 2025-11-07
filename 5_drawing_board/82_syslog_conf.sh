#!/bin/bash

print_2title "Syslog config (up to 50)"


if [ -f "/etc/rsyslog.conf" ]; then
	grep -v "^#" /etc/rsyslog.conf 2>/dev/null | sed -${E} "s,.*,$SED_RED},g" | head -n 50
else
	grep -v "^#" /etc/syslog.conf 2>/dev/null | sed -${E} "s,.*,$SED_RED},g" | head -n 50
else
	echo_not_found "syslog configuration"
fi
