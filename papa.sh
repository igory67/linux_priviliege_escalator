#!/bin/bash

#./int_files_dir/homes.sh
#./int_files_dir/mail.sh
#source /home/serveruser1/Linpeas_my/global.sh
source global.sh
#./homes.sh
#./mail.sh
#./sh_path.sh
#./executable.sh
#./*.sh
#echo $HOMESEARCH


#source 1*/00*.sh
for script in ./1*/*.sh; do
#for script in $(ls -r ./*/*/| sort -n); do
	source "$script"
done


source 2*/00*.sh
for script in ./2*/*/*.sh; do 
	source "$script"
done

#for script in ./simple_checks/*.sh; do
#	source "$script"
#done

echo $ROOT_FOLDER
