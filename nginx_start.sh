#!/bin/bash
nginx_admin=/etc/nginx/sbin/nginx
nginx_pid=/etc/nginx/logs/nginx.pid
if [ -z $1 ]
then
    echo "帮助$0(start|stop|reload|status|restart)"
    exit 2
else
    case $1 in
	start)
	    if $(cat $nginx_pid &> /dev/null);then
		 echo "nginx 已经启动啦 别tmd再start啦"
	   	 exit 2
	    else
	   	 $nginx_admin
	   	 if [ $? -eq 0 ];then
			echo "start success"
	   	 else
			echo "start falid"
	   	 fi
	    fi
	    ;;
	stop)
	    $nginx_admin -s stop
	    
	    ;;
	status)
	    if $(cat $nginx_pid &> /dev/null);then
		echo "nginx is starting"
	    else
		echo "nginx is stoping"
	    fi
	    ;;
	restart)
	    $nginx_admin -s stop &>/dev/null
	    sleep 1
	    $nginx_admin
	    ;;
	reload)
	    kill -HUP $(cat $nginx_pid)
	    ;;
	*)
	    echo "帮助$0(start|stop|reload|status|restart)"
            exit 2
	    ;;
    esac
fi
