print_2title "THIS IS 2ND"
if ! [ "$IAMROOT" ]; then
  print_2title "Writable files analysis"
  
  print_small_title "Files owned by you (outside home):"
  find_owned=$(find $ROOT_FOLDER \( -type f -o -type d \) -user $USER \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null | head -n 100)
  [ -n "$find_owned" ] && print_blue "$find_owned" || echo_not_found
  
  print_small_title "World-writable files (outside home):"
  find_www=$(find $ROOT_FOLDER \( -type f -o -type d \) -perm -o=w \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null | head -n 100)
  [ -n "$find_www" ] && print_red_yellow "$find_www" || echo_not_found
fi
