#! /usr/bin/env bash

#=============================================
# Script Name: discover_software.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: bash discover_software.sh
# Description: 蓝鲸-自定义巡检: 获取系统层面软件安装的信息
#=============================================

# Define variables -- BEGIN #
version=`cat /etc/redhat-release|grep -aPo '(?<=release\s)\d'`
# Define variables -- END #

# Script Body -- BEGIN #

## 蓝鲸代理
if [[ -n `netstat -an|egrep '10\.150\.45\.(217|218):48668'|grep -io established` ]]; then
    bkpaas_status=yes
else
    bkpaas_status=no
fi

## IT监控代理
if [ -f /opt/IBM/ITM/bin/cinfo ]; then
    if [[ -n `/opt/IBM/ITM/bin/cinfo -r|grep -io 'running'` ]]; then
        ITjiankong_status=yes
    else
        ITjiankong_status=no
    fi
else
    ITjiankong_status=no
fi

## 趋势防病毒
if [[ -n `netstat -an|grep -i 'listen'|grep 4118` ]]; then
    ds_agent_status=yes
else
    ds_agent_status=no
fi

## G01
if [[ -n `netstat -an|grep -i 'listen'|grep 5555` ]]; then
    g01_status=yes
else
    g01_status=no
fi

## SOC日志采集
case $version in
    7)
        if systemctl status rsyslog &>/dev/null;then
            if [[ -n `cat /etc/rsyslog.conf|egrep '@10\.150\.37\.199|@172\.20\.2\.77'` ]]; then
                soc_status=yes
            fi
        else
            soc_status=no
        fi
        ;;
    6)
        if service rsyslog status &>/dev/null;then
            if [[ -n `cat /etc/rsyslog.conf|egrep '@10\.150\.37\.199|@172\.20\.2\.77'` ]]; then
                soc_status=yes
            fi
        else
            soc_status=no
        fi
        ;;
    *)
        soc_status=other
        ;;
esac

## 补丁修复工具(部分服务器安装)
if [[ -n `ps aux|grep -v grep|grep 'sdmonitor'` ]]; then
    safedog_status=yes
else
    safedog_status=no
fi

## 基线核查工具(部分服务器安装)
if [ -f /CvsAgent/CvsAgent.sh ]; then
    if [[ -n `/CvsAgent/CvsAgent.sh status|grep -i 'running'` ]];then
        CvsAgent_status=yes
    fi
else
    CvsAgent_status=no
fi

echo bkpaas_status="$bkpaas_status"
echo ITjiankong_status="$ITjiankong_status"
echo ds_agent_status="$ds_agent_status"
echo g01_status="$g01_status"
echo soc_status="$soc_status"
echo safedog_status="$safedog_status"
echo CvsAgent_status="$CvsAgent_status"

# Script Body -- END #