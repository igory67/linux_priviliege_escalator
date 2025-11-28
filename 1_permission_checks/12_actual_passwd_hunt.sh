#!/bin/bash

print_2title "Looking for passwords in all files!"
echo ""

print_blue "Looking for hashes inside password files: "
# if grep -qv '^[^:]*:[x\*\!]\|^#\|^$' /etc/passwd /etc/master.passwd /etc/group 2>/dev/null; 
if grep -qv '^[^:]*:[x\*]\|^#\|^$' /etc/passwd /etc/pwd.db /etc/master.passwd /etc/group 2>/dev/null; 
then
  print_blue "grep version"
  grep -v '^[^:]*:[x\*]\|^#\|^$' /etc/passwd /etc/pwd.db /etc/master.passwd /etc/group 2>/dev/null | sed -${E} "s,.*,${SED_RED},"
  print_blue "print version"
  print_red "grep -v '^[^:]*:[x\*]\|^#\|^$' /etc/passwd /etc/pwd.db /etc/master.passwd /etc/group 2>/dev/null" 
else 
   echo_not_found "hashes inside password files"
fi
