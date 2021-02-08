#! /usr/bin/env bash

#=============================================
# Script Name: add_swap_space.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: sh add_swap_space.sh <0-9>
# Description: Add swap space to host. 
#=============================================

# Define variables -- BEGIN #
DATE="$(date +'%F')"
swap_file_path="/usr/local/"
swap_file_size="$1"             # unit: G
# Define variables -- END #

# Script Main Body -- BEGIN #
if [ -z ${swap_file_size} ]; then
    echo 'ERROR! You should give the size(G) of swap file! '
    exit 1
fi

echo "${swap_file_size}" | grep -q '^[0-9]*[0-9]$'
[ $? -eq 0 ] || exit 1

# Calculate
# swap_bs_count=$(echo "${swap_file_size} * 256 * 1024" | bc)
swap_bs_count="$(expr ${swap_file_size} \* 256 \* 1024)"
swap_file_name="${swap_file_path}/${DATE}.swapfile"

dd if=/dev/zero of=${swap_file_name} bs=4096 count=${swap_bs_count}
[ $? -eq 0 ] && mkswap ${swap_file_name} && chmod 600 ${swap_file_name}
[ $? -eq 0 ] && echo "${swap_file_name}     swap    swap    defaults    0 0" >> /etc/fstab
swapon -a
# Script Main Body -- END #