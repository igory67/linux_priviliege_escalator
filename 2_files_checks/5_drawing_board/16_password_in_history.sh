#!/bin/bash -i
#!/bin/bash -i

print_2title "password in cmd history"
# print_2title "passwords in history files"

for histfile in "$HOME/.bash_history" "$HOME/.zsh_history" "$HOME/.ash_history" "$HOME/.histfile"; do
    [ -f "$histfile" ] && grep -Ei "$pwd_inside_history" 2>/dev/null | sed -${E} "s,$pwd_inside_history,${SED_RED},"
done

# Search root's history files if we're root
if [ "$IAMROOT" -eq 1 ]; then
    for histfile in "/root/.bash_history" "/root/.zsh_history" "/root/.ash_history" "/root/.histfile"; do
        [ -f "$histfile" ] && grep -Ei "$pwd_inside_history" 2>/dev/null | sed -${E} "s,$pwd_inside_history,${SED_RED},"
    done
fi

echo ""
#if [ "$(history 2>/dev/null)" ]; then
# #	history | grep -Ei "$pwd_inside_history" "$f" 2>/dev/null \
# history | grep -Ei "$pwd_inside_history" 2>/dev/null \
# | sed -${E} "s,$pwd_inside_history,${SED_RED},"
# echo ""

# history | grep -Ei "$pwd_inside_history"
# history | grep -i passw

#fi
# $HOME/.bash_history | grep passw
#qecho $pwd_inside_history
