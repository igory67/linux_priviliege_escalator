#!/bin/bash

print_2title "Interesting writable files owned by me or writable by everyone (not in Home)"

if ! [ "$IAMROOT" ]; then
  # Find files (remove the preliminary small_print!)
  obmowbe=$(find $ROOT_FOLDER '(' -type f -or -type d ')' \
    '(' '(' -user $USER ')' -or '(' -perm -o=w ')' ')' \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
    | grep -Ev "$notExtensions|run|snap" | sort | uniq | head -n 200)
  
  if [ -n "$obmowbe" ]; then
    echo "$obmowbe" | while read line; do
      # Check if world-writable (high risk!)
      if echo "$line" | grep -qE "$writeVB"; then
        print_red_yellow "$line"
      # Check if just owned by you (medium risk)
      elif echo "$line" | grep -qE "$writeB"; then
        print_red "$line"
      else
        # Regular writable files
        echo "$line"
      fi
    done
  else
    echo_not_found "interesting writable files"
  fi
  echo ""
fi
