#! /usr/bin/env bash

#=============================================
# Script Name: install_openssh_tarball.sh
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-09
#       Usage: bash install_openssh_tarball.sh
# Description: 
#=============================================

# Define variables -- BEGIN #
# Define variables -- END #

# Script Body -- BEGIN #

## Define Functions

function statusJudgement(){
    #命令执行状态判断

    if [ ! $? -eq 0 ]; then
        echo '------------------------------------------------Exited------------------------------------------------'
        exit 1
    else
        echo '------------------------------------------------Go on------------------------------------------------'
    fi

}


function installDependency(){

    installList=''

    for i in "pam-devel" "libselinux-devel" "krb5-devel" "zlib-devel" "gcc" "make";
    do
        rpm -qa | grep ${i} > /dev/null || installList="${installList} ${i}"
    done

    if [ -n "${installList}" ]; then

        #获取repo配置文件，并刷新yum

        case ${SYSTEM_VERSION} in
            7)
                wget -q -O /etc/yum.repos.d/yum-server-7.repo ${YUM_URL}/REPO/yum-server-7.repo &> /dev/null ;;
            6)
                wget -q -O /etc/yum.repos.d/yum-server-6.repo ${YUM_URL}/REPO/yum-server-6.repo &> /dev/null ;;
            *)
                echo "Unsupported System Version: ${SYSTEM_VERSION}"
                exit 1 ;;
        esac

        if [ $? -eq 0 ];then
            yum clean all &> /dev/null
            yum repolist &> /dev/null
        else
            echo "Cannot reach \"${YUM_URL}\""
            exit 1
        fi
    
        yum --disablerepo="*" --enablerepo="rhel-${SYSTEM_VERSION}-server-rpms" -y install ${installList}
    fi

    statusJudgement

}


function getPackages(){
    # 获取源码包

    wget -q -O /usr/local/src/${OPENSSH_VERSION}.tar.gz ${YUM_URL}/openssh/${OPENSSH_VERSION}.tar.gz &> /dev/null && \
    wget -q -O /usr/local/src/${OPENSSL_VERSION}.tar.gz ${YUM_URL}/openssh/${OPENSSL_VERSION}.tar.gz &> /dev/null

    statusJudgement

}


function installOpenSSL(){

    # 升级openssl

    [ -d "/usr/local/${OPENSSL_VERSION}" ] && mv -f /usr/local/${OPENSSL_VERSION}{,.${BAK_NAME}}

    if [ -f "/usr/local/src/${OPENSSL_VERSION}.tar.gz" ]; then

        cd /usr/local/src/

        #解压
        tar xzf ${OPENSSL_VERSION}.tar.gz
        cd ./${OPENSSL_VERSION}

        #安装
        LANG=C
        umask 022
        ./config --prefix=/usr/local/${OPENSSL_VERSION} --openssldir=/usr/local/${OPENSSL_VERSION} zlib shared > /dev/null\
        && make -j 4 > /dev/null && make install > /dev/null

        statusJudgement

        #备份&创建链接
        [ -f "/usr/bin/openssl" ] && mv -f /usr/bin/openssl /usr/bin/openssl.${BAK_NAME}
        ln -s /usr/local/${OPENSSL_VERSION}/bin/openssl /usr/bin/openssl

        #加载openssl库
        mv -f /etc/ld.so.conf.d/openssl*.conf /tmp/
        echo "/usr/local/${OPENSSL_VERSION}/lib" > /etc/ld.so.conf.d/${OPENSSL_VERSION}.conf
        ldconfig

        #测试
        openssl version -a
    
        if [[ `openssl version | cut -d' ' -f1-2 | tr 'A-Z ' 'a-z-'` == "${OPENSSL_VERSION}" ]]; then
        	echo 'Go on to install openssh'
        else
            echo 'Error about installing OpenSSL'
            exit 1
        fi

    else
        echo "Cannot find source-package: ${OPENSSL_VERSION}.tar.gz"
        exit 1
    fi
}


function installOpenSSH(){

    # 升级openssh

    [ -d "/usr/local/${OPENSSH_VERSION}" ] && mv -f /usr/local/${OPENSSH_VERSION}{,.${BAK_NAME}}

    if [ -f "/usr/local/src/${OPENSSH_VERSION}.tar.gz" ]; then

        cd /usr/local/src/

        #解压
        tar xzf ${OPENSSH_VERSION}.tar.gz
        cd ./${OPENSSH_VERSION}

        #备份配置文件
        cp -a /etc/ssh /etc/ssh.${BAK_NAME}

        #安装
        #chmod 600 /etc/ssh/ssh_host_{rsa,ecdsa,ed25519}_key
        chmod 600 /etc/ssh/ssh_host_*

        ./configure --prefix=/usr/local/${OPENSSH_VERSION}\
        --sysconfdir=/etc/ssh\
        --with-ssl-dir=/usr/local/${OPENSSL_VERSION}\
        --mandir=/usr/share/man\
        --with-zlib\
        --with-md5-passwords\
        --with-ssl-engine\
        --with-pam > /dev/null\
        && make -j 4 > /dev/null && make install > /dev/null

        statusJudgement

        #备份原服务文件
        for i in {scp,sftp,ssh,ssh-add,ssh-agent,ssh-keygen,ssh-keyscan};
        do 
            if [ -f "/usr/bin/${i}" ]; then 
                mv -f /usr/bin/${i} /usr/bin/${i}.${BAK_NAME}
            fi;
        done
        
        for i in {sftp-server,ssh-keysign,ssh-pkcs11-helper};
        do
            if [ -f "/usr/libexec/openssh/${i}" ]; then
                mv -f /usr/libexec/openssh/${i} /usr/libexec/openssh/${i}.${BAK_NAME}
            fi
        done
        
        [ -f "/usr/sbin/sshd" ] && mv -f /usr/sbin/sshd /usr/sbin/sshd.${BAK_NAME}

        #改用新安装的服务文件
		mkdir -p /usr/libexec/openssh
        cp -af /usr/local/${OPENSSH_VERSION}/bin/* /usr/bin/
        cp -af /usr/local/${OPENSSH_VERSION}/sbin/* /usr/sbin/
        cp -af /usr/local/${OPENSSH_VERSION}/libexec/* /usr/libexec/openssh/
        restorecon /usr/bin/{scp,sftp,ssh,ssh-add,ssh-agent,ssh-keygen,ssh-keyscan}
        restorecon /usr/sbin/sshd
        restorecon /usr/libexec/openssh/{sftp-server,ssh-keysign,ssh-pkcs11-helper}
  

    else
        echo "Cannot find source-package: ${OPENSSH_VERSION}.tar.gz"
        exit 1
    fi

}


function configureOpenSSH(){

    rm -f /etc/profile.d/openssh*.sh
    
    #注释掉/etc/ssh/ssh_config中不支持的配置项
    sed -i 's/^\s*GSSAPIAuthentication.*/#&/g' /etc/ssh/ssh_config
    
    #注释掉/etc/ssh/sshd_config中不支持的配置项
    sed -i 's/^GSSAPIAuthentication.*/#&/g' /etc/ssh/sshd_config
    sed -i 's/^GSSAPICleanupCredentials.*/#&/g' /etc/ssh/sshd_config

    # 加入算法: （根据版本确定）
    # KexAlgorithms curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group1-sha1,diffie-hellman-group14-sha1,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group-exchange-sha1,diffie-hellman-group-exchange-sha256,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,sntrup4591761x25519-sha512@tinyssh.org
    # 允许root用户ssh远程：
    # PermitRootLogin yes

    #RHEL7需要修改/usr/lib/systemd/system/sshd.service
    if [[ ${SYSTEM_VERSION} -eq 7 ]];then

        cp -f /usr/lib/systemd/system/sshd.service{,.${BAK_NAME}}
        cp -f /usr/local/src/${OPENSSH_VERSION}/contrib/redhat/sshd.init /etc/init.d/sshd
        chmod +x /etc/init.d/sshd
        cat << EOF | tee /usr/lib/systemd/system/sshd.service
[Unit]
Description=OpenSSH server daemon
Documentation=man:sshd(8) man:sshd_config(5)
After=network.target sshd-keygen.service
Wants=sshd-keygen.service

[Service]
Type=forking
PIDFile=/var/run/sshd.pid
EnvironmentFile=/etc/sysconfig/sshd
ExecStart=/etc/init.d/sshd start
ExecStop=/etc/init.d/sshd stop
ExecReload=/bin/kill -HUP $MAINPID
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
EOF
        systemctl daemon-reload 
        systemctl restart sshd
    else
        service sshd restart 
    fi

    /usr/bin/ssh -V  
}


## Main Function
function main(){

    SYSTEM_VERSION=`cat /etc/redhat-release|grep -aPo '(?<=release\s)\d'`
    alias cp='cp'


    OPENSSH_VERSION="openssh-8.4p1"
    OPENSSL_VERSION="openssl-1.1.1i"
    BAK_NAME="bak$(date +%Y%m%d)"
    YUM_URL="http://10.150.45.108"

    installDependency
    getPackages
    installOpenSSL
    installOpenSSH
    configureOpenSSH

}

## Call Main Function
main

# Script Body -- END #