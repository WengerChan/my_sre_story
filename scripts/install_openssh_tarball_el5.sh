# Script Body -- BEGIN #

#============
#安装gcc、make等
#============

yum install -y pam-devel libselinux-devel krb5-devel zlib-devel gcc make

#============
#升级perl
#============

#检查perl版本，需要5.10以上版本
perl -v


cd /usr/local/src
tar xvf perl-5.30.2.tar.gz
cd ./perl-5.30.2
./Configure -des -Dprefix=/usr/local/perl-5.30.2
make
make test
make install
/usr/local/perl-5.30.2/bin/perl -v
mv /usr/bin/perl /usr/bin/perl.bak20200321
ln -s /usr/local/perl-5.30.2/bin/perl /usr/bin/perl
perl -v

#============
#升级openssl
#============
openssl version -a

cd /usr/local/src
tar xvf openssl-1.1.1d.tar.gz
cd ./openssl-1.1.1d
./config --prefix=/usr/local/openssl-1.1.1d --openssldir=/usr/local/openssl-1.1.1d zlib shared && make -j 4 && make install

mv /usr/bin/openssl /usr/bin/openssl.old
ln -s /usr/local/openssl-1.1.1d/bin/openssl /usr/bin/openssl

echo "/usr/local/openssl-1.1.1d/lib" > /etc/ld.so.conf.d/openssl-1.1.1d.conf
ldconfig

openssl version -a 

#============
#升级openssh
#============
ssh -V
alias cp='cp'

cp -a /etc/ssh /etc/ssh.old20200321
chmod 600 /etc/ssh/ssh_host_*

cd /usr/local/src
tar xvf openssh-8.1p1.tar.gz
cd ./openssh-8.1p1

./configure --prefix=/usr/local/openssh-8.1p1\
  --sysconfdir=/etc/ssh\
  --with-ssl-dir=/usr/local/openssl-1.1.1d\
  --mandir=/usr/share/man\
  --with-zlib\
  --with-md5-passwords\
  --with-ssl-engine\
  --with-pam\
  && make && make install

for i in {scp,sftp,ssh,ssh-add,ssh-agent,ssh-keygen,ssh-keyscan};
do 
  if [ -f /usr/bin/${i} ]; then 
  mv -f /usr/bin/${i} /usr/bin/${i}-bak20200321
  fi;
done

for i in {sftp-server,ssh-keysign,ssh-pkcs11-helper};
do
  mv -f /usr/libexec/openssh/${i} /usr/libexec/openssh/${i}.bak20200321
done

mv -f /usr/sbin/sshd /usr/sbin/sshd.bak20200310

cp -a /usr/local/openssh-8.1p1/bin/* /usr/bin/
cp -a /usr/local/openssh-8.1p1/sbin/* /usr/sbin/
cp -a /usr/local/openssh-8.1p1/libexec/* /usr/libexec/openssh/
restorecon /usr/bin/{scp,sftp,ssh,ssh-add,ssh-agent,ssh-keygen,ssh-keyscan}
restorecon /usr/sbin/sshd
restorecon /usr/libexec/openssh/{sftp-server,ssh-keysign,ssh-pkcs11-helper}


# Script Body -- END #