#! /usr/bin/env bash

#=============================================
# Script Name: uninstall_safedog.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-18
#       Usage: bash uninstall_safedog.sh
# Description: 
#=============================================

# Define variables -- BEGIN #
# Define variables -- END #

# Script Body -- BEGIN #

rm_file_of_safedog() {
    chattr -i /etc/safedog/.sdinfo /etc/safedog/.ins.conf
    rm /etc/safedog -rf
}

/usr/bin/expect <<EOF
spawn /etc/safedog/script/uninstall.py
expect "uninstall"
send "y\n"
expect "isolation"
send "n\n"
expect "logs"
send "n\n"
expect eof
EOF

if [ $? -eq 0 ];then rm_file_of_safedog && echo "Done !!!";fi

# Script Body -- END #