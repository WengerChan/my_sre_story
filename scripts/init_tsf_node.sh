#========================
cp -a /etc/sysconfig/network-scripts/ifcfg-eth0 /tmp/ifcfg-eth0.bak20201127
IP=$(ip addr | grep -o '10.137.12.[0-9]*' | grep -v 255)
cat << EOF >> /etc/sysconfig/network-scripts/ifcfg-eth0
IPADDR="${IP}"
GATEWAY="10.137.12.254"
PREFIX="24"
PEERDNS=no
DNS1="10.137.6.201"
DNS2="10.137.6.202"
DNS3="10.137.6.203"
EOF
sed -i 's/dhcp/none/' /etc/sysconfig/network-scripts/ifcfg-eth0
#========================

cat << EOF > /etc/resolv.conf
nameserver 10.137.6.201
nameserver 10.137.6.202
nameserver 10.137.6.203
EOF
#========================

#========================
sed -i 's/^server.*/#&/g' /etc/chrony.conf
sed -i '$a \server 10.137.6.201 iburst' /etc/chrony.conf
#sed -i 's/10.125.0.101/10.137.6.201/' /etc/chrony.conf
systemctl restart chronyd
#========================

#========================
#sed -i 's/5000/65535/'  /etc/security/limits.conf
sed -i '/# End of file/i \*               soft    nofile          65535' /etc/security/limits.conf
sed -i '/# End of file/i \*               hard    nofile          65535' /etc/security/limits.conf
sed -i '/# End of file/i \*               soft    nproc           65535' /etc/security/limits.conf
sed -i '/# End of file/i \*               hard    nproc           65535' /etc/security/limits.conf

echo 'session required pam_limits.so' > /etc/pam.d/common-session
sed -i 's/4096/65535/' /etc/security/limits.d/20-nproc.conf
#========================

rm /etc/yum.repos.d/* -rf
cat << EOF > /etc/yum.repos.d/YUM.repo
[YUM]
name=YUM
baseurl=http://10.150.45.108/standard/rhel/7.6/x86_64/
enabled=1
gpgcheck=0
EOF
yum clean all;yum repolist
yum install -y nc wget ceph-common nettools libseccomp
#========================

#========================
modprobe br_netfilter
#========================

#========================
setenforce Permissive
sed -i 's@\(SELINUX\).*@\1=disabled@g' /etc/selinux/config
#========================

#========================
systemctl stop firewalld
systemctl disable firewalld
#========================




##
# systemctl status firewalld
# getenforce
# rpm -q nc wget ceph-common nettools libseccomp
# cat /etc/security/limits.d/20-nproc.conf
# tail -n 10 /etc/security/limits.conf
# cat /etc/pam.d/common-session
# chronyc sources -v
# cat /etc/sysconfig/network-scripts/ifcfg-eth0
# cat /etc/resolv.conf