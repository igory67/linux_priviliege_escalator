#!/bin/bash

if ! [ "$IAMROOT" ]; then

print_2title "Interesting writable files (not in Home)"
  #ombowbe это название болезни автора (owned by me or writable by everyone)
  obmowbe=$(find $ROOT_FOLDER '(' -type f -or -type d ')' \
    '(' '(' -user $USER ')' -or '(' -perm -o=w ')' ')' \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
    | grep -Ev "$notExtensions|run|snap" \
    | a   
    | head -n 200)
  
  if [ -n "$obmowbe" ]; then
    declare -A printed_dirs
    echo "$obmowbe" | while read line; do
      # Skip the "many more files" messages
      if [[ "$line" == "# Many more files in:"* ]]; then
        print_cyan "$line"
        continue
      fi
      
      # Check permissions properly
      if [ -w "$line" ] && [ ! -O "$line" ]; then
        # World-writable AND not owned by you = HIGHEST RISK
        print_red_yellow "[WORLD-WRITABLE] $line"
      elif [ -O "$line" ]; then
        # Owned by you in system directories
        print_red "[YOURS] $line"
      else
        # Other cases (shouldn't happen with our find)
        echo "$line"
      fi
    done
  else
    echo_not_found
  fi
  echo ""

fi

echo ""
