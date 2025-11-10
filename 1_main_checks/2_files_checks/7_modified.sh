#!/bin/bash

print_2title "modified in last 5 mins (up to 100)"

find $ROOT_FOLDER -type f -mmin -5 ! -path "/proc/*" ! -path "/sys/*" ! -path "/run/*" ! -path "/dev/*" ! -path "/var/lib/*" ! -path "/private/var/*" 2>/dev/null | \
grep -v "linpeas"| head -n 100 | sed -${E} "s,$Wfolders,${SED_RED},"
#find $ROOT_FOLDER -type f -mmin -5 ! -path "/proc/*" ! -paty "/sys/*" ! - paty "/run/*" ! -path "/dev/*" ! -path "/var/lib/*" ! -path "/private/var/*" 2>/dev/null | head -n 100 | sed -${E} "s,$Wfolders,${SED_RED},"
echo ""

#echo $ROOT_FOLDER
#find $ROOT_FOLDER -type f -mmin -5 ! -path "/proc/*" ! -path "/sys/*" ! -path2>/dev/null
