#!/bin/bash

print_2title "Backup files (up to 100)"
backs=$(find $ROOT_FOLDER -type f \( -name "*backup*" -o -name \
"*\.bak\.*" -o -name "*\.bck" -o -name "*\.bck\.*" -o -name \
"*\.bk\.*" -o -name -o -name "*\.old" -o -name "*\.old\.*" \) -not -path "/proc/*" 2>/dev/null)

printf "%s\n" "$backs" | head -n 100 | while read b ; do
	if [ -r "$b" ]; then
		ls -l "$b" | grep -Ev "$notBackup" | grep -Ev "$notExtensions" | sed -${E} "s,backup|bck|\.bak|\.old,${SED_RED},g";
	fi;
done

echo""

#find $ROOT_FOLDER -type f \( -name "*backup*" \)
