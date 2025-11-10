#!/bin/bash

source /home/serveruser1/Linpeas_my/global.sh

print_2title "Files inside others home (up to 20!)"
$HOMESEARCH="/home/ /Users/ /root/ /var/www $(cat /etc/passwd 2>/dev/null | grep "sh$" | cut -d ":" -f 6 | grep -Ev "^/root|^/home|^/var/www" | tr "\n" " ")"
(find $HOMESEARCH -type f 2>/dev/null | grep -v  -i "/"$USER | head -n 20)
echo ""
#echo $USER
#echo ""
#echo $OPTARG
#echo $HOMESEARCH
