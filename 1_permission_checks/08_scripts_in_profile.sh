#!/bin/bash

print_2title "Scripts in /etc/profile.d/" #""The file /etc/profile and the files under /etc/profile.d/ are scripts that are
# executed when a user runs a new shell. Therefore, if you can write or modify any of them you can escalate privileges.""

if ! [ "$IAMROOT" ]; then 
  (ls -la /etc/profile.d/ 2>/dev/null | sed -${E} "s,$profiledG,${SED_GREEN},") \
  || echo_not_found "/etc/profile.d/" 
  check_critical_root_path "/etc/profile"
  check_critical_root_path "/etc/profile.d/"
fi
  

echo ""

