#! /bin/bash
# Author: Allen
# Descripttion: Collect server information
# company:
################################################################
export LANG="en_US.UTF-8"
systemnum=`cat /etc/redhat-release |grep -o '[0-9]' |head -n 1`
system_type=`dmesg |grep -i hypervisor`

#空口令的帐号
emptypasswd=`awk -F: '($2 == "") { print $1 }' /etc/shadow |tr '
' ',' |sed "s/\,$//g"`
if [ "$emptypasswd" ];then
    echo "empty_password_account=${emptypasswd}@@1"
else
    echo "empty_password_account=null@@0"
fi

#UID为0的非root帐号
uid0=`awk -F: '($3 == 0) { print $1 }' /etc/passwd |grep -v root |tr '\n' ',' |sed "s/\,$//g"`
if [ -n "$uid0" ];then
    echo "uid0_account=${uid0}@@1"
else
    echo "uid0_account=null@@0"
fi

#协议1/2开启状态
ssh_Protocol=`cat /etc/ssh/sshd_config |grep -v "^#" |grep Protocol |awk '{print $2}'`
if [[ $ssh_Protocol -eq 2 ]];then
    echo "openssh_protocol=仅开启协议2@@0"
elif [[ $ssh_Protocol -eq 1 ]];then
    echo "openssh_protocol=仅开启协议1@@1"
elif [ ! -n "$ssh_Protocol" ];then
    echo "openssh_protocol=未配置@@1"
else
    echo "openssh_protocol=既开启了协议2，也开启了协议1@@1"
fi

#远程root是否开启
ssh_root=`cat /etc/ssh/sshd_config |grep -v "^#" |grep PermitRootLogin |grep yes`
if [ -n "${ssh_root}" ];then
    echo "root_remote=未关闭@@1"
else
    echo "root_remote=关闭@@0"
fi

#日志审核
case $systemnum in
5)
service syslog status &>/dev/null
syslog=$?
if [ "${syslog}" -eq 0 ];then
    echo "syslog_audit=启用@@0"
else
    echo "syslog_audit=未启用@@1"
fi;;
7)
systemctl status systemd-journald.service &>/dev/null
systemd_journald=$?
if [ "${systemd_journald}" -eq 0 ];then
    echo "syslog_audit=启用@@0"
else
    echo "syslog_audit=未启用@@1"
fi
;;
*)
service rsyslog status &>/dev/null
rsyslog=$?
if [ "${rsyslog}" -eq 0 ];then
    echo "syslog_audit=启用@@0"
else
    echo "syslog_audit=未启用@@1"
fi
;;
esac

#系统审计
case $systemnum in
7)
systemctl status auditd.service &> /dev/null
audit=$?
if [ "${audit}" -eq 0 ];then
    echo "sys_audit=启用@@0"
else
    echo "sys_audit=未启用@@1"
fi
;;
*)
service auditd status &>/dev/null
audit=$?
if [ "${audit}" -eq 0 ];then
    echo "sys_audit=启用@@0"
else
    echo "sys_audit=未启用@@1"
fi
;;
esac

#登录失败次数（2H）
login_failed_times=100
a=`date +%s`
b=`expr $a - 7200`
c=`date -d @$b "+%Y%m%d%H%M%S"`
l_total=`lastb |grep -v btmp |grep -v ^$ |wc -l`
l_befor=`lastb -t $c |grep -v btmp |grep -v ^$ |wc -l`
l_end=`expr $l_total - $l_befor`
lastb=`lastb |sed -n 1,${l_end}p |wc -l`
if [ $lastb -gt ${login_failed_times} ];then
    echo "login_failed_times=${lastb}@@1"
else
    echo "login_failed_times=${lastb}@@0"
fi


#-----------------------------------------------------------------------------------------------------------------------


#!/bin/bash

################################################################
#export LANG="en_US.UTF-8"
export LANG=C LC_ALL=C
systemnum=`cat /etc/redhat-release |grep -o '[0-9]' |head -n 1`
system_type=`dmesg |grep -i hypervisor`
################################################################

sleep_time=5
a=1
end=12

while true;
do
#cpu使用率数据采集
case $systemnum in
5|6)
    #cpu_idle_rate=`top -bn 1| head -n 5 |grep "Cpu(s)" |awk -F',' '{print $4}' | awk -F% '{print $1}' | sed 's/\s*//g'`
    cpu_idle_rate=`top -bn 2| grep "Cpu(s)"| tail -n1 |awk -F',' '{print $4}'| awk -F% '{print $1}' | sed 's/\s*//g'`
    cpu_usage=$(awk "BEGIN{print 100-$cpu_idle_rate }")
    cpu_usage_all+=" $cpu_usage"
;;
*)
    #cpu_idle_rate=`top -bn 1| head -n 5 |grep "Cpu(s)" |awk -F',' '{print $4}' | awk '{print $1}'`
    cpu_idle_rate=`top -bn 2| grep "Cpu(s)"| tail -n1 |awk -F',' '{print $4}'| awk '{print $1}'`
    cpu_usage=$(awk "BEGIN{print 100-$cpu_idle_rate }")
    cpu_usage_all+=" $cpu_usage"
;;
esac

#物理内存使用率采集
line_num=`free -m|wc -l`
mem_total=`free -m |grep Mem |awk '{print $2}'`
if [ $line_num -eq 4 ]; then
    mem_used=`free -m|sed -n '3p'|awk '{print $3}'`
else
    mem_used=`free -m |grep Mem |awk '{print $3}'`
fi
per=`awk 'BEGIN{printf "%0.2f",('$mem_used'/'$mem_total')*100}'`
per_all+=" $per"

#物理内存可用内存采集
mem_free=`free -m |grep Mem |awk '{print $4}'`
mem_free_all+=" $mem_free"

#交换分区使用率采集
swap_used=`free -m |grep -i swap |awk '{print $3}'`
swap_total=`free -m |grep -i swap |awk '{print $2}'`
swap_per=`awk 'BEGIN{printf "%0.1f",('$swap_used'/'$swap_total')*100}'`
swap_per_all+=" $swap_per"

#交换分区可用空间采集
swap_free=`free -m |grep -i swap |awk '{print $4}'`
swap_free_all+=" $swap_free"

#硬盘IO使用率采集
iostat=`which iostat 2>/dev/null`
if [ -n "$iostat" ];then
    diskio_usage_all+="$(iostat -xd |sed '1d' |grep -v "^$" |grep -v "dm" |sed  "1d"  |awk '{print $NF}' |tr '\n' ' ')@"
fi

#磁盘空间使用率采集
disk_space_usage_all+="$(df -hPBM |grep -v "/dev/sr" |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d' |awk '{print $5}' | tr '\n' ' ')@"


#磁盘可用空间采集
disk_space_avail_all+="$(df -hPBM |grep -v "/dev/sr" |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d' |awk '{print $4}' |sed 's/M//g' | tr '\n' ' ')@"

#Inode使用率采集
disk_Inode_usage_all+="$(df -hiTPBK |grep -v "/dev/sr" |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d' |awk '{print $6}' | tr '\n' ' ')@"

#Inode可用空间采集
disk_Inode_free_all+="$(df -hiTPBK |grep -v "/dev/sr" |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d' |awk '{print $5}'  |tr '\n' ' ')@"

#ESTABLISHED状态的连接数采集
netstat=`which netstat  2>/dev/null`
if [ -n "${netstat}" ];then
    net_established_nums_all+="$(netstat -antup|grep ESTABLISHED|wc -l)@"
fi

#TIME_WAIT状态的连接数采集
netstat=`which netstat 2>/dev/null`
if [ -n "${netstat}" ];then
    net_timewait_nums_all+="$(netstat -antup|grep TIME_WAIT|wc -l)@"
fi

#网卡当前数据接收速率采集
sar=`which sar 2>/dev/null`
unit=`sar -n DEV 1 1 |grep Average|head -n 1 |awk '{print $5}'`
if [ "${unit}" == "rxbyt/s" ]; then
    if [ -n "$sar" ];then
        var=`sar -n DEV 1 1 |grep Average |grep -v lo |grep -v virbr0|sed '1d' |awk '{print $5}'  |tr '\n' ' '`
        var=`echo $var |awk '{printf("%.2f", $1/1024)}'`
        nic_rx_speed_all+="${var}@"
    fi
else
    if [ -n "$sar" ];then
        nic_rx_speed_all+="$(sar -n DEV 1 1 |grep Average |grep -v lo |grep -v virbr0|sed '1d' |awk '{print $5}'  |tr '\n' ' ')@"
    fi
fi

#网卡当前数据发送速率采集
sar=`which sar 2>/dev/null`
unit=`sar -n DEV 1 1 |grep Average|head -n 1 |awk '{print $6}'`
if [ "${unit}" == "txbyt/s" ]; then
    if [ -n "$sar" ];then
        var=`sar -n DEV 1 1 |grep Average |grep -v lo |grep -v virbr0|sed '1d' |awk '{print $6}'  |tr '\n' ' '`
        var=`echo $var |awk '{printf("%.2f", $1/1024)}'`
        nic_tx_speed_all+="${var}@"
    fi
else
    if [ -n "$sar" ];then
        nic_tx_speed_all+="$(sar -n DEV 1 1 |grep Average |grep -v lo |grep -v virbr0|sed '1d' |awk '{print $6}'  |tr '\n' ' ')@"
    fi
fi


sleep $sleep_time
let a=$a+1
if [ $a -ge $end ];then
    break
fi
done

#cpu使用率结果输出
cpu_usage=$(echo $cpu_usage_all |tr ' ' '\n' |awk '{sum+=$1} END {printf("%.2f", sum/NR)}')
echo "cpu_usage=$cpu_usage"

#系统负载状况15min
sys_load_info_15=`uptime |awk '{print $NF}'`
echo "sys_load_info_15=${sys_load_info_15}"

#物理内存使用率输出
per=$(echo $per_all |tr ' ' '\n' |awk '{sum+=$1} END {printf("%.2f", sum/NR)}')
echo "mem_usage=$per"

#理内存可用内存输出
mem_free=$(echo $mem_free_all |tr ' ' '\n' |awk '{sum+=$1} END {printf("%.2f", sum/NR)}')
echo "mem_free=${mem_free}"

#换分区使用率输出
swap_per=$(echo $swap_per_all |tr ' ' '\n' |awk '{sum+=$1} END {printf("%.2f", sum/NR)}')
echo "swap_usage=${swap_per}"

#交换分区可用空间输出
swap_free=$(echo $swap_free_all |tr ' ' '\n' |awk '{sum+=$1} END {printf("%.2f", sum/NR)}')
echo "swap_free=$swap_free"

#硬盘IO使用率输出
which iostat &>/dev/null
if [ $? -eq 0 ];then
    disk_item=$(iostat -xd |sed '1d' |grep -v scd |grep -v "^$" |grep -v "dm" |sed  "1d" |awk '{print $1}' |tr '\n' ' ')
    flag=1
    echo -n "diskio_usage="
    for i in $disk_item
    do
	echo "${i}@$(echo ${diskio_usage_all} |tr '@' '\n' |grep -v ^$ |cut -d ' ' -f ${flag} |awk '{sum+=$1} END {printf("%.2f", sum/NR)}');" |tr -d '\n'
	let flag+=1
    done
    echo ''
else
    echo "diskio_usage=null"
fi

#磁盘空间使用率输出
disk_usag_item=$(df -hPBM |grep -v "/dev/sr"  |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d' |awk '{print $1}' |tr '\n' ' ')
flag=1
echo -n "disk_space_usage="
for i in $disk_usag_item
do
    echo "${i}@$(echo $disk_space_usage_all |tr '@' '\n' |grep -v ^$ |cut -d ' ' -f ${flag} |awk '{sum+=$1} END {printf("%.2f", sum/NR)}');" |tr -d '\n'
    let flag+=1
done
echo ''


#磁盘可用空间输出
disk_space_item=$(df -hPBM |grep -v "/dev/sr"  |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d' |awk '{print $1}' |tr '\n' ' ')
flag=1
echo -n "disk_space_avail="
for i in $disk_space_item
do
    echo "${i}@$(echo $disk_space_avail_all |tr '@' '\n' |grep -v ^$ |cut -d ' ' -f ${flag} |awk '{sum+=$1} END {printf("%.2f", sum/NR)}');" | tr -d '\n'
    let flag+=1
done
echo ''

#Inode使用率输出
disk_Inode_usage_item=$(df -hiTP |grep -v "/dev/sr"  |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d'  |awk '{print $1}')
flag=1
echo -n "disk_Inode_usage="
for i in $disk_Inode_usage_item
do
    echo "${i}@$(echo $disk_Inode_usage_all |tr '@' '\n' |grep -v ^$ |cut -d ' ' -f ${flag} |awk '{sum+=$1} END {printf("%.2f", sum/NR)}');" |
 tr -d '\n'
    let flag+=1
done
echo ''

#Inode可用空间输出
disk_Inode_usage_item=$(df -hiTP |grep -v "/dev/sr" |grep -v tmpfs |grep -v devtmpfs |grep -v "loop" |grep -v ".iso" |sed '1d' |awk '{print $1}')
flag=1
echo -n "disk_Inode_free="
for i in $disk_Inode_usage_item
do
    echo "${i}@$(echo $disk_Inode_free_all |grep -v "/dev/sr" |tr '@' '\n' |grep -v ^$ |cut -d ' ' -f ${flag} |awk '{sum+=$1} END {print sum/NR/1024}');" | tr -d '\n'
    let flag+=1
done
echo ''

#ESTABLISHED状态的连接数输出
net_established_nums=$(echo $net_established_nums_all |tr '@' '\n' |grep -v ^$ |awk '{sum+=$1} END {printf("%.2f", sum/NR)}' |awk -F. '{print $1}')
echo "net_established_nums=${net_established_nums}"

#TIME_WAIT状态的连接数输出
net_timewait_nums=$(echo $net_timewait_nums_all |tr '@' '\n' |grep -v ^$ |awk '{sum+=$1} END {printf("%.2f", sum/NR)}' |awk -F. '{print $1}')
echo "net_timewait_nums=${net_timewait_nums}"

#网卡当前数据接收速率输出
sar=`which sar 2>/dev/null`
if [ -n "$sar" ];then
    nic_item=$(sar -n DEV 1 1 |grep Average |grep -v lo |grep -v virbr0|sed '1d' |awk '{print $2}')
    flag=1
    echo -n "nic_rx_speed="
    for i in $nic_item
    do
        echo "${i}@$(echo ${nic_rx_speed_all} |tr '@' '\n' |grep -v ^$ |cut -d ' ' -f ${flag} |awk '{sum+=$1} END {printf("%.2f", sum/NR)}');" |
     tr -d '\n'
        let flag+=1
    done
    echo ''
fi
#网卡当前数据发送速率输出
sar=`which sar 2>/dev/null`
if [ -n "$sar" ];then
    nic_item=$(sar -n DEV 1 1 |grep Average |grep -v lo |grep -v virbr0|sed '1d' |awk '{print $2}')
    flag=1
    echo -n "nic_tx_speed="
    for i in $nic_item
    do
        echo "${i}@$(echo ${nic_tx_speed_all} |tr '@' '\n' |grep -v ^$ |cut -d ' ' -f ${flag} |awk '{sum+=$1} END {printf("%.2f", sum/NR)}');" |
     tr -d '\n'
        let flag+=1
    done
    echo ''
fi
