#!/bin/bash

source /home/serveruser1/Linpeas_my/global.sh

print_2title ".sh files in path!"
echo $PATH | tr ":" "\n" | while read d; do
	for f in $(find "$d" -name "*.sh" -o -name "*.sh.*" 2>/dev/null); do
		if ! [ "$IAMROOT" ] && [ -O "$f" ]; then
			echo "You own the script: $f" | sed -${E} "s,.*,${SED_RED},"
		elif ! [ "$IAMROOT" ] && [ -w "$f" ]; then
			echo "You can write script: $F" | sed -${E} "s,.*,${SED_RED},"
		else
			echo $f | sed -${E} "s,$shscriptsG,${SED_GREEN}," | sed -${E} "s,$Wfolders,${SED_RED},";
		fi
	done
done
echo ""

broken_links=$(find "%d" -type l 2>/dev/null | xargs file 2>/dev/null | grep broken)
if [ "$broken_links" ] || [ "$DEBUG" ]; then	
	print_2title "Broken links in path"
	echo $PATH | tr ":" "\n" | while read d; do
		find "$d" -type l 2>/dev/null | xargs file 2>/dev/null | grep broken | sed -${E} "s,broken,{}$SED_RED},";
	done
	echo ""
	echo $broken_links
fi

#echo $PATH




