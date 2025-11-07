#!/bin/bash

print_2title "Readable files in temporary and backup folders (up to 70)"

filstmpback=$(find /tmp /var/tmp /private/tmp /private/var/at/tmp /private/var/tmp -type f 2>/dev/null \
| grep -Ev "dpkg\.statoverride\|.dpkg\.status\.|apt\.extended_states\.|dpkg\.diversions\." \
| head -n 70)

#filstmpback=$(find /tmp -type f \
#| grep -Ev "dpkg\.statoverride\|.dpkg\.status\.|apt\.extended_states\.|dpkg\.diversions\.")

printf "\n"
printf "%s \n" "$filstmpback" \
| while read f; do if [ -r "$f" ]; then ll "$f" 2>/dev/null; fi; done
echo ""
echo ""

echo "$filstmpback"
