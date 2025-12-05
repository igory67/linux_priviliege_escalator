print_2title "this is 3rd"
if ! [ "$IAMROOT" ]; then
  print_2title "Interesting writable files owned by me or writable by everyone (not in Home) (max 200)"
  print_info "https://book.hacktricks.wiki/en/linux-hardening/privilege-escalation/index.html#writable-files"
  
  # Simplify the find command
  find_res=$(find $ROOT_FOLDER \( -type f -o -type d \) \( -user $USER -o -perm -o=w \) \
    ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
    | grep -Ev "$notExtensions" | head -n 200)
  
  if [ -n "$find_res" ]; then
    # Group by directory to avoid spam
    echo "$find_res" | while read item; do
      if [ -w "$item" ]; then
        if [ -d "$item" ]; then
          print_red_yellow "Writable Directory: $item"
        else
          print_red "Writable File: $item"
        fi
      else
        echo "Owned by you: $item"
      fi
    done
  else
    echo_not_found "interesting writable files"
  fi
  echo ""
fi
