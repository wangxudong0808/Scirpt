#!/bin/bash
io_status=$(mysql -uroot -pDD.08.dd 2>/dev/null -e "show slave status\G;" | grep "Slave_IO_Running" | awk '{print $NF}' )
sql_status=$(mysql -uroot -pDD.08.dd 2>/dev/null -e "show slave status\G;" | grep -w "Slave_SQL_Running" | awk '{print $NF}' )
if [ "$io_status" == "Yes" -a "$sql_status" == "Yes" ];then
	echo "主从成功,IO=${io_status},SQL=${sql_status}"
	exit 4
fi

if [ "$io_status" == "No" -o "$io_status" == "Connecting" ];then
	echo "失败，因为IO=${io_status}"
	exit 4	
fi
if [ "$sql_status" == "No" -o "$io_status" == "Connecting" ];then
     	echo "失败，因为SQL=${sql_status}"
	exit 4
fi
	
	
