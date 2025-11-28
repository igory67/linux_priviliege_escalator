#!/bin/bash

print_2title "Looking for passwords in all files!"
echo ""

print_small_title "Looking for hashes inside password files: "
# if grep -qv '^[^:]*:[x\*\!]\|^#\|^$' /etc/passwd /etc/master.passwd /etc/group 2>/dev/null; 
if grep -qv '^[^:]*:[x\*]\|^#\|^$' /etc/passwd /etc/pwd.db /etc/master.passwd /etc/group 2>/dev/null; 
then
  # print_blue "grep version"
  # grep -v '^[^:]*:[x\*]\|^#\|^$' /etc/passwd /etc/pwd.db /etc/master.passwd /etc/group 2>/dev/null | sed -${E} "s,.*,${SED_RED},"
  # print_blue "print version"
  grepped=$(grep -v '^[^:]*:[x\*]\|^#\|^$' /etc/passwd /etc/pwd.db /etc/master.passwd /etc/group 2>/dev/null) 
  print_red "$grepped"
else 
   echo_not_found "hashes inside password files"
fi



print_small_title "writable password files: "
if [ -w "/etc/passwd" ]; then 
  print_red_yellow "/etc/passwd is writable! quick win ig"
fi
if [ -w "/etc/pwd.db" ]; then 
  print_red_yellow "/etc/pwd.db is writable! quick win ig"
fi
if [ -w "/etc/master.passwd" ]; then 
  print_red_yellow "/etc/master.passwd is writable! quick win ig"
fi
echo_not_found "writable password files (unless you see red_yellow prints saying otherwise)"



print_small_title "Trying to read shadow files: "
if [ "$(cat /etc/shadow /etc/shadow- /etc/shadow~ /etc/gshadow /etc/gshadow- /etc/master.passwd /etc/spwd.db 2>/dev/null)" ]; then 
  
  cat /etc/shadow /etc/shadow- /etc/shadow~ /etc/gshadow /etc/gshadow- /etc/master.passwd /etc/spwd.db 2>/dev/null | sed -${E} "s,.*,${SED_RED},"
  shadows=$(cat /etc/shadow /etc/shadow- /etc/shadow~ /etc/gshadow /etc/gshadow- /etc/master.passwd /etc/spwd.db 2>/dev/null)
  print_red "$shadows"
else 
  echo_not_found "readable shadow files"
fi



print_small_title "writable network scripts:  "
if ! [ "$IAMROOT" ] && [ -w "/etc/sysconfig/network-scripts/" ]; then 
  print_red_yellow "You have write privileges on /etc/sysconfig/network-scripts/" 
else
  find_res=$(find /etc/sysconfig/network-scripts/ '(' -not -type l -and '(' '(' -user $USER ')' -or '(' -perm -o=w ')' -or  '(' -perm -g=w -and '(' $wgroups ')' ')' ')' ')' 2>/dev/null)
#elif [ "$()" ]; then 
#  echo "You have write privileges on $(find /etc/sysconfig/network-scripts/ '(' -not -type l -and '(' '(' -user $USER ')' -or '(' -perm -o=w ')' -or  '(' -perm -g=w -and '(' $wgroups ')' ')' ')' ')' 2>/dev/null)" | sed -${E} "s,.*,${SED_RED_YELLOW},"
  if [ -n "$find_res" ]; then
    print_red_yellow "You have write on $find_res"
  else
    echo_not_found "writable network scripts"
  fi
fi

##-- IPF) Read root dir
print_list "Can I read root folder? .............. "
(ls -al /root/ 2>/dev/null | grep -vi "total 0") || echo_no
echo ""
