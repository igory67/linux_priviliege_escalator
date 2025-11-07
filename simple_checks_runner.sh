#!/bin/bash

./simple_checks.sh | tee output.txt && less -R output.txt && rm output.txt
echo "done, check if rm output.txt worked!"
echo ""
