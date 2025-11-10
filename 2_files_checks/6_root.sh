print_2title "unexpected in /root "
(find $ROOT_FOLDER -maxdepth 1 | grep -E -v "$commonrootdirsG" | sed -${E} "s,.*,${SED_RED},") || echo_not_found
echo ""
