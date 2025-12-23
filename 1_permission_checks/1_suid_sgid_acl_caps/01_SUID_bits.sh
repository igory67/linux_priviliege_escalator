#!/bin/bash
print_2title "SUID checks!"

# 4000 perm = SUID SGID STICKY BIT 4 2 1 -> 4 == suid очевидно! ; в /dev/ не ищем
suids_files=$(find $ROOT_FOLDER -perm -4000 -type f ! -path "/dev/*" 2>/dev/null)

#Потом цикл по каждой строке
printf "%s\n" "$suids_files" | while read s; do
  s=$(ls -lahtr "$s")
  #в s кладем ll по найденному пути

  #total = directory, поэтому скип
  if echo "$s" | grep -qE "^total"; then break; fi

  #принтит название т.е. 9 пункт ls -lahtr
  sname="$(echo $s | awk '{print $9}')" 
  #skip . .. понятно Ладно запишу! . - cur dir .. - prev dir
  if [ "$sname" = "."  ] || [ "$sname" = ".."  ]; then
    true 
  
  # own the suid file? for some reason
  elif ! [ "$IAMROOT" ] && [ -O "$sname" ]; then
    print_red " Owned SUID file!!!: %s", $sname
    echo "You own the SUID file: $sname" | sed -${E} "s,.*,${SED_RED},"

  # writable suid file
  elif ! [ "$IAMROOT" ] && [ -w "$sname" ]; then #If write permision, win found (no check exploits)
    echo "You can write SUID file: $sname" | sed -${E} "s,.*,${SED_RED_YELLOW},"
    
  else
    c="a"
    for b in $sidB; do
      if echo $s | grep -q $(echo $b | cut -d % -f 1); then
        echo "$s" | sed -${E} "s,$(echo $b | cut -d % -f 1),${C}[1;31m&  --->  $(echo $b | cut -d % -f 2)${C}[0m,"
        c=""
        break;
      fi
    done;
    if [ "$c" ]; then
      if echo "$s" | grep -qE "$sidG1" || echo "$s" | grep -qE "$sidG2" || echo "$s" | grep -qE "$sidG3" || echo "$s" | grep -qE "$sidG4" || echo "$s" | grep -qE "$sidVB"; then
      #|| echo "$s" | grep -qE "$sidVB2"; then
        echo "$s" | sed -${E} "s,$sidG1,${SED_GREEN}," | sed -${E} "s,$sidG2,${SED_GREEN}," | sed -${E} "s,$sidG3,${SED_GREEN}," | sed -${E} "s,$sidG4,${SED_GREEN}," | sed -${E} "s,$sidVB,${SED_RED_YELLOW},"
        # | sed -${E} "s,$sidVB2,${SED_RED_YELLOW},"
      else
        echo "$s (Unknown SUID binary!)" | sed -${E} "s,/.*,${SED_RED},"
        
        
        if [ "$STRINGS" ]; then
          $STRINGS "$sname" 2>/dev/null | sort | uniq | while read sline; do
            sline_first="$(echo "$sline" | cut -d ' ' -f1)"
            if echo "$sline_first" | grep -qEv "$cfuncs"; then
              if echo "$sline_first" | grep -q "/" && [ -f "$sline_first" ]; then #If a path
                if [ -O "$sline_first" ] || [ -w "$sline_first" ]; then #And modifiable
                  printf "  --- It looks like $RED$sname$NC is using $RED$sline_first$NC and you can modify it (strings line: $sline) (https://tinyurl.com/suidpath)\n"
                fi
              else #If not a path
                if [ ${#sline_first} -gt 2 ] && command -v "$sline_first" 2>/dev/null | grep -q '/' && echo "$sline_first" | grep -Eqv "\.\."; then #Check if existing binary
                  printf "  --- It looks like $RED$sname$NC is executing $RED$sline_first$NC and you can impersonate it (strings line: $sline) (https://tinyurl.com/suidpath)\n"
                  printf "--- It looks like $RED$sname$NCis executing $RED$sline_first$NC$ and you can impersonate it (strings line: $sline) (https://tinyurl.com/suidpath)\n"
                fi
              fi
            fi
          done
        fi

        if [ "$LDD" ] || [ "$READELF" ]; then
          echo " --- Checking for writable dependencies of $sname..."
        fi
        if [ "$LDD" ]; then
          "$LDD" "$sname" | grep -E "$Wfolders" | sed -${E} "s,$Wfolders,${SED_RED_YELLOW},g"
        fi
        if [ "$READELF" ]; then
          "$READELF" -d "$sname" | grep PATH | sed -${E} "s,$Wfolders,${SED_RED_YELLOW},g"
        fi
        
        if [ "$TIMEOUT" ] && [ "$STRACE" ] && [ -x "$sname" ]; then
          echo "----------------------------------------------------------------------------------------"
          echo "  --- Trying to execute $sname with strace in order to look for hijackable libraries..."
          OLD_LD_LIBRARY_PATH=$LD_LIBRARY_PATH
          export LD_LIBRARY_PATH=""
          timeout 2 "$STRACE" "$sname" 2>&1 | grep -i -E "open|access|no such file" | sed -${E} "s,open|access|No such file,${SED_RED},g"
       #   printf $NC
          export LD_LIBRARY_PATH=$OLD_LD_LIBRARY_PATH
          echo "----------------------------------------------------------------------------------------"
          echo ""
        fi
      
      
      fi
    fi
  fi
done;
echo ""
