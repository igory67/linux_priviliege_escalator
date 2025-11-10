#!/bin/bash
source global.sh

echo "cd ../Linpeas_my/simple_checks/" | grep -Ei "pwd_inside_history"
