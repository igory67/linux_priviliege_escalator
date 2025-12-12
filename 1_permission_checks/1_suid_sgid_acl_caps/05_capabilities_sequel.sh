#!/bin/bash



echo ""
print_info "Parent process capabilities"
cat "/proc/$PPID/status" | grep Cap | while read -r cap_line; do
    cap_name=$(echo "$cap_line" | awk '{print $1}')
    cap_value=$(echo "$cap_line" | awk '{print $2}')
    if [ "$cap_name" = "CapEff:" ]; then
    # Add validation check for cap_value
    if [[ "$cap_value" =~ ^[0-9a-fA-F]+$ ]]; then
        # Memory errors can occur with certain values (e.g., ffffffffffffffff)
        # so we redirect stderr to prevent error propagation
        echo "$cap_name	 $(capsh --decode=0x"$cap_value" 2>/dev/null \
        | sed -${E} "s,$capsB,${SED_RED_YELLOW},")"
    else
        echo "$cap_name	 [Invalid capability format]"
    fi
    else
    # Add validation check for cap_value
    if [[ "$cap_value" =~ ^[0-9a-fA-F]+$ ]]; then
        # Memory errors can occur with certain values (e.g., ffffffffffffffff)
        # so we redirect stderr to prevent error propagation
        echo "$cap_name	 $(capsh --decode=0x"$cap_value" 2>/dev/null \
        | sed -${E} "s,$capsB,${SED_RED},")"
    else
        echo "$cap_name	 [Invalid capability format]"
    fi
    fi
done
echo ""

else
print_3title "Current shell capabilities"
(cat "/proc/$$/status" \
| grep Cap \
| sed -${E} "s,.*0000000000000000|CapBnd:	0000003fffffffff,${SED_GREEN},") 2>/dev/null \
|| echo_not_found "/proc/$$/status"
echo ""

print_3title "Parent proc capabilities"
(cat "/proc/$PPID/status" \
| grep Cap \
| sed -${E} "s,.*0000000000000000|CapBnd:	0000003fffffffff,${SED_GREEN},") 2>/dev/null \
|| echo_not_found "/proc/$PPID/status"
echo ""
fi
echo ""
echo "Files with capabilities (limited to 50):"
getcap -r / 2>/dev/null | head -n 50 | while read cb; do
capsVB_vuln=""

for capVB in $capsVB; do
    capname="$(echo $capVB | cut -d ':' -f 1)"
    capbins="$(echo $capVB | cut -d ':' -f 2)"
    if [ "$(echo $cb | grep -Ei $capname)" ] && [ "$(echo $cb | grep -E $capbins)" ]; then
    echo "$cb" | sed -${E} "s,.*,${SED_RED_YELLOW},"
    capsVB_vuln="1"
    break
    fi
done

if ! [ "$capsVB_vuln" ]; then
    echo "$cb" | sed -${E} "s,$capsB,${SED_RED},"
fi
if ! [ "$IAMROOT" ] && [ -w "$(echo $cb | cut -d" " -f1)" ]; then
    echo "$cb is writable" | sed -${E} "s,.*,${SED_RED},"
fi
done
echo ""
