#!/bin/bash

print_2title " Capabilities! "
#чо за ебучий синтаксис какой-то, чекнуть что в ифе, почему через или; command -v capsh это вот так мы будем с ним общаться о Боги
if [ "$(command -v capsh || echo -n '')" ]; then

    print_green "CURRENT SHELL CAPABILITIES "
    cat "/proc/$$/status" | grep Cap \
    | while read -r cap_line; do
    
        cap_name=$(echo "$cap_line" | awk '{print $1}') #name 
    
        cap_value=$(echo "$cap_line" | awk '{print $2}') #00000

        if [ "$cap_name" = "CapEff:" ]; then
            
            if [[ "$cap_value" =~ ^[0-9a-fA-F]+$ ]]; then
                echo "$cap_name	 $(capsh --decode=0x"$cap_value" 2>/dev/null | sed -${E} "s,$capsB,${SED_RED_YELLOW},")"
            else
                echo "$cap_name	 Not in hash format! for some reason? "
            fi
            
            else

            if [[ "$cap_value" =~ ^[0-9a-fA-F]+$ ]]; then
                echo "$cap_name  $(capsh --decode=0x"$cap_value" 2>/dev/null | sed -${E} "s,$capsB,${SED_RED},")"
            else
                echo "$cap_name  [Invalid capability format]"
            fi

        fi
    done
fi