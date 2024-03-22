#!/bin/bash

#备份
mkdir /etc/yum.bak &> /dev/null 
cp /etc/yum.repos.d/* /etc/yum.bak &> /dev/null
#挂载
mkdir /mnt/cdrom 
echo '/dev/sr0 /mnt/cdrom iso9660 defaults 0 0' >> /etc/fstab
mount -a &> /dev/null
#编写本地源
echo -e '[local]\nname=centos7\nbaseurl=file:///mnt/cdrom\ngpgcheck=0' > /etc/yum.repos.d/yum.repo
#测试
yum clean all &> /dev/null
yum repolist all
