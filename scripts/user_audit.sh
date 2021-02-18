#! /usr/bin/env bash

#=============================================
# Script Name: user_audit.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-18
#       Usage: /etc/profile.d/user_audit.sh
# Description: 
#=============================================

# Define variables -- BEGIN #
# Define variables -- END #

# Script Body -- BEGIN #

# mkdir -p /var/log/user_audit/
# export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S][`who am i 2>/dev/null|awk '{print $1}'`][`who am i 2>/dev/null|awk '{print $2}'`][`who am i 2>/dev/null|awk '{print $(NF-1),$NF}'`]"
export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S][`who am i 2>/dev/null|awk '{print "[" $1 "][" $2 "][" $(NF-1),$NF "]"}'`]"
export PROMPT_COMMAND='\
if [ -z "$OLD_PWD" ]; then
    export OLD_PWD=$PWD; 
fi
if [ ! -z "$LAST_CMD" ] && [ "$(history 1)" != "$LAST_CMD" ]; then
    echo `date "+%b %d %T"` `hostname` `whoami`: "[$OLD_PWD]$(history 1)" >> /var/log/user_audit/user_audit.log
fi
export LAST_CMD="$(history 1)"
export OLD_PWD=$PWD'

# Script Body -- END #