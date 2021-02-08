#! /usr/bin/env bash

#=============================================
# Script Name: disk_expansion_v1.3.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: bash disk_expansion_v1.3.sh
# Description: automatic expansion lvm partition
#=============================================

# Define variables -- BEGIN #
# Define variables -- END #

# Script Body -- BEGIN #

## Define Functions
function get_DiskName(){

    # if [ -z "$1" ]; then
    #     echo "'diskScsiInfo' NOT define !"
    #     exit 1
    # fi

    # diskName
    # diskName=$(ls -l /dev/disk/by-path | grep "$1" | awk -F'/' '{print "/dev/"$NF}')
    diskName=$(ls -lvrt /dev/disk/by-path | tail -n 1 | awk -F'/' '{print "/dev/"$NF}')
}


function get_LvmInfo(){

    if [ -z "$1" ]; then
        echo "ERROR! The variable 'directoryName' is undefined !"
        exit 1
    fi

    if [ -d "$1" ]; then
        echo "Directory '$1' exists. Continues..."
    else
        echo "ERROR! CANNOT find the directory '$1' !"
        exit 1
    fi

    df -hT | grep "$1$" &> /dev/null

    if [ $? -eq 0 ]; then

        # filesystemType
        filesystemType=$(df -hT | grep "$1" | awk -F' ' '{print $2}')

        # lvName, vgName
        lv_PATH=$(lsblk -l | grep "$1" | awk -F' ' '{print $1}' | head -n 1)
        read lvName vgName < <(lvdisplay -c "/dev/mapper/$lv_PATH" | sed 's/^ *//g'| awk -F':' '{print $1,$2}')

    else

        echo "ERROR! CANNOT find \'$1\' in 'df -hT'!"
        exit 1

    fi

}


function lvm_Expand(){

    # Usage: lvm_Expand "$diskName" "$vgName" "$lvName" "$filesystemType"
    
    # 判断PV是否已经创建
    pvs | grep "$1" &> /dev/null
    if [ $? -eq 0 ]; then
        echo "ERROR! Physical volume '$1' is existed !"
        exit 1
    fi

    # extend logical volume(LV)
    pvcreate "$1" && vgextend "$2" "$1" && lvextend -l +100%FREE "$3"

    # expand filesystem
    case $4 in

        'ext4'|'ext3'|'ext2')
            resize2fs "$3"
            ;;
        'xfs')
            xfs_growfs "$3"
            ;;
        *)
            echo "UNKONWN filesystem"
            return 1
            ;;

    esac

    if [ $? -eq 0 ]; then
        echo "Success !"
    else
        echo "Expand filesystem failed ! "
        exit 1
    fi
}


## Main Function
function main(){

    # 1. 获取新增磁盘信息
    # diskScsiInfo=''
    # diskScsiInfo='pci-0000:00:10.0-scsi-0:0:3:0'
    
    # diskName
    # get_DiskName "$diskScsiInfo"

    get_DiskName

    # 2. 确认待扩容目录对应逻辑卷信息
    # 待扩容目录
    directoryName="$1"
    # directoryName='/data_xfs'

    # 逻辑卷信息: vgName, lvName, filesystemType
    get_LvmInfo "$directoryName"


    # 3. lvm在线扩容
    # 变量取值示例：
    #    diskName='/dev/sdc'
    #    vgName='vg_data'
    #    lvName='/dev/mapper/vg_data-lv_data'
    #        or lvName='/dev/vg_data/lv_data'
    #    filesystemType='xfs'
    
    if [ -z "$diskName" -o -z "$vgName" -o -z "$lvName" -o -z "$filesystemType" ]; then
        echo "At least one variable is NULL !"
        exit 1
    else
        lvm_Expand "$diskName" "$vgName" "$lvName" "$filesystemType"
    fi

}


## Call Main Function
main "$1"
#

# Script Body -- END #