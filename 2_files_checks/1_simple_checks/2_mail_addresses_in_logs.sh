print_2title "Emails inside log files up to 50"
(find /var/log/ /var/logs /private/var/log -type f -exec grep -I -R -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" "{}" \;) 2>/dev/null \
| sort \
| uniq -c \
| sort -r -n \
| head -n 50 \
| sed -${E} "s,$knw_emails,${SED_GREEN},g"
