#!bin/bash

print_2title "Environmental variables in /proc/environ hopefully clean "
cat /proc/[0-9]*/environ 2>/dev/null \
| tr '\0' '\n' \
| grep -Eiv "$NoEnvVars" \
| sort -u \
| sed -${E} "s,$EnvVarsRed,${SED_RED},g"
