#!/bin/bash

print_2title "Searching root owned files in homes up to 40"
#echo "$HOMESEARCH"

#echo $(find -type f $HOMESEARCH -user root)
found_files=$(find $HOMESEARCH -type f -user root 2>/dev/null)
#echo $found_files

found_dirs=$(find $HOMESEARCH -type d -user root 2>/dev/null)
#echo "$found_dirs"
echo ""
print_blue "found files:"
echo ""

for f in $found_files; do
  #  ls -la $f | head -n 40 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g"
 #   echo "split"
    ls -la "$f" | head -n 40 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g"
done;

echo ""
print_blue "directories, just for reference:"
echo ""

for d in $found_dirs; do
    echo "$d" | head -n 40 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g"
done;
#  "found_files" | head -n 40 | sed -${E} "s,$sh_usrs,${SED_LIGHT_CYAN},g" | sed "s,$USER,${SED_RED},g"



echo ""

