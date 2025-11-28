#!/bin/bash

print_2title "Readable files belonging to root and readable by me but not world readable"

if ! [ "$IAMROOT" ]; then
  find_res=$(find $ROOT_FOLDER -type f -user root ! -perm -o=r ! -path "/proc/*" 2>/dev/null \
  | grep -v "\.journal" \
  | while read f; do
        if [ -r "$f" ]; then
            ls -la "$f" 2>/dev/null; 
        fi; 
    done)
    print_red "$find_res"
else
    small_print "i am root so idc"
fi
echo ""

print_2title "Writable files belonging to root and writable by me but not world writable"

if ! [ "$IAMROOT" ]; then
  find_res=$(find $ROOT_FOLDER -type f -user root ! -perm -o=w ! -path "/proc/*" 2>/dev/null \
  | grep -v "\.journal" \
  | while read f; do
        if [ -w "$f" ]; then
            ls -la "$f" 2>/dev/null; 
        fi; 
    done)
    print_red "$find_res"
else
    small_print "i am root so idc"
fi
echo ""