#!/bin/bash
for master_file in $(find /master/ -type f)
do
    backup_file=${master_file/master/backup}
	if [ ! -e $backup_file ]
	then
		echo "$backup_file文件丢失"
	else
	master_md5=$(md5sum $master_file | awk '{print $1}')
	backup_md5=$(md5sum $backup_file | awk '{print $1}')
		if [ $master_md5 != $backup_md5 ]
		then
			echo "$master_file数据不一致"
		fi
	fi
done

