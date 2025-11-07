#!/bin/bash

#./int_files_dir/homes.sh
#./int_files_dir/mail.sh
source /home/serveruser1/Linpeas_my/global.sh
#./homes.sh
#./mail.sh
#./sh_path.sh
#./executable.sh
#./*.sh
#echo $HOMESEARCH

for script in ./*/*.sh; do
	source "$script"
done

#for script in ./simple_checks/*.sh; do
#	source "$script"
#done

echo $ROOT_FOLDER
