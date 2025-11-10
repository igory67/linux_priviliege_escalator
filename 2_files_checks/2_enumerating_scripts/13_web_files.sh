#!/bin/bash

print_2title "web files: "
echo "/var/www:"
ls -alhR /var/www 2>/dev/null | head
echo "srv/www/htdocs:"
ls -alhR /srv/www/htdocs 2>/dev/null | head
echo "www/apache22/data: "
ls -alhR /usr/local/www/apache22/data 2>/dev/null | head
echo "opt/lampp/htdocs: "
ls -alhR /opt/lampp/htdocs 2>/dev/null | head
echo "should prolly add smth else here, like nginx at least"
echo ""


