#! /usr/bin/env bash

#=============================================
# Script Name: discover_web_middleware.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: bash discover_web_middleware.sh
# Description: 检查web中间件/web服务器状态
#=============================================

# Define variables -- BEGIN #
wed_middleware_is_exist=0
web_middleware_version=''
# Define variables -- END #

# Script Body -- BEGIN #
## 1.nginx

## nginx_is_exist:是否存在(existed|no_existed)
locate --regex '^.*\/sbin\/nginx$' &> /tmp/nginx_path && nginx_is_exist='existed' || nginx_is_exist='no_existed'
#nginx_version:nginx版本信息
if [ "${nginx_is_exist}" == 'existed' ]; then
    wed_middleware_is_exist=1
    nginx_version='nginx'-$(for i in `cat /tmp/nginx_path|grep -v -E -i 'old|back|bak|backup|test'`;do ${i} -v 2>&1 |sed 's@^.*nginx\/\(.*[0-9]$\)@\1@g'; done | sort |tr '\n' ',' | sed 's/,$//g')
fi


## 2.tomcat

## tomcat_is_exist:是否存在(existed|no_existed)
tomcat_is_exist='no_existed'
### rpm版
rpm -qa | grep tomcat &> /dev/null
if [ $? -eq 0 ]; then
    tomcat_is_exist='existed'
    tomcat_version_1=$(tomcat version | grep -i 'Apache' | awk -F'/' '{print $NF}')
fi
### 源码版
locate --regex '^.*\/bin\/catalina.sh' &> /tmp/catalina_path && tomcat_is_exist='existed'
if [ $? -eq 0 ]; then
    tomcat_version_2=$(for i in `cat /tmp/catalina_path | grep -v -E -i 'old|back|bak|backup|test'`; do ${i} version | grep -i '^Server.*version' | awk -F'/' '{print $NF}' ; done | sort | tr '\n' ',' | sed 's/,$//g')
fi
### tomcat_version:tomcat版本
if [ "${tomcat_is_exist}" == 'existed' ]; then
    wed_middleware_is_exist=1
    tomcat_version='tomcat'-$(echo "${tomcat_version_1},${tomcat_version_2}" | sed 's/^\,//g' | sed 's/\,$//g')
fi


## 3.weblogic

## weblogic_is_exist:是否存在(existed|no_existed)
locate --regex '^.*\/weblogic\.jar$' &> /tmp/wls_path && weblogic_is_exist='existed' || weblogic_is_exist='no_existed'
## weblogic_version:weblogic版本
if [ "${weblogic_is_exist}" == 'existed' ]; then
    wed_middleware_is_exist=1
	weblogic_version='Weblogic'-$(for i in `cat /tmp/wls_path | grep -v -E -i 'old|back|bak|backup|test'`; do java -cp ${i} weblogic.version | grep '^WebLogic Server' | awk '{print $3}' ; done | sort  | tr '\n' ',' | sed 's/,$//g')
fi


## 4.apache

## apache_is_exist:是否存在(existed|no_existed)
apache_is_exist='no_existed'
### rpm版
rpm -qa | grep httpd &> /dev/null
if [ $? -eq 0 ]; then
    apache_is_exist='existed'
    apache_version_1=$(httpd -v | grep -i '^Server.*version' | cut -d'/' -f2 | cut -d' ' -f1)
fi
### 源码版
locate --regex '^.*/bin/apachectl$' &> /tmp/httpd_path && apache_is_exist='existed'
if [ $? -eq 0 ]; then
    apache_version_2=$(for i in `cat /tmp/httpd_path | grep -v -E -i 'old|back|bak|backup|test'`; do ${i} -v | grep -i '^Server.*version' | cut -d'/' -f2 | cut -d' ' -f1 ; done | sort | tr '\n' ',' | sed 's/,$//g')
fi
### apache_version:apache版本
if [ "${apache_is_exist}" == 'existed' ]; then
    wed_middleware_is_exist=1
    apache_version='apache'-$(echo "${apache_version_1},${apache_version_2}" | sed 's/^\,//g' | sed 's/\,$//g')
fi

## 5.中创中间件

## zc_is_exist:是否存在(existed|no_existed)
locate --regex '^.*\/AppServer\/as\/bin\/asadmin$' &> /tmp/zc_path && zc_is_exist='existed' || zc_is_exist='no_existed'
## zc_version:中创中间件版本
if [ "${zc_is_exist}" == 'existed' ]; then
    wed_middleware_is_exist=1
	zc_version='InforSuite'-$(for i in `cat /tmp/zc_path | grep -v -E -i 'old|back|bak|backup|test'`; do sh ${i} version | grep -i '^Version' | sed 's/^.*Server\s\(.*\)\s(build\s\(B[0-9]\{6\}\).*/\1\_\2/g' ; done | sort | tr '\n' ',' | sed 's/,$//g')
fi


## 输出结果
if [ "${wed_middleware_is_exist=1}" -eq 1 ]; then
    web_middleware_version=$(echo "${nginx_version}"'/'"${tomcat_version}"'/'"${weblogic_version}"'/'"${apache_version}"'/'"${zc_version}" | sed 's@^\/*@@g' | sed 's@\/*$@@g' | sed 's@/\{2,\}@/@g')
fi
echo {'"'wed_middleware_is_exist'"': '"'$wed_middleware_is_exist'"', '"'web_middleware_version'"': '"'$web_middleware_version'"'}

# Script Body -- END #