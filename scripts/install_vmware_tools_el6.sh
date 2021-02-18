#! /usr/bin/env bash

#=============================================
# Script Name: install_vmware_tools_el6.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-18
#       Usage: bash install_vmware_tools_el6.sh
# Description: Install VMware Tools on Host(Only suitable for RHEL 6, with kernel '2.6.32-754.15.3.el6.x86_64')
#=============================================

# Define variables -- BEGIN #
# Define variables -- END #

# Script Body -- BEGIN #

## Define Functions
function installVMwareTools(){
    
	# 安装
	mkdir -p /tmp/vmware-install-dir
	cd /tmp/vmware-install-dir
	
    wget http://10.150.45.108/VMware-Tools/VMwareTools-10.0.9-3917699.tar.gz &> /dev/null && tar xf VMwareTools-10.0.9-3917699.tar.gz
    cd ./vmware-tools-distrib/
    
    ./vmware-install.pl << EOF





















EOF


	# 清理安装包
    if [ $? -eq 0 ];then
        cd /tmp
        rm /tmp/vmware-install-dir -rf 
    fi
}


## Main Function
function main(){

    kernelVersion=$(uname -r)

    if [ "$kernelVersion" == "2.6.32-754.15.3.el6.x86_64" ]; then
        installVMwareTools
    else
        echo "'$kernelVersion' unsupported"
        exit 1
    fi
}


## Call Main Function
main

# Script Body -- END #