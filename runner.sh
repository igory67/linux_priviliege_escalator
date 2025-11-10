#!/bin/bash

./papa.sh | tee output.txt && less -R output.txt 
# && rm output.txt
echo "done, check if rm output.txt worked! (disabled for now)"
echo ""
