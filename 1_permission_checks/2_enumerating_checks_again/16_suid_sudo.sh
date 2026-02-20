#!/bin/bash

print_2title "sudo -l and /etc/sudoers | sudoers.d"


read -s -p "Enter sudo password: " PASSWORD
echo ""  # Newline after hidden input
(echo "$PASSWORD" \
| timeout 1 sudo -S -l \
| sed "s,_proxy,${SED_RED},g" \
| sed "s,$sudoG,${SED_GREEN},g" \
| sed -${E} "s,$sudoVB,${SED_RED_YELLOW}," \
| sed -${E} "s,$sudoB,${SED_RED},g" \
| sed "s,\!root,${SED_RED},") 2>/dev/null \
|| echo_not_found "sudo"

unset $PASSWORD

( grep -Iv "^$" cat /etc/sudoers \
| grep -v "#" \
| sed "s,_proxy,${SED_RED},g" \
| sed "s,$sudoG,${SED_GREEN},g" \
| sed -${E} "s,$sudoVB,${SED_RED_YELLOW}," \
| sed -${E} "s,$sudoB,${SED_RED},g" \
| sed "s,pwfeedback,${SED_RED},g" ) 2>/dev/null  \
|| echo_not_found "/etc/sudoers"

#вдруг можем писать в судоерс лол
if ! [ "$IAMROOT" ] && [ -w '/etc/sudoers.d/' ]; 
then
  echo "You can create a file in /etc/sudoers.d/ and escalate privileges" | sed -${E} "s,.*,${SED_RED_YELLOW},"
fi

#вдруг можем читать что-то в судоерс
for f in /etc/sudoers.d/*; do
  if [ -r "$f" ]; then
    echo "Sudoers file: $f is readable" | sed -${E} "s,.*,${SED_RED},g"
    grep -Iv "^$" "$f" | grep -v "#" | sed "s,_proxy,${SED_RED},g" | sed "s,$sudoG,${SED_GREEN},g" | sed -${E} "s,$sudoVB,${SED_RED_YELLOW}," | sed -${E} "s,$sudoB,${SED_RED},g" | sed "s,pwfeedback,${SED_RED},g"
  fi
done
echo ""