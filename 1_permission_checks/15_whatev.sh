#!/bin/bash

print_2title "Interesting writable files (not in Home)"

if ! [ "$IAMROOT" ]; then
  # Find files with AWK directory limiting
  obmowbe=$(find $ROOT_FOLDER '(' -type f -or -type d ')' \
    '(' '(' -user $USER ')' -or '(' -perm -o=w ')' ')' \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
    | grep -Ev "$notExtensions|run|snap" \
    | sort | uniq \
    | awk -F/ '{
        # Get directory path by removing filename
        dir=$0
        sub(/\/[^\/]+$/, "", dir)
        
        # Count files in this directory
        count[dir]++
        
        # Print first 5 files per directory
        if (count[dir] <= 5) {
          print $0
        }
        # On 6th file, print a message
        else if (count[dir] == 6) {
          print "# Many more files in: " dir
        }
        # Files 7+ are silently skipped
      }' \
    | head -n 200)
  
  if [ -n "$obmowbe" ]; then
    echo "$obmowbe" | while read line; do
      # Skip the directory messages (they start with #)
      if [[ "$line" == "# "* ]]; then
        print_cyan "$line"
        continue
      fi
      
      # Color based on your writeVB/writeB patterns
      if echo "$line" | grep -qE "$writeVB"; then
        print_red_yellow "$line"
      elif echo "$line" | grep -qE "$writeB"; then
        print_red "$line"
      else
        echo "$line"
      fi
    done
  else
    echo_not_found "interesting writable files"
  fi
  echo ""
fi