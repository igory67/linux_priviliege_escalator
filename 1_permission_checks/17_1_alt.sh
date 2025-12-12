#!/bin/bash

if ! [ "$IAMROOT" ]; then
    print_2title "Interesting GROUP writable files (not in Home)"
    
    for g in $(groups); do  # ← STARTS for loop
        iwfbg=$(find $ROOT_FOLDER '(' -type f -or -type d ')' \
            -group "$g" -perm -g=w \
            ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
            | grep -Ev "$notExtensions" \
            | awk -F/ '{
                dir=$0
                sub(/\/[^\/]+$/, "", dir)
                count[dir]++
                if (count[dir] <= 4) print $0
                else if (count[dir] == 5) print "# More files in: " dir
              }' \
            | head -n 200)
        
        # ↓ This IF must have matching FI!
        if [ -n "$iwfbg" ] || [ "$DEBUG" ]; then
            print_green "  Group $g:"
            
            # ↓ This WHILE must have matching DONE!
            echo "$iwfbg" | while read line; do
                if echo "$line" | grep -q "^# More files in: "; then
                    print_cyan "$line"
                elif echo "$line" | grep -qE "$writeVB"; then
                    print_red_yellow "$line"
                elif echo "$line" | grep -qE "$writeB"; then
                    print_red "$line"
                else
                    echo "$line"
                fi
            done  # ← Closes WHILE
            
        fi  # ← Closes IF
        
    done  # ← Closes FOR loop
    echo ""
fi  # ← Closes outer IF