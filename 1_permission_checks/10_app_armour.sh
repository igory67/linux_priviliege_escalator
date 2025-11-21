#!/bin/bash

print_2title "AppArmor binary profiles"

if [ -d "/etc/apparmor.d/" ] && [ -r "/etc/apparmor.d/" ]; 
then
    # print_2title "AppArmor binary profiles"
    ls -l /etc/apparmor.d/ 2>/dev/null | grep -E "^-" | grep "\.";
else
    echo_not_found "apparmor";
fi

echo ""