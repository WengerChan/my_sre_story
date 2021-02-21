#! /usr/bin/env bash

#=============================================
# Script Name: install_weblogic_12c.sh
#      Author: Wenger Chan
#     Version: V 1.1
#        Date: 2021-02-19
#       Usage: bash install_weblogic_12c.sh
# Description: 安装Weblogic 12c
#=============================================

# Define variables -- BEGIN #
## weblogic相关
weblogicOwner='weblogic'
weblogicOwnerPasswd='1*weblogic'

weblogicVersion='12.1.3'
weblogicPackageName='fmw_12.1.3.0.0_wls.jar'
weblogicDownloadUrl="http://10.150.45.108/Weblogic/installer/${weblogicPackageName}"
weblogicOraInst='/tmp/oraInst.loc'
weblogicWlsRsp='/tmp/wls.rsp'

MW_HOME='/data/weblogic/Oracle/Middleware/Oracle_Home'
WL_HOME="${MW_HOME}/oracle_common"

## JDK相关变量
JDKVersion='jdk1.8.0_271'
JDKPackageName='jdk-8u271-linux-x64.tar.gz'
JDKDownloadUrl="http://10.150.45.108/jdk/${JDKPackageName}"
JDKInstallPath="/usr/local/java/${JDKVersion}"
JDKOwner="${weblogicOwner}"

## weblogic域相关
consoleRootUser='weblogic'
consoleRootUserPasswd='1*weblogic'
domainPath="${MW_HOME}/user_projects/domains/base_domain"  #按需要修改
domainListenAddress='10.150.46.118'
domainListenPort='7001'
# Define variables -- END #

# Script Body -- BEGIN #

function configUser() {

    echo '----------"configUser()": Running Function----------'

    id ${weblogicOwner} || (useradd ${weblogicOwner} && echo 'Pc@3z9dj' | passwd --stdin ${weblogicOwner})

    [ $? -eq 0 ] && echo '----------"configUser()": Finished!----------' \
                 || (echo '----------"configUser()": Error, Failed!----------'; exit 1) 
    [ $? -eq 0 ] || exit 1
}


function installJDK() {

    echo '----------"installJDK()": Running Function----------'

    umask 0022
    mkdir -p ${JDKInstallPath}

    wget -q ${JDKDownloadUrl} -O /usr/local/src/${JDKPackageName} &&\
    tar xf /usr/local/src/${JDKPackageName} -C /usr/local/java/ &&\
    chown -R ${JDKOwner}:${JDKOwner} ${JDKInstallPath} &&\
    cat << EOF >> /home/${JDKOwner}/.bash_profile
export JAVA_HOME=${JDKInstallPath}
export JRE_HOME=${JDKInstallPath}/jre
export CLASS_PATH=.:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar:\$JRE_HOME/lib
export PATH=\$JAVA_HOME/bin:\$JRE_HOME/bin:\$PATH
EOF

    [ $? -eq 0 ] && echo '----------"installJDK()": Finished!----------' \
                 || (echo '----------"installJDK()": Error, Failed!----------'; exit 1) 
    [ $? -eq 0 ] || exit 1
}


function installWeblogic() {
    
    echo '----------"installWeblogic()": Running Function----------'
    
    wget -q ${weblogicDownloadUrl} -O /usr/local/src/${weblogicPackageName} &&\
    chown ${weblogicOwner}:${weblogicOwner} /usr/local/src/${weblogicPackageName} &&\
	su - ${weblogicOwner} << EOFEOF
cat << EOF > ${weblogicOraInst}
inventory_loc=/home/${weblogicOwner}/oraInventory
inst_group=${weblogicOwner}
EOF

cat << EOF > ${weblogicWlsRsp}
[ENGINE]
#DO NOT CHANGE THIS.
Response File Version=1.0.0.0.0
[GENERIC]
#The oracle home location. This can be an existing Oracle Home or a new Oracle Home
ORACLE_HOME=${MW_HOME}
#Set this variable value to the Installation Type selected. e.g. WebLogic Server, Coherence, Complete with Examples.
INSTALL_TYPE=WebLogic Server
#Provide the My Oracle Support Username. If you wish to ignore Oracle Configuration Manager configuration provide empty string for user name.
MYORACLESUPPORT_USERNAME=
#Provide the My Oracle Support Password
MYORACLESUPPORT_PASSWORD=<SECURE VALUE>
#Set this to true if you wish to decline the security updates. Setting this to true and providing empty string for My Oracle Support username will ignore the Oracle Configuration Manager configuration
DECLINE_SECURITY_UPDATES=true
#Set this to true if My Oracle Support Password is specified
SECURITY_UPDATES_VIA_MYORACLESUPPORT=false
#Provide the Proxy Host
PROXY_HOST=
#Provide the Proxy Port
PROXY_PORT=
#Provide the Proxy Username
PROXY_USER=
#Provide the Proxy Password
PROXY_PWD=<SECURE VALUE>
#Type String (URL format) Indicates the OCM Repeater URL which should be of the format [scheme[Http/Https]]://[repeater host]:[repeater port]
COLLECTOR_SUPPORTHUB_URL=
EOF

[ -d "${MW_HOME}" ] || mkdir -p ${MW_HOME}
java -jar /usr/local/src/${weblogicPackageName} -silent -responseFile ${weblogicWlsRsp}  -invPtrLoc ${weblogicOraInst}

EOFEOF

    [ $? -eq 0 ] && cat << EOF >> /home/${weblogicOwner}/.bash_profile
export MW_HOME=${MW_HOME}
export WL_HOME=${WL_HOME}
EOF

    [ $? -eq 0 ] && echo '----------"installWeblogic()": Finished!----------' \
                 || (echo '----------"installWeblogic()": Error, Failed!----------'; exit 1) 
    [ $? -eq 0 ] || exit 1
}


function createDomain() {

    echo '----------"createDomain()": Running Function----------'

    su - ${weblogicOwner} << EOFEOF
        mkdir -p ${domainPath}

        cat << EOF >> ${MW_HOME}/wlserver/common/bin/createdomain.py
readTemplate("${MW_HOME}/wlserver/common/templates/wls/wls.jar")
cd('Servers/AdminServer')
set('ListenAddress',"${domainListenAddress}")
set('ListenPort', ${domainListenPort})
cd('/Security/base_domain/User/weblogic')
cmo.setName("${consoleRootUser}")
cmo.setPassword("${consoleRootUserPasswd}")
setOption('OverwriteDomain', 'true')
setOption('ServerStartMode', 'prod')
writeDomain("${domainPath}")
closeTemplate()
exit()
EOF
        ${MW_HOME}/wlserver/common/bin/wlst.sh ${MW_HOME}/wlserver/common/bin/createdomain.py

EOFEOF

    [ $? -eq 0 ] && echo '----------"createDomain()": Finished!----------' \
                 || (echo '----------"createDomain()": Error, Failed!----------'; exit 1) 
    [ $? -eq 0 ] || exit 1
}

## Main Function
function main() {

    configUser
    installJDK
    installWeblogic
    createDomain

}


## Call Main Function
main

# Script Body -- END #