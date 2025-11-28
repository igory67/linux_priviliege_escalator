#!/bin/bash

print_2title "Readable files belonging to root and readable by me but not world readable"

if ! [ "$IAMROOT" ]; then
  (find $ROOT_FOLDER -type f -user root ! -perm -o=r ! -path "/proc/*" 2>/dev/null \
  | grep -v "\.journal" \
  | while read f; do if [ -r "$f" ]; then ls -l "$f" 2>/dev/null | sed -${E} "s,/.*,${SED_RED},"; fi; done) || echo_not_found
else
    small_print "i am root so idc"
fi
echo ""

find_res=$(find $ROOT_FOLDER -type f -user root ! -perm -o=r ! -path "/proc/*" 2>/dev/null \
  | grep -v "\.journal" \
  | while read f; do
        if [ -r "$f" ]; then
            ls -l "$f" 2>/dev/null; 
        fi; 
    done)
print_red "$find_res"