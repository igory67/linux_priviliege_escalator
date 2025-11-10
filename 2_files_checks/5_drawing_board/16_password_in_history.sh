#!/bin/bash -i

#if [ "$(history 2>/dev/null)" ]; then
print_2title "password in cmd history"
#	history | grep -Ei "$pwd_inside_history" "$f" 2>/dev/null \
history | grep -Ei "$pwd_inside_history" 2>/dev/null \
| sed -${E} "s,$pwd_inside_history,${SED_RED},"
echo ""

history | grep -Ei "$pwd_inside_history"
history | grep -i passw

#fi
$HOME/.bash_history | grep passw
#qecho $pwd_inside_history
