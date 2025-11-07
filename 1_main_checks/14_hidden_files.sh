#!/bin/bash

print_2title "Hidden files (up to 70)"

#find $ROOT_FOLDER -type f -iname ".*" ! -path "/sys/*" ! -path "/System/*" ! -path "/private/var/*" -exec ls -l {} \; 2>/dev/null | grep -Ev "$INT_HIDDEN_FILES" | grep -Ev "_history$|\.gitignore|.npmignore|\.listing|\.ignore|\.uuid|\.depend|\.placeholder|\.gitkeep|\.keep|\.keepme|\.travis.yml" | head -n 70
find $ROOT_FOLDER -type f -iname ".*" ! -path "/sys/*" ! -path "/System/*" ! -path "/private/var/*" -exec ls -l {} \; 2>/dev/null \
| grep -Ev "_history$|\.gitignore|\.npmignore|\.listing|\.ignore|\.uuid|\.depend|\.placeholder|\.gitkeep|\.keep|\.keepme" \
#| grep -Ev "$INT_HIDDEN_FILES" \
| head -n 70

echo ""
echo "$INT_HIDDEN_FILES"






