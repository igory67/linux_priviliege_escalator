#!/bin/bash

print_2title "Permissions in init, init.d, systemd, and rc.d"

if ! [ "$IAMROOT" ]; then 
  check_critical_root_path "/etc/init/"
  check_critical_root_path "/etc/init.d/"
  check_critical_root_path "/etc/rc.d/init.d"
  check_critical_root_path "/usr/local/etc/rc.d"
  check_critical_root_path "/etc/rc.d"
  check_critical_root_path "/etc/systemd/"
  check_critical_root_path "/lib/systemd/"
fi

echo ""
