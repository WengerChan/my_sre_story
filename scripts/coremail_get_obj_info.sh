#! /usr/bin/env bash

#=============================================
# Script Name: coremail_get_obj_info.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: bash coremail_get_obj_info.sh
# Description: 
#=============================================

# Define variables -- BEGIN #
Result="result.txt"
Port=`grep cm_md_db /home/coremail/conf/datasources.cf -A 10 | awk -F'"' '/Port/ {print $2}' | head -1`
Host=`grep cm_md_db /home/coremail/conf/datasources.cf -A 10 | awk -F'"' '/Server/ {print $2}' | head -1`
User=`grep cm_md_db /home/coremail/conf/datasources.cf -A 10 | awk -F'"' '/User/ {print $2}' | head -1`
Password=`grep cm_md_db /home/coremail/conf/datasources.cf -A 10 | awk -F'"' '/Password/ {print $2}' | head -1`
Uddb=`grep cm_ud_db /home/coremail/conf/datasources.cf -A 10 | awk -F'"' '/Database/ {print $2}' | head -1`
# Define variables -- END #

# Script Body -- BEGIN #

if [ -x /home/coremail/mysql/bin/mysql ]; then
	Mysqlshell=/home/coremail/mysql/bin/mysql
else
	Mysqlshell=`which mysql`
fi

RunSql="${Mysqlshell} -u${User} -p${Password} -h${Host} -P${Port} --default-character-set=gbk ${Uddb}"

$RunSql -e"select td_obj.org_id,td_obj.obj_email,cm_obj_info.true_name,td_obj.org_unit_id from cmxt.td_obj left join cmxt.cm_obj_info using(obj_uid);" |awk -F '|' '{print $1,$2,$3,$4}' |sed "s/\t/,/g"|sed "s/NULL//g" > $Result
unix2dos $Result > /dev/null 2>&1
echo "The result in $Result"

#cat $Result
#ObjEmail=`cat $Result|awk -F ',' '{print $2}'`
#TrueName=`cat $Result|awk -F ',' '{print $3}'`
#OrgUnitId=`cat $Result|awk -F ',' '{print $4}'`

#echo "/home/coremail/bin/sautil call-api \"cmd=CREATE_OBJ\" --attrs=\"org_id=a&obj_email=${ObjEmail}&obj_class=1&true_name=${TrueName}&org_unit_id=${OrgUnitId}\""|tee -a

cat $Result |awk -F ',' '{print "/home/coremail/bin/sautil call-api \"cmd=CREATE_OBJ\" --attrs=\"org_id=a&obj_email="$2"&obj_class=1&true_name="$3"&org_unit_id="$4"\""}'|tee -a

# Script Body -- END #