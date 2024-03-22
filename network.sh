#!/bin/bash
ip_add=$(ip a s ens33 | grep inet | awk 'NR==1{print $2}' | awk -F/ '{print $1}')
ip_way=$(route -n | awk 'NR==3{print $2}')
echo "BOOTPROTO=static
DEVICE=ens33
ONBOOT=yes
IPADDR="$ip_add"
GATEWAY="$ip_way"
NETMASK=255.255.255.0
DNS1=114.114.114.114
" > /etc/sysconfig/network-scripts/ifcfg-ens33
