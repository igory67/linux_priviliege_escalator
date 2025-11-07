#!/bin/bash

source /home/serveruser1/Linpeas_my/global.sh

for script in ./simple_checks/*.sh; do
	source "$script"
done

echo $ROOT_FOLDER
