#!/bin/bash

print_2title "THIS IS 1ST"
if ! [ "$IAMROOT" ]; then
  print_2title "Interesting writable files owned by me or writable by everyone (not in Home) (max 200)"
  
  # Find with AWK directory limiting
  obmowbe=$(find $ROOT_FOLDER '(' -type f -or -type d ')' \
    '(' '(' -user $USER ')' -or '(' -perm -o=w ')' ')' \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
    | grep -Ev "$notExtensions|run|snap" \
    | sort \
    | uniq \
    | awk -F/ '{
        dir=$0
        sub(/\/[^\/]+$/, "", dir)
        count[dir]++
        if (count[dir] <= 5) {
          print $0
        }
        else if (count[dir] == 6) {
          print "# Many more files in: " dir
        }
      }' \
    | head -n 200)

  # Process results
  if [ -n "$obmowbe" ]; then
    printf "%s\n" "$obmowbe" | while read line; do
      # Handle directory limit messages
      if echo "$line" | grep -q "^# Many more files in:"; then
        print_cyan "$line"
        continue
      fi
      
      # Color based on writeVB/writeB patterns
      if echo "$line" | grep -qE "$writeVB"; then
        print_red_yellow "$line"
      elif echo "$line" | grep -qE "$writeB"; then
        print_red "$line"
      else
        echo "$line"  # Regular output
      fi
    done
  else
    echo_not_found "interesting writable files"
  fi
  echo ""
fi