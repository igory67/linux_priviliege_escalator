#!/bin/bash

print_2title "Searching a lot of passwords for a lot of time, add a flag here to not run this (or a flag to run this better yet)"

timeout 150 find $HOMESEARCH -exec grep -HnRiIE "($pwd_in_variables1|$pwd_in_variables2|$pwd_in_variables3|$pwd_in_variables4|$pwd_in_variables5|$pwd_in_variables6|$pwd_in_variables7|$pwd_in_variables8|$pwd_in_variables9|$pwd_in_variables10|$pwd_in_variables11).*[=:].+" '{}' \; 2>/dev/null \
| sed '/^.\{150\}./d' \
| grep -Ev "^#" \
| grep -iv "linpeas" \
| sort \
| uniq \
| head -n 70 \
| sed -${E} "s,$pwd_in_variables1,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables2,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables3,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables4,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables5,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables6,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables7,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables8,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables9,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables10,${SED_RED},g" \
| sed -${E} "s,$pwd_in_variables11,${SED_RED},g" \
& timeout 150 find /var/www $backup_folders_row /tmp /etc /mnt /private -exec grep -HnRiIE "($pwd_in_variables1|$pwd_in_variables2|$pwd_in_variables3|$pwd_in_variables4|$pwd_in_variables5|$pwd_in_variables6|$pwd_in_variables7|$pwd_in_variables8|$pwd_in_variables9|$pwd_in_variables10|$pwd_in_variables11).*[=:].+" '{}' \; 2>/dev/null | sed '/^.\{150\}./d' | grep -Ev "^#" | grep -iv "linpeas" | sort | uniq | head -n 70 | sed -${E} "s,$pwd_in_variables1,${SED_RED},g" | sed -${E} "s,$pwd_in_variables2,${SED_RED},g" | sed -${E} "s,$pwd_in_variables3,${SED_RED},g" | sed -${E} "s,$pwd_in_variables4,${SED_RED},g" | sed -${E} "s,$pwd_in_variables5,${SED_RED},g" | sed -${E} "s,$pwd_in_variables6,${SED_RED},g" | sed -${E} "s,$pwd_in_variables7,${SED_RED},g" | sed -${E} "s,$pwd_in_variables8,${SED_RED},g" | sed -${E} "s,$pwd_in_variables9,${SED_RED},g" | sed -${E} "s,$pwd_in_variables10,${SED_RED},g" | sed -${E} "s,$pwd_in_variables11,${SED_RED},g" &

wait
echo ""

##-- IF) Find possible conf files with passwords
print_2title "Searching for passwords in config files"
if ! [ "$SEARCH_IN_FOLDER" ]; then
ppicf=$(timeout 150 find $HOMESEARCH /var/www/ /usr/local/www/ /etc /opt /tmp /private /Applications /mnt -name "*.conf" -o -name "*.cnf" -o -name "*.config" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" 2>/dev/null)
else
ppicf=$(timeout 150 find $SEARCH_IN_FOLDER -name "*.conf" -o -name "*.cnf" -o -name "*.config" -o -name "*.json" -o -name "*.yml" -o -name "*.yaml" 2>/dev/null)
fi
printf "%s\n" "$ppicf" | while read f; do
if grep -qEiI 'passwd.*|creden.*|^kind:\W?Secret|\Wenv:|\Wsecret:|\WsecretName:|^kind:\W?EncryptionConfiguration|\-\-encryption\-provider\-config' "$f" 2>/dev/null; then
echo "$ITALIC $f$NC"
grep -HnEiIo 'passwd.*|creden.*|^kind:\W?Secret|\Wenv:|\Wsecret:|\WsecretName:|^kind:\W?EncryptionConfiguration|\-\-encryption\-provider\-config' "$f" 2>/dev/null | sed -${E} "s,[pP][aA][sS][sS][wW]|[cC][rR][eE][dD][eE][nN],${SED_RED},g"
fi
done
echo ""
