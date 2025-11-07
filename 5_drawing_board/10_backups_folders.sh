#!/bin/bash

print_2title "BACKUPS"

if [ "$PSTORAGE_BACKUPS" ]; then #|| [ "$DEBUG" ]; then
	print_2title "Backup folders"
	printf "%s\n" "$PSTORAGE_BACKUPS" | while read b ; do
		ls -ld "$b" 2>/dev/null | sed -${E} "s,backups|backup,${SED_RED},g"
		ls -l "$b" 2>/dev/null && echo ""
	done
	echo ""
else 
	echo "no pstorage"
fi
