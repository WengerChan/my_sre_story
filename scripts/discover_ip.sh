#! /usr/bin/env bash

#=============================================
# Script Name: discover_ip.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: bash discover_ip.sh
# Description: CMDB采集ip信息
#=============================================

# Define variables -- BEGIN #
Host_IP=''      # 主机IP：与蓝鲸连接的ip认定为主机IP
Backup_IP=''    # 备份IP：特定网段
Heartbeat_IP='' # 心跳IP：特定网段
Scan_IP=''      # scan IP
V_IP=''         # 数据库vip、业务访问vip等
Other_IP=''     # 其他IP：多IP
# Define variables -- END #

# Script Body -- BEGIN #

## Define Functions

function ip_To_Number(){

    # 将ip转换为数字
    if [ -z "$1" ]; then
        exit 98
    fi
    echo $1 | gawk '{C=256; split($0,IP,"."); print IP[4]+IP[3]*C+IP[2]*C^2+IP[1]*C^3}'

}


function is_Backup_IP(){

    IP_NUMBER=$(ip_To_Number $1)

    for i in {3..5}; do
        if eval '[ '$IP_NUMBER' -ge ''${BackupIP_Min_zone'$i'} ] && [ '$IP_NUMBER' -le ${BackupIP_Max_zone'$i'} ]'; then
            Backup_IP=$1 && return 0
        fi
    done

    return 98

}


function is_Heartbeat_IP(){

    IP_NUMBER=$(ip_To_Number "$1")

    for i in {3..5}; do
    
        if eval '[ '$IP_NUMBER' -ge ''${HeartBeat_Min_zone'$i'} ] && [ '$IP_NUMBER' -le ${HeartBeat_Max_zone'$i'} ]'; then
            Heartbeat_IP=$1 && return 0
        fi

    done

    return 98

}


function is_Scan_IP(){

    HOSTS_SCAN=$(grep -i 'scan' /etc/hosts |grep -v '^#'| awk -F' ' '{print $1}')

    if [ -n "$HOSTS_SCAN" ]; then

            ORACLE_VERSION=$(su - grid -c "sqlplus -V" 2> /dev/null | grep -aPo '(?<=Release\s)\d{2}')

            case $ORACLE_VERSION in
            19)
                Scan_IP=$(su - grid -c "srvctl config scan" 2> /dev/null | grep -aPo '(?<=VIP\:\s)[0-9.]{7,15}') && return 0 ;;
            11)
                Scan_IP=$(su - grid -c "srvctl config scan" 2> /dev/null | grep 'VIP' | awk -F'/' '{print $NF}') && return 0 ;;
            *)
                return 98 ;;
            esac

    else
        return 98
    fi

}


function is_V_IP(){

    if ( ifconfig | sed 's/^$/#/g' | tr '\n#' ' \n' | grep "$1" | grep 'RX.*TX' &> /dev/null ); then
        return 98
    else
        V_IP="$1;$V_IP"
        V_IP="${V_IP%;}"

        return 0
    fi

}


function is_Other_IP(){

    Other_IP="$1;$Other_IP"
    Other_IP="${Other_IP%;}"

}


function set_Backup_IP_Range(){

    #备份ip所在的网段：
    #   IV区服务器备份      172.16.8.0-172.16.11.255    255.255.252.0
    #   V区服务器备份       172.16.12.0-172.16.13.255   255.255.254.0
    #   III区服务器备份     172.16.16.0-172.16.17.255   255.255.254.0
    BackupIP_Min_zone3=$(ip_To_Number 172.16.16.0)
    BackupIP_Max_zone3=$(ip_To_Number 172.16.17.255)
    BackupIP_Min_zone4=$(ip_To_Number 172.16.8.0)
    BackupIP_Max_zone4=$(ip_To_Number 172.16.11.255)
    BackupIP_Min_zone5=$(ip_To_Number 172.16.12.0)
    BackupIP_Max_zone5=$(ip_To_Number 172.16.13.255)

}


function set_HeartBeat_IP_Range(){

    #心跳ip所在的网段：
    #   IV区服务器心跳      172.29.4.0-172.29.7.255     255.255.252.0
    #   III服务器心跳       172.29.40.0-172.29.41.255   255.255.254.0
    #   V区服务器心跳       172.29.42.0-172.29.43.255   255.255.254.0
    HeartBeat_Min_zone3=$(ip_To_Number 172.29.40.0)
    HeartBeat_Max_zone3=$(ip_To_Number 172.29.41.255)
    HeartBeat_Min_zone4=$(ip_To_Number 172.29.4.0)
    HeartBeat_Max_zone4=$(ip_To_Number 172.29.7.255)
    HeartBeat_Min_zone5=$(ip_To_Number 172.29.42.0)
    HeartBeat_Max_zone5=$(ip_To_Number 172.29.43.255)

}


## Main Function
function main(){
    
    #1.Host_IP
    Host_IP=$(netstat -an | grep 48668 | grep 'ESTABLISHED' | grep -E '10.150.45.(217|218)|172.20.2.150' | awk -F':' '{print $1}' | awk -F' ' '{print $NF}')

    #2.Scan_IP
    is_Scan_IP

    IP_LIST=(`ip addr | grep 'inet\b' | awk -F'/' '{print $1}' | awk -F' ' '{print $NF}' | grep -v -E "^(127|169|192)"`)
    #IP_LIST=(172.29.5.107 192.168.1.11 172.16.13.255 192.168.1.11) #测试用
    
    #3.Backup_IP, Heartbeat_IP, V_IP, Other_IP
    if [ "${IP_LIST[*]}" == "$Host_IP" ]; then
        return 0
    else
        set_Backup_IP_Range
        set_HeartBeat_IP_Range

        for IP in ${IP_LIST[*]}; do

            if [ "$IP" == "$Host_IP" ] || [ "$IP" == "$Scan_IP" ]; then
                continue
            fi

            is_Backup_IP "$IP" && continue
            is_Heartbeat_IP "$IP" && continue
            is_V_IP "$IP" && continue
            is_Other_IP "$IP"

        done
    fi

    #echo {'"'Backup_IP'"': '"'$Backup_IP'"', '"'Heartbeat_IP'"': '"'$Heartbeat_IP'"', '"'Scan_IP'"': '"'$Scan_IP'"', '"'V_IP'"': '"'$V_IP'"', '"'Other_IP'"': '"'$Other_IP'"'}
    echo {'"'Host_IP'"': '"'$Host_IP'"', '"'Backup_IP'"': '"'$Backup_IP'"', '"'Heartbeat_IP'"': '"'$Heartbeat_IP'"', '"'Scan_IP'"': '"'$Scan_IP'"', '"'V_IP'"': '"'$V_IP'"', '"'Other_IP'"': '"'$Other_IP'"'}

}


## Call Main Function
main 

# Script Body -- END #