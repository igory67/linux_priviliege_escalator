#!/bin/bash

print_2title "Permissions in init, init.d, systemd, and rc.d"

if ! [ "$IAMROOT" ]; then 
  check_critial_root_path "/etc/init/"
  check_critial_root_path "/etc/init.d/"
  check_critial_root_path "/etc/rc.d/init.d"
  check_critial_root_path "/usr/local/etc/rc.d"
  check_critial_root_path "/etc/rc.d"
  check_critial_root_path "/etc/systemd/"
  check_critial_root_path "/lib/systemd/"
fi

echo ""
