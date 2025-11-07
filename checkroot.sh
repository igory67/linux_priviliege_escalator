#!/bin/bash

if ([ -f /usr/bin/id ] && [ "$(/usr/bin/id -u)" -eq "0" ]) || [ "`whoami 2>/dev/null`" = "root" ]; then
	IAMROOT="1"
	MAXPATH_FIND_W="3"
else
	IAMROOT=""
	MAXPATH_FIND_W="7"
fi 

echo "$IAMROOT"
echo "$MAXPATH_FIND_W"
