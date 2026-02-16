#!/bin/bash

print_2title "sudo -l and /etc/sudoers |.d"

(echo '' \
| timeout 1 sudo -S -l \
| sed "s,_proxy,${SED_RED},g" \
| sed "s,$sudoG,${SED_GREEN},g" \
| sed -${E} "s,$sudoVB,${SED_RED_YELLOW}," \
| sed -${E} "s,$sudoB,${SED_RED},g" \
| sed "s,\!root,${SED_RED},") 2>/dev/null \
|| echo_not_found "sudo"

  
if [ "$PASSWORD" ]; 
then
  (echo "$PASSWORD" \
  | timeout 1 sudo -S -l \
  | sed "s,_proxy,${SED_RED},g" \
  | sed "s,$sudoG,${SED_GREEN},g" \
  | sed -${E} "s,$sudoVB,${SED_RED_YELLOW}," \
  | sed -${E} "s,$sudoB,${SED_RED},g") 2>/dev/null  \
  || echo_not_found "sudo"
fi

( grep -Iv "^$" cat /etc/sudoers \
| grep -v "#" \
| sed "s,_proxy,${SED_RED},g" \
| sed "s,$sudoG,${SED_GREEN},g" \
| sed -${E} "s,$sudoVB,${SED_RED_YELLOW}," \
| sed -${E} "s,$sudoB,${SED_RED},g" \
| sed "s,pwfeedback,${SED_RED},g" ) 2>/dev/null  \
|| echo_not_found "/etc/sudoers"

if ! [ "$IAMROOT" ] && [ -w '/etc/sudoers.d/' ]; 
then
  echo "You can create a file in /etc/sudoers.d/ and escalate privileges" | sed -${E} "s,.*,${SED_RED_YELLOW},"
fi

for f in /etc/sudoers.d/*; do
  if [ -r "$f" ]; then
    echo "Sudoers file: $f is readable" | sed -${E} "s,.*,${SED_RED},g"
    grep -Iv "^$" "$f" | grep -v "#" | sed "s,_proxy,${SED_RED},g" | sed "s,$sudoG,${SED_GREEN},g" | sed -${E} "s,$sudoVB,${SED_RED_YELLOW}," | sed -${E} "s,$sudoB,${SED_RED},g" | sed "s,pwfeedback,${SED_RED},g"
  fi
done
echo ""