## `ntpq -p`含义：

```x
$ ntpq -p 
     remote           refid      st t when poll reach   delay   offset  jitter
==============================================================================
+120.25.115.20   10.137.53.7      2 u   42   64   77    7.068   -2.187   2.951
*203.107.6.88    10.137.38.86     2 u    1   64  177   42.180   -1.933   3.986
```

| 标志      | 含义                                                                                                |
|-----------|-----------------------------------------------------------------------------------------------------|
| *         | 响应的NTP服务器和最精确的服务器                                                                        |
| +         | 响应这个查询请求的NTP服务器                                                                            |
| 空格      | 没有响应的NTP服务器                                                                                    |
| remote    | 响应这个请求的NTP服务器的名称                                                                          |
| refid     | NTP服务器使用的更高一级服务器的名称                                                                    |
| st        | 正在响应请求的NTP服务器的级别                                                                          |
| when      | 上一次成功请求之后到现在的秒数                                                                         |
| poll      | 本地和远程服务器多少时间进行一次同步，单位秒，在一开始运行NTP的时候这个poll值会比较小，服务器同步的频率大，可以尽快调整到正确的时间范围，之后poll值会逐渐增大，同步的频率也就会相应减小 |
| reach     | 用来测试能否和服务器连接，是一个八进制值，每成功连接一次它的值就会增加                                     |
| delay     | 从本地机发送同步要求到ntp服务器的往返时间                                                                |
| offset    | 主机通过NTP时钟同步与所同步时间源的时间偏移量，单位为毫秒，offset越接近于0，主机和ntp服务器的时间越接近      | 
| jitter    | 统计了在特定个连续的连接数里offset的分布情况。简单地说这个数值的绝对值越小，主机的时间就越精确               |


## `kvm桥接`

```
                              --vnet0  ==> kvm-host0
宿主机 ==> br0 ==> ens33 ==>  
                              --vnet1  ==> kvm-host1
```

```
# 修改ifcfg-ens33, 注释掉IP信息, 添加 BRIDGE=br0
TYPE=Ethernet
BOOTPROTO=none
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
NAME=ens33
DEVICE=ens33
ONBOOT=yes
#IPADDR=192.168.1.100   <=
#PREFIX=24              <=
BRIDGE=br0              <=
```

```
# 添加ifcfg-br0
DEVICE=br0
ONBOOT=yes
TYPE=Bridge
BOOTPROTO=none
IPADDR=192.168.1.100   <=
NETMASK=255.255.255.0  <=
DELAY=0
```

重启网络即可

```
brctl show 

bridge name     bridge id               STP enabled     interfaces
br0             8000.000c297b41d3       no              ens33        <=
virbr0          8000.525400e4a58b       yes             virbr0-nic
```


## 网络安装Linux

### 安装

```
yum install dhcp xinetd syslinux httpd tftp-server

# dhcpd          动态分配IP
# xinetd         对服务访问进行控制，这里主要是控制tftp
# tftp           从服务器端下载pxelinux.0、default文件
# syslinux       用于网络引导
# httpd          在网络上提供安装源，也就是镜像文件中的内容
```

### xinetd配置

```
vi /etc/xinetd.d/tftp

service tftp
{
        socket_type             = dgram
        protocol                = udp
        wait                    = yes
        user                    = root
        server                  = /usr/sbin/in.tftpd
        server_args             = -s /var/lib/tftpboot
        disable                 = no
        per_source              = 11
        cps                     = 100 2
        flags                   = IPv4
}
```

### DHCP配置

```
vi /etc/dhcp/dhcpd.conf

# 1. 整体的环境设定 (其中192.168.1.100是本机IP地址)
ddns-update-style none;
ignore client-updates;
default-lease-time 259200;
max-lease-time 518400;
option domain-name-servers 192.168.1.100;

# 2. 关于动态分配的 IP 
# 192.168.1.0 netmask 255.255.255.0     服务器所在的内网网段及子网掩码  
# range 192.168.1.101 192.168.1.120     可用的DHCP地址池范围
subnet 192.168.1.0 netmask 255.255.255.0 {
       range 192.168.1.101 192.168.1.120;
       option routers 192.168.1.100;
       option subnet-mask 255.255.255.0;
       next-server 192.168.1.100;
       # the configuration  file for pxe boot
       filename "pxelinux.0";
}
```

### 设置镜像文件、安装配置文件

创建挂载点

```
mkdir /rhel511
mkdir /rhel64
mkdir /rhel79
mkdir /rhel83
ln -s /rhel511 /var/www/html/rhel511
ln -s /rhel64 /var/www/html/rhel64
ln -s /rhel79 /var/www/html/rhel79
ln -s /rhel83 /var/www/html/rhel83
```

编辑fstab文件, 便于开机自动挂载

```
vi /etc/fstab    # /dev/sr0-3分别对应4个版本的镜像

/dev/sr0                /rhel511                iso9660 defaults        0 0
/dev/sr1                /rhel64                 iso9660 defaults        0 0
/dev/sr2                /rhel79                 iso9660 defaults        0 0
/dev/sr3                /rhel83                 iso9660 defaults        0 0
```

执行挂载

```
mount -a
```

安装配置文件 配置

```
mkdir /var/lib/tftpboot/{rhel511,rhel64,rhel79,rhel83}

cp /usr/share/syslinux/{pxelinux.0,menu.c32} /var/lib/tftpboot/
cp -a /rhel511/images/pxeboot/{vmlinuz,initrd.img} /var/lib/tftpboot/rhel511/
cp -a /rhel64/images/pxeboot/{vmlinuz,initrd.img} /var/lib/tftpboot/rhel64/
cp -a /rhel79/images/pxeboot/{vmlinuz,initrd.img} /var/lib/tftpboot/rhel79/
cp -a /rhel83/images/pxeboot/{vmlinuz,initrd.img} /var/lib/tftpboot/rhel83/
```

```
mkdir /var/lib/tftpboot/pxelinux.cfg
vi /var/lib/tftpboot/pxelinux.cfg/default

default menu.c32
prompt 0
timeout 300
ONTIMEOUT local

menu title ########## PXE Boot Menu ##########

label 1
menu label ^1) Install RHEL 5.11 x84_64 with HTTP
kernel rhel511/vmlinuz
append initrd=rhel511/initrd.img method=http://192.168.1.100/rhel511 devfs=nomount

label 2
menu label ^2) Install RHEL 6.4 x84_64 with HTTP
kernel rhel64/vmlinuz
append initrd=rhel64/initrd.img method=http://192.168.1.100/rhel64 devfs=nomount

label 3
menu label ^3) Install RHEL 7.9 x84_64 with HTTP
kernel rhel79/vmlinuz
append initrd=rhel79/initrd.img method=http://192.168.1.100/rhel79 devfs=nomount

label 4
menu label ^4) Install RHEL 8.3 x84_64 with HTTP
kernel rhel83/vmlinuz
append initrd=rhel83/initrd.img method=http://192.168.1.100/rhel83 devfs=nomount
```

### 启动服务

```
systemctl enable dhcpd
systemctl enable xinetd
systemctl enable tftp
systemctl enable httpd

systemctl restart dhcpd
systemctl restart xinetd
systemctl restart tftp
systemctl restart httpd
```

### 注

```
报错：/sbin/dmsquash-live-root: line 273: printf: write error: No space left on device
解决：安装时将内存选择为2G以上
```