#!/bin/bash
source /home/serveruser1/Linpeas_my/global.sh

source sandbox/$1.sh

# | tee output.txt && less -R output.txt && rm output.txt
#echo "done, check if rm output.txt worked!"
echo "" 
echo ""
