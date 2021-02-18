#! /usr/bin/env bash

#=============================================
# Script Name: security_baseline.sh
#      Author: Wenger Chan
#     Version: V 1.4
#        Date: 2021-02-18
#       Usage: bash security_baseline.sh
# Description: 
#=============================================

# Define variables -- BEGIN #
version=`cat /etc/redhat-release|grep -aPo '(?<=release\s)\d'`
DATE=`date +%F`
## 配置密码
userPassword='Pc@3z9dj'  
rootPassword='Pc@3z9dj'
# Define variables -- END #

# Script Body -- BEGIN #

## 不支持RHEL5及以下版本
case ${version} in
  7) echo '=====RHEL7, go on=====' ;;
  6) echo '=====RHEL6, go on=====' ;;
  *) echo "=====Not support. Version:${version}. Exited====="; exit 1 ;;
esac
  

## 1.运维账号管理：锁定多余的运维账号，只保留lengdi
users=(qiuziliang liuwei pcyunwei yuanxudong laidanhui %wheel)
for i in ${users[*]}; do
  id ${i} &>/dev/null && ( passwd -l ${i} &>/dev/null
  usermod -s /sbin/nologin ${i}
  sed -i "/^${i}/d" /etc/sudoers )    
done

id lengdi &>/dev/null || useradd lengdi
grep -q "^lengdi" /etc/sudoers || sed -i '$a \lengdi  ALL=(ALL)   NOPASSWD: ALL' /etc/sudoers
echo "${userPassword}" | passwd --stdin lengdi &>/dev/null
echo "${rootPassword}" | passwd --stdin root &>/dev/null


## 2.sshd：(1)启用Protocol 2 (2)限制root远程登录
grep -q "^PermitRootLogin" /etc/ssh/sshd_config \
  && sed -i 's@\(^PermitRootLogin\).*@\1 no@g' /etc/ssh/sshd_config \
  || sed -i '$a \PermitRootLogin no' /etc/ssh/sshd_config

grep -q "^Protocol" /etc/ssh/sshd_config \
  && sed -i 's@\(^Protocol\).*@\1 2@g' /etc/ssh/sshd_config \
  || sed -i '$a \Protocol 2' /etc/ssh/sshd_config

case ${version} in
    7) systemctl restart sshd 1>/dev/null ;;
    6) service sshd restart 1>/dev/null ;;
esac


## 3.口令设置
### 口令复杂度
authconfig --savebackup=${DATE}
authconfig --updateall
 
### authconfig --restorebackup=
# 备份路径 /var/lib/authconfig/

case ${version} in
7)
  # /etc/pam.d/system-auth-ac
  grep -q "^password\s*requisite.*pam_pwquality.so" /etc/pam.d/system-auth-ac \
    && sed -i 's@\(^password\s*requisite.*pam_pwquality.so\).*@\1 retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1@g' /etc/pam.d/system-auth-ac \
    || sed -i '/password\s*requisite/i password    requisite     pam_pwquality.so retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1' /etc/pam.d/system-auth-ac
  
  # /etc/pam.d/password-auth-ac
  grep -q "^password\s*requisite.*pam_pwquality.so" /etc/pam.d/password-auth-ac \
    && sed -i 's@\(^password\s*requisite.*pam_pwquality.so\).*@\1 retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1@g' /etc/pam.d/password-auth-ac \
    || sed -i '/password\s*requisite/i password    requisite     pam_pwquality.so retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1' /etc/pam.d/password-auth-ac
  ;;
6)
  # /etc/pam.d/system-auth-ac
  grep -q "^password\s*requisite.*pam_cracklib.so" /etc/pam.d/system-auth-ac \
    && sed -i 's@\(^password\s*requisite.*pam_cracklib.so\).*@\1 retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1@g' /etc/pam.d/system-auth-ac \
    || sed -i '/password\s*requisite/i password    requisite     pam_cracklib.so retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1' /etc/pam.d/system-auth-ac
  
  # /etc/pam.d/password-auth-ac
  grep -q "^password\s*requisite.*pam_cracklib.so" /etc/pam.d/password-auth-ac \
    && sed -i 's@\(^password\s*requisite.*pam_cracklib.so\).*@\1 retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1@g' /etc/pam.d/password-auth-ac \
    || sed -i '/password\s*requisite/i password    requisite     pam_cracklib.so retry=3 minlen=10 lcredit=-1 ucredit=-2 dcredit=-4 ocredit=-1' /etc/pam.d/password-auth-ac
  ;;
esac

## 口令生存期
sed -i 's@\(^PASS_MAX_DAYS\).*@\1\t90@g' /etc/login.defs
sed -i 's@\(^PASS_MIN_DAYS\).*@\1\t1@g'  /etc/login.defs 
sed -i 's@\(^PASS_MIN_LEN\).*@\1\t8@g'   /etc/login.defs
sed -i 's@\(^PASS_WARN_AGE\).*@\1\t28@g' /etc/login.defs
ls /home/ | xargs -i chage -m1 -M90 -W28 {} 2>/dev/null
chage -m1 -M90 -W28 root


## 4.登陆设置
### 登陆超时
grep -q '^TMOUT' /etc/profile \
  && sed -i 's@\(^TMOUT\).*@\1=180@g' /etc/profile \
  || sed -i '$a \TMOUT=180' /etc/profile

# sed -i '$a \readonly TMOUT' /etc/profile

grep -q '^LOGIN_RETRIES' /etc/login.defs \
  && sed -i 's/^\(LOGIN_RETRIES\).*/\1 5/g' /etc/login.defs \
  || sed -i '$a \LOGIN_RETRIES 5' /etc/login.defs

grep -q '^LOGIN_TIMEOUT' /etc/login.defs \
  && sed -i 's/^\(LOGIN_TIMEOUT\).*/\1 60/g' /etc/login.defs \
  || sed -i '$a \LOGIN_TIMEOUT 60' /etc/login.defs

### 错误锁定
# grep -q '^auth\s*required\s*pam_tally2.so' /etc/pam.d/system-auth-ac &&\
# sed -i 's@\(^auth\s*required\s*pam_tally2.so\).*@\1 deny=3 lock_time=300 even_deny_root root_unlock_time=120@g' /etc/pam.d/system-auth-ac ||\
# sed -i '/auth\s*required\s*pam_env.so/a auth        required      pam_tally2.so deny=3 lock_time=300 even_deny_root root_unlock_time=120' /etc/pam.d/system-auth-ac

### 错误锁定
# ===等保测评2.0要求(2020.04.24)===
# 红帽7 使用命令：find / -name pam_faillock.so 在/etc/pam.d/system-auth文件和/etc/pam.d/password-auth文件中第一行配置
# auth        required      pam_faillock.so authfail silent audit deny=3 even_deny_root unlock_time=600；
# 红帽6 查看/etc/pam.d/sshd文件中第一行是否配置：
# auth required pam_tally2.so deny=3 unlock_time=300 even_deny_root root_unlock_time=300 audit

sed -i '/auth\s*required\s*pam_env.so/a auth        required      pam_tally2.so deny=3 lock_time=300 even_deny_root root_unlock_time=600' /etc/pam.d/system-auth-ac
sed -i '/auth\s*required\s*pam_env.so/a auth        required      pam_tally2.so deny=3 unlock_time=300 even_deny_root root_unlock_time=600' /etc/pam.d/password-auth-ac


## 5.禁用服务
SERVICEOFF=("NetworkManager" "abrt-ccpp" "ip6tables" "firewalld" "iptables" "cups" "atd" "avahi-daemon" "bluetooth" "cpuspeed" "acpid" "apmd" "pcscd" "xinetd" "netconsole" "wpa_supplicant" "mdmonitor" "nfslock" "autofs" "netfs")
case ${version} in
    7) 
        for i in ${SERVICEOFF[*]}; do
            systemctl status ${i} &>/dev/null && systemctl stop ${i} &>/dev/null
            systemctl is-enabled ${i} &>/dev/null && systemctl disable ${i} &>/dev/null
        done ;;
    6)
        for i in ${SERVICEOFF[*]}; do
            service ${i} status &>/dev/null && service ${i} stop &>/dev/null
            chkconfig ${i} off
        done ;;
esac

setenforce Permissive
sed -i 's@\(SELINUX\).*@\1=disabled@g' /etc/selinux/config


## 6.日志
### 日志转储
grep -q "^[^#].*@10.150.37.199" /etc/rsyslog.conf \
  && sed -i 's$^[^#].*\(@10.150.37.199\)$\*\.info \1$g' /etc/rsyslog.conf \
  || sed -i '$a \*.info @10.150.37.199' /etc/rsyslog.conf
### egrep -q "^[^#].*(172.20.2.77|172.20.4.77)" /etc/rsyslog.conf && sed -i -r 's$^[^#].*((@172.20.2.77|@172.20.4.77))$\*\.info \1$g' /etc/rsyslog.conf || sed -i '$a \*.info @172.20.2.77\n*.info @172.20.4.77' /etc/rsyslog.conf
chmod 400 /etc/rsyslog.conf

### 保存时间30*7=210
sed -i 's/rotate\s[0-9]*/rotate 30/g' /etc/logrotate.conf


## 7.性能策略
egrep -q "^\*\s*hard\s*core\s*|^\*\s*soft\s*core" /etc/security/limits.conf
if [ $? -ne 0 ]; then
  sed -i '/# End of file/i \*               soft    core           102400' /etc/security/limits.conf
  sed -i '/# End of file/i \*               hard    core           102400' /etc/security/limits.conf
  sed -i '/# End of file/i \*               soft    nofile           5000' /etc/security/limits.conf
  sed -i '/# End of file/i \*               hard    nofile           5000' /etc/security/limits.conf
  sed -i '/# End of file/i \*               soft    nproc            5000' /etc/security/limits.conf
  sed -i '/# End of file/i \*               hard    nproc            5000' /etc/security/limits.conf
fi


## 8.时间服务器
case ${version} in
  7) 
    if [ -f /etc/ntp.conf ]; then
      if [ -f /etc/chrony.conf ]; then
        systemctl enable chronyd
        yum remove ntp ntpdate -y && ntp_type='chrony'
      else
        ntp_type='ntp'; 
      fi
    elif [ -f /etc/chrony.conf ]; then 
      ntp_type='chrony'; 
    else
      echo 'Cannot Find NTP/Chronyd Service! ' && exit 1
    fi;;
  6) ntp_type='ntp' ;;
esac

if [ -z "${ntp_type}" ]; then
  echo 'Cannot find NTP/Chronyd Services'
else
  grep -q "^server" /etc/${ntp_type}.conf \
    && sed -i -e 's/^server.*/#&/g' -e '$a \server 10.125.0.101' /etc/${ntp_type}.conf

  if [ -f /etc/chrony.conf ]; then
    sed -i 's/\(^server 10.125.0.101\).*/\1 iburst/g' /etc/chrony.conf
  fi

  service ${ntp_type}d restart
  # 兼容RHEL7，也可替换成
  # systemctl restart ${ntp_type}d
fi



## 9.设置umask
UMASK=`umask`
if [ ${UMASK} -eq 0022 ]; then
  grep -q "^umask" /etc/profile \
    && sed -i 's/^umask\s*[0-9]*/umask 027/' /etc/profile \
    || sed -i '$a \umask 027' /etc/profile
fi


## 10.历史命令
### 格式
grep -q "^HISTTIMEFORMAT" /etc/profile \
  &&  sed -i 's@\(^HISTTIMEFORMAT\).*@\1="`whoami` [%F %T] "@g' /etc/profile \
  || sed -i '$a \HISTTIMEFORMAT="`whoami` [%F %T] "' /etc/profile

### 记录历史数
sed -i 's@\(^HISTSIZE\).*@\1=10000@g' /etc/profile

## 11.设置计划任务（蓝鲸）
sed -i  '/xuoasefasd.err/d'  /var/spool/cron/root
echo '59 11 * * 5 /bin/echo > /tmp/xuoasefasd.err' >> /var/spool/cron/root

## 12.设置auditd.service
cat >> /etc/audit/audit.rules <<EOF
-w /etc/pam.d/system-auth -p rwa -k system_auth_changes
-w /etc/pam.d/password-auth -p rwa -k password_auth_changes
-w /etc/passwd -p rwa -k passwd_changes
-w /etc/shadow -p rwa -k shadow_changes	
-w /etc/group -p rwa -k group_changes
-w /etc/sudoers -p rwa -k sudoers_changes
-w /etc/rsyslog.conf -p rwa -k rsyslog_changes
-w /etc/audit/audit.rules -p rwa -k audit_changes
EOF


## RHEL7需要将规则写入/etc/audit/rules.d/audit.rules
if [ ${version} -eq 7 ];then 
  cat >> /etc/audit/rules.d/audit.rules <<EOF
-w /etc/pam.d/system-auth -p rwa -k system_auth_changes
-w /etc/pam.d/password-auth -p rwa -k password_auth_changes
-w /etc/passwd -p rwa -k passwd_changes
-w /etc/shadow -p rwa -k shadow_changes
-w /etc/group -p rwa -k group_changes
-w /etc/sudoers -p rwa -k sudoers_changes
-w /etc/rsyslog.conf -p rwa -k rsyslog_changes
-w /etc/audit/audit.rules -p rwa -k audit_changes
-w /etc/audit/rules.d/audit.rules -p rwa -k audit_changes
EOF
# -w /var/log/secure -p rwa -k secure_changes
# -w /var/log/maillog -p rwa -k maillog_changes
# -w /var/log/cron -p rwa -k cron_changes
# -w /var/log/spooler -p rwa -k spooler_changes
fi
auditctl -R /etc/audit/audit.rules > /dev/null

source /etc/profile > /dev/null
rm -rf $0

# Script Body -- END #