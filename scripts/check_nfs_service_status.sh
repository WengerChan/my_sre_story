#! /usr/bin/env bash

#=============================================
# Script Name: check_nfs_service_status.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-xx-xx
#       Usage: bash check_nfs_service_status.sh
# Description: 监控nfs挂载目录, 若出现异常发出告警
#              返回值：0=正常, 1=客户端异常, 2=服务端异常
#=============================================

# Define variables -- BEGIN #
DATE="$(date +'%F %H:%M:%S')"
nfs_check_log_file='/var/log/nfscheck.log'
nfs_server='192.168.1.12'
nfs_mount_point='/mnt'
# Define variables -- END #

# Script Body -- BEGIN #
[ -f "${nfs_check_log_file}" ] || touch ${nfs_check_log_file}

read -t1 < <(stat -t "${nfs_mount_point}")
if [ $? -eq 0 ]; then
    rpcinfo -t ${nfs_server} nfs > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "${DATE} Success! " >> ${nfs_check_log_file}
        exit 0
    else
        echo "${DATE} Server Error! " >> ${nfs_check_log_file}
        exit 2
    fi
else
    echo "${DATE} Client Error! " >> ${nfs_check_log_file}
    exit 1
fi
# Script Body -- END #