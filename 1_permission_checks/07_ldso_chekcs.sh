#!/bin/bash

if ! [ "$IAMROOT" ]; then
  print_2title "ld.so checks!#"

  if [ -f "/etc/ld.so.conf" ] && [ -w "/etc/ld.so.conf" ]; then
    print_red_yellow "Writable /etc/ld.so.conf \n"
    print_red_yellow "/etc/ld.so.conf \n"
  else
	echo ""
#    print_green "/etc/ld.so.conf"
  fi

	#echo "What's inside of   /etc/ld.so.conf:"
	TEMPORARY_CAT_VALUE=$(cat /etc/ld.so.conf 2>/dev/null)
	print_blue "inside of /etc/ld.so.conf: "
	small_print "$TEMPORARY_CAT_VALUE"
	tricked_you=$(echo $TEMPORARY_CAT_VALUE)
#	small_print "$TEMPORARY_CAT_VALUE"
#	echo $TEMPORARY_CAT_VALUE
	small_print "$tricked_you"
echo ""

 # echo ""

# echo "1"    # small_print "What's inside of   /etc/ld.so.conf:\n"
# cat /etc/ld.so.conf 2>/dev/null | sed -${E} "s,$Wfolders,${SED_RED_YELLOW},g"


#HERE TRY TO 
# TEMPORARY_CAT_VALUE2=$(cat /etc/ld.so.conf)
# echo "2"
# print_red_yellow $TEMPORARY_CAT_VALUE
# echo $TEMPORARY_CAT_VALUE
# echo "3"
# print_red_yellow $TEMPORARY_CAT_VALUE2
# echo $TEMPORARY_CAT_VALUE2



  # Check each configured folder
  cat /etc/ld.so.conf 2>/dev/null | while read l; do
    if echo "$l" | grep -q include; then
      ini_path=$(echo "$l" | cut -d " " -f 2)
      fpath=$(dirname "$ini_path")

      if [ -d "/etc/ld.so.conf" ] && [ -w "$fpath" ]; then
        print_red_yellow "You have write privileges over $fpath";
        print_red_yellow "$fpath"
        # echo "You have write privileges over $fpath" | sed -${E} "s,.*,${SED_RED_YELLOW},";
        # printf $RED_YELLOW"$fpath\n"$NC;
      else
        print_green "$fpath "
        # printf $GREEN"$fpath\n"$NC;
      fi

      if [ "$(find $fpath -type f '(' '(' -user $USER ')' -or '(' -perm -o=w ')' -or  '(' -perm -g=w -and '(' $wgroups ')' ')' ')' 2>/dev/null)" ]; then
        print_blue "COMPARE THESE"
        print_red_yellow "You have write privileges over $(find $fpath -type f '(' '(' -user $USER ')' -or '(' -perm -o=w ')' -or  '(' -perm -g=w -and '(' $wgroups ')' ')' ')' 2>/dev/null)"
        echo "You have write privileges over $(find $fpath -type f '(' '(' -user $USER ')' -or '(' -perm -o=w ')' -or  '(' -perm -g=w -and '(' $wgroups ')' ')' ')' 2>/dev/null)" | sed -${E} "s,.*,${SED_RED_YELLOW},";
      fi

      for f in $fpath/*; do
        if [ -w "$f" ]; then
          # echo "You have write privileges over $f" | sed -${E} "s,.*,${SED_RED_YELLOW},";
          print_red_yellow "You have write privileges over $f "
          # printf $RED_YELLOW"$f\n"$NC;
        else
          print_green "$f"
#           printf $GREEN"  $f\n"$NC;
        fi

        cat "$f" | grep -v "^#" | while read l2; do
          if [ -f "$l2" ] && [ -w "$l2" ]; then
            print_red_yellow "You have write privileges over $l2 "
            # echo "You have write privileges over $l2" | sed -${E} "s,.*,${SED_RED_YELLOW},";
            # printf $RED_YELLOW"  - $l2\n"$NC;
          else
#        	echo "$l2"
 #       	echo "$l2" | sed -${E} "s,$l2,${SED_GREEN},"
        	echo "$l2" | sed -${E} "s,$l2,${SED_GREEN}," | sed -${E} "s,$Wfolders,${SED_RED_YELLOW},"

#            echo "$l2" | sed -${E} "s,$l2,${SED_GREEN}," | sed -${E} "s,$Wfolders,${SED_RED_YELLOW},g";
                               # sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},"
          fi
        done
      done
    fi
  done
  echo ""


  if [ -f "/etc/ld.so.preload" ] && [ -w "/etc/ld.so.preload" ]; then
    print_red_yellow "You have write privileges over /etc/ld.so.preload"
    # echo "You have write privileges over /etc/ld.so.preload" | sed -${E} "s,.*,${SED_RED_YELLOW},";
  else
    print_green "/etc/ld.so.preload\n"
    # printf $GREEN"/etc/ld.so.preload\n"$NC;
  fi
  cat /etc/ld.so.preload 2>/dev/null | sed -${E} "s,$Wfolders,${SED_RED_YELLOW},g"
  cat /etc/ld.so.preload 2>/dev/null | while read l; do
    if [ -f "$l" ] && [ -w "$l" ]; then 
      print_red_yellow "You have write privileges over $l"
      # echo "You have write privileges over $l" | sed -${E} "s,.*,${SED_RED_YELLOW},"; 
fi
  done

fi
