#!/bin/bash
accepts=$(curl -k https://wordpress.linux.com/status 2>/dev/null | awk 'NR==3{print $1}')
handled=$(curl -k https://wordpress.linux.com/status 2>/dev/null | awk 'NR==3{print $2}')
handled=$(($handled-1))
nginx_status=$(($accepts-$handled))
echo "$nginx_status"
if [ $nginx_status -lt 10 ]
then
	echo "网址正常"
else
	echo "网站炸啦"
fi
