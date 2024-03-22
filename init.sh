#!/bin/bash
echo "-----------------------配置静态网络--------------------------------------"
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
echo "---------------------拉取aliyun的yum源-----------------------------------"
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo &>/dev/null

echo "----------------------关闭selinux,dns反解,关闭firewalld------------------"
systemctl disable --now firewalld &>/dev/null
sed -ri '/^SELINUX/s|enforcing|disabled|' /etc/selinux/config
sed -ri '/^#UseDNS yes/s|#UseDNS yes|UseDNS no|' /etc/ssh/sshd_config

echo "----------------------装机必备软件---------------------------------------"
yum install vim-enhanced bash-completion lftp rsync unzip ntpdate tree psmisc wget bzip2 lrzsz -y &>/dev/null

echo "----------------------时间同步-------------------------------------------"
echo "*/30 * * * * root /usr/sbin/ntpdate 120.25.115.20 &> /dev/null" >> /etc/crontab
systemctl enable --now ntpdate
