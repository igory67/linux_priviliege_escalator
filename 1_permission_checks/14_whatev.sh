#!/bin/bash
echo "14"
if ! [ "$IAMROOT" ]; then
  print_2title "Interesting writable files owned by me or writable by everyone (not in Home) (max 200)"
#echo "1414141"
  #In the next file, you need to specify type "d" and "f" to avoid fake link files apparently writable by all
  #ombowbe это название болезни автора (owned by me or writable by everyone)
  obmowbe=$(find $ROOT_FOLDER '(' -type f -or -type d ')' \
  '(' '(' -user $USER ')' -or '(' -perm -o=w ')' ')' \
  ! -path "/proc/*" ! -path "/sys/*" ! -path "$HOME/*" 2>/dev/null \
  | grep -Ev "$notExtensions|run|snap" \
  | sort \
  | uniq \
  | awk -F/ '
  {
    dir=$0
    sub(/\/[^\/]+$/, "", dir)
    count[dir]++
    if (count[dir] <= 4)
    {
      print $0
    }
    else if (count[dir] == 5)
    {
      print "# More files in: " dir
    }
  }' \
| head -n 200)
#  | awk -F/ '{line_init=$0;
#   if (!cont){ cont=0 }; $NF=""; act=$0; if (act == | pre){(cont += 1)} else {cont=0}; if (cont < 5){ print line_init; } if (cont ==  | "5"){print "#)You_can_write_even_more_files_inside_last_directory\n"}; pre=act }'\
#  подумать про это авк, пока странно кажется
#  | head -n 200)
	# small_print "$obmowbe"
  if [ -n "$obmowbe" ]; then
    printf "%s\n" "$obmowbe" | while read line; 
    do

      if echo "$line" | grep -q "^# More files in: "; then
        # printf $ITALIC"$l\n"$NC;
        print_cyan "$line";
      elif echo "$line" | grep -qE "$writeVB"; then
        print_red_yellow "$line"
        # echo "$l" | sed -${E} "s,$writeVB,${SED_RED_YELLOW},"
      else 
        print_red "$line"
        # echo "$l" | sed -${E} "s,$writeB,${SED_RED},"
      fi

    done
  else
  echo "no obmowbe"
  fi
fi
echo ""
