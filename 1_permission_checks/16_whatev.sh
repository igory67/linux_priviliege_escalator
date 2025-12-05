#!/bin/bash

if ! [ "$IAMROOT" ]; then

print_2title "Interesting writable files (not in Home)"
  obmowbe=$(find $ROOT_FOLDER '(' -type f -or -type d ')' \
    '(' '(' -user $USER ')' -or '(' -perm -o=w ')' ')' \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
    | grep -Ev "$notExtensions|run|snap" \
    | awk -F/ '{
        dir=$0; 
        sub(/\/[^\/]+$/, "", dir);  # Remove filename, keep directory
        count[dir]++
        if (count[dir] <= 5) print $0
        else if (count[dir] == 6) print "# Many more files in: " dir
    }' \
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
