#! /usr/bin/env bash

#=======================================================================
# Script Name: dzfp_restart.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: bash dzfp_restart.sh
# Description: 检查/data01磁盘是否可以正常访问，如果异常将尝试修复(重启服务)
#========================================================================

# Define variables -- BEGIN #
DATE=$(date +'%F %H:%M')
# Define variables -- END #

# Script Body -- BEGIN #

## Define Functions
reloadService() {

    #杀掉所有sshd进程，通过集群命令重启VFSTPD_dzfp服务

    systemctl stop sshd
    
    SSHD_PID=$(ps -ef |grep sshd | grep -v grep | awk -F' ' '{print $2}' |tr '\n' ' ')
    kill -9 ${SSHD_PID}
    
    pcs resource disable VFSTPD_dzfp
    sleep 10
    
    df -hT | grep '/data01' &> /dev/null || pcs resource enable VFSTPD_dzfp
    sleep 10
    
    df -hT | grep '/data01' &> /dev/null && ls /data01 &> /dev/null && systemctl start sshd
    
    [ $? -eq 0 ] && echo "${DATE}=======检查/data01异常, 处理完成..."
}

## Main
ls /data01 > /dev/null
[ $? -ne 0 ] && (echo "${DATE}=======检查/data01异常，正在执行脚本处理...";reloadService) \
             || (echo "${DATE}=======检查/data01正常";exit 0)

# Script Body -- END #