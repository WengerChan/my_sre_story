# 

## kvm管理命令

### 查看虚拟机列表

```sh
virsh list         # 显示正在运行的虚拟机
virsh list --all   # 显示所有虚拟机
```

### 启动虚拟机

```sh
virsh start VM-NAME                  # 启动
virsh autostart VM-NAME              # 开机自启
virsh autostart --disable VM-NAME    # 取消开机自启
```

### 关闭虚拟机

```sh
virsh shutdown VM-NAME     # 正常关机
virsh destroy VM-NAME      # 强制关机
```

### 挂起虚拟机(suspend)

```sh
virsh suspend VM-NAME      # 挂起
virsh resume VM-NAME       # 恢复挂起
```

### 删除虚拟机

```sh
virsh undefined VM-NAME

[--managed-save]         # 当虚拟机处于saved状态时，删除时需要指定这个选项
[--snapshots-metadata]
[ {--storage volumes | --remove-all-storage [--delete-snapshots]} --wipe-storage]
```

### 保存虚拟机(save)

```sh
virsh managedsave VM-NAME

# [--domain] <string>  domain name, id or uuid
# --bypass-cache   avoid file system cache when saving
# --running        set domain to be running on next start
# --paused         set domain to be paused on next start
# --verbose        display the progress of save

virsh start VM-NAME
```

### 克隆虚拟机

```sh
virsh shutdown VM-NAME-01                                         # 确保VM-NAME-01为关机状态
virt-clone -o VM-NAME-01 -n VM-NAME-02 -f /data/VM-NAME-02.qcow2  # VM-NAME-01克隆为VM-NAME-02
```

### 虚拟磁盘

```sh
qemu-img create -f qcow2 /home/virtimg/rhel6.img 10G # 创建
qemu-img resize /home/virtimg/rhel6.img +1G          # 增大容量
qemu-img info /home/virtimg/rhel6.img                # 查看信息
```

### 虚拟内存

```sh
virsh setmaxmem VM-NAME 4096M --config   # 最大可分配内存, 重启后生效
virsh setmem VM-NAME 2048M               # 当前分配内存, 值应该小于最大可分配内存的值
```

### 虚拟机信息

- 查看虚拟机基本信息

```sh
$ virsh dominfo rhel79

Id:             32
Name:           rhel79
UUID:           4ecca1a6-cfe2-4975-9ffe-cb80c2356d55
OS Type:        hvm
State:          running
CPU(s):         1
CPU time:       53.2s
Max memory:     1048576 KiB
Used memory:    1048576 KiB
Persistent:     yes
Autostart:      disable
Managed save:   no
Security model: none
Security DOI:   0
```

- 查看虚拟机详细信息

```sh
$ virsh domstats rhel79-clone rhel79

# --state            report domain state
# --cpu-total        report domain physical cpu usage
# --balloon          report domain balloon statistics
# --vcpu             report domain virtual cpu information
# --interface        report domain network interface information
# --block            report domain block device statistics
# --perf             report domain perf event statistics
# --list-active      list only active domains
# --list-inactive    list only inactive domains
# --list-persistent  list only persistent domains
# --list-transient   list only transient domains
# --list-running     list only running domains
# --list-paused      list only paused domains
# --list-shutoff     list only shutoff domains
# --list-other       list only domains in other states
# --raw              do not pretty-print the fields
# --enforce          enforce requested stats parameters
# --backing          add backing chain information to block stats
# --nowait           report only stats that are accessible instantly
# <domain>           list of domains to get stats for
```

- 查看虚拟机状态

```sh
$ virsh domstate rhel79-clone --reason 

running (booted)

# --reason         also print reason for the state
```

- 查看块设备

```sh
$ virsh domblklist rhel79 --details

Type       Device     Target     Source
------------------------------------------------
file       disk       vda        /data/rhel79.qcow2

# --inactive       get inactive rather than running configuration
```

- 显示块设备大小信息

```sh
$ virsh domblkinfo rhel79 vda

Capacity:       10737418240
Allocation:     1802313728
Physical:       1802371072

# --device <string>  block device
# --human            Human readable output
# --all              display all block devices info
```

- 显示块设备信息

```sh
$ virsh domblkstat rhel79   # 仅可查看开机状态的主机

 rd_req 9741
 rd_bytes 154587648
 wr_req 614
 wr_bytes 13020672
 flush_operations 320
 rd_total_times 1419425446
 wr_total_times 321114004
 flush_total_times 290348748

# --device <string>  block device
# --human            print a more human readable output
```

- 显示块设备中的错误  

```sh
virsh domblkerror VM-NAME   # 仅可查看开机状态的主机
```

- 查看/设置虚拟机时间

> 仅可查看开机状态的主机

```sh
$ virsh domtime rhel79 --pretty    # 显示虚拟机时间
$ virsh domtime --time 1614244228  # 设置时间

# --now            set to the time of the host running virsh, " acts like if it was an alias for --time $now "
# --pretty         print domain's time in human readable form
# --sync           instead of setting given time, synchronize from domain's RTC
# --time <number>  time to set
```

- 网络相关

    * 控制接口的状态 (仅开机状态)
    
    ```sh
    $ virsh domcontrol rhel79-clone

    ok
    ```

    * 查看虚拟网卡列表

    ```sh
    $ virsh domiflist rhel79

    Interface  Type       Source     Model       MAC
    -------------------------------------------------------
    -          bridge     br0        virtio      52:54:00:f0:a3:23

    # --inactive       get inactive rather than running configuration
    ```

    * 网卡状态 (仅开机状态)
    
    ```sh
    # 1. 连通性
    $ virsh domif-getlink rhel79 vnet1

    vnet1 up
    
    # --config         Get persistent interface state

    # 2. 信息
    $ virsh domifstat rhel79 vnet1
    
    vnet1 rx_bytes 82461
    vnet1 rx_packets 617
    vnet1 rx_errs 0
    vnet1 rx_drop 0
    vnet1 tx_bytes 2428
    vnet1 tx_packets 38
    vnet1 tx_errs 0
    vnet1 tx_drop 0

    # 3. 网卡IP信息
    $ virsh domifaddr rhel79 

    # --interface <string>  network interface name
    # --full                always display names and MACs of interfaces
    # --source <string>     address source: 'lease', 'agent', or 'arp'
    ```

- 内存信息 (仅开机状态)

```sh
$ virsh dommemstat rhel79

actual 1048576
swap_in 0
swap_out 0
major_fault 186
minor_fault 158840
unused 879464
available 1014784
last_update 1614304438
rss 594740

# --period <number>  period in seconds to set collection
# --config           affect next boot
# --live             affect running domain
# --current          affect current domain
# 对于带有memory balloon的QEMU/KVM，将可选的--period设置为大于0的值（以秒为单位），将使balloon dirver程序返回其他统计信息，这些统计信息将由后续的dommemstat命令显示。 
# 将--period设置为0将停止气球状驱动程序收集，但不会清除气球状驱动程序中的统计信息。 需要至少QEMU/KVM 1.5在主机上运行。
# --live，-config和--current标志仅在使用--period选项设置气球驱动程序的收集时间时有效。 
#     如果指定了--live，则仅影响正在运行的来宾收集周期。 
#     如果指定了--config，将影响持久客户机的下一次引导。 
#     如果指定了--current，则影响当前的来宾状态。
# --current不能和--live和--config一起给出。如果未指定标志，则行为将根据来宾状态而有所不同。 

# swap_in           - The amount of data read from swap space (in KiB)
# swap_out          - The amount of memory written out to swap space (in KiB)
# major_fault       - The number of page faults where disk IO was required
# minor_fault       - The number of other page faults
# unused            - The amount of memory left unused by the system (in KiB)
# available         - The amount of usable memory as seen by the domain (in KiB)
# actual            - Current balloon value (in KiB)
# rss               - Resident Set Size of the running domain's process (in KiB)
# usable            - The amount of memory which can be reclaimed by balloon without causing host swapping (in KiB)
# last-update       - Timestamp of the last update of statistics (in seconds)
# disk_caches       - The amount of memory that can be reclaimed without additional I/O, typically disk caches (in KiB)
```

### 添加/删除网卡

#### 添加网卡

```man
SYNOPSIS
  attach-interface <domain> <type> <source> [--target <string>] [--mac <string>] [--script <string>] [--model <string>] [--inbound <string>] [--outbound <string>] 
    [--persistent] [--config] [--live] [--current] [--print-xml] [--managed]

OPTIONS
  [--domain] <string>   domain name, id or uuid
  [--type] <string>     network interface type
  [--source] <string>   source of network interface
  --target <string>     target network name
  --mac <string>        MAC address
  --script <string>     script used to bridge network interface
  --model <string>      model type
  --inbound <string>    control domain's incoming traffics
  --outbound <string>   control domain's outgoing traffics
  --persistent          make live change persistent
  --config              affect next boot
  --live                affect running domain
  --current             affect current domain
  --print-xml           print XML document rather than attach the interface
  --managed             libvirt will automatically detach/attach the device from/to host
```

```sh
$ virsh attach-interface --domain rhel79 --type bridge --source br0 --model virtio --print-xml

<interface type='bridge'>
  <source bridge='br0'/>
  <model type='virtio'/>
</interface>
```

#### 删除网卡

```man
SYNOPSIS
  detach-interface <domain> <type> [--mac <string>] [--persistent] [--config] [--live] [--current]

OPTIONS
  [--domain] <string>  domain name, id or uuid
  [--type] <string>    network interface type
  --mac <string>       MAC address
  --persistent         make live change persistent
  --config             affect next boot
  --live               affect running domain
  --current            affect current domain
```

```sh
$ virsh detach-interface rhel79 --type bridge      # 有多网卡时, 需要指定mac来删除网卡
error: Domain has 2 interfaces. Please specify which one to detach using --mac
error: Failed to detach interface

$ virsh detach-interface rhel79 --type bridge --mac 52:54:00:84:14:f2
Interface detached successfully

$ virsh domiflist rhel79
Interface  Type       Source     Model       MAC
-------------------------------------------------------
vnet0      bridge     br0        virtio      52:54:00:64:fc:47
```

### 添加/删除块设备(磁盘)

#### 添加

```man
SYNOPSIS
  attach-disk <domain> <source> <target> [--targetbus <string>] [--driver <string>] [--subdriver <string>] [--iothread <string>] [--cache <string>] 
    [--io <string>] [--type <string>] [--mode <string>] [--sourcetype <string>] [--serial <string>] [--wwn <string>] [--rawio] [--address <string>] 
    [--multifunction] [--print-xml] [--persistent] [--config] [--live] [--current]

OPTIONS
  [--domain] <string>    domain name, id or uuid
  [--source] <string>    source of disk device     => /data/dev-7-rhel79.qcow2
  [--target] <string>    target of disk device     => vda, sdb等
  --targetbus <string>   target bus of disk device => 典型值为ide,scsi,virtio,xen,usb,sata或sd; 如果省略,则根据设备名称的样式推断总线类型（例如, 'sda'则认为是使用SCSI总线导出的设备） 
  --driver <string>      driver of disk device     => For Xen Hypervior: file,tap,phy; For QEMU emulator:qemu
  --subdriver <string>   subdriver of disk device  => For Xen Hypervior: aio;          For QEMU emulator:raw or qcow2
  --iothread <string>    IOThread to be used by supported device
  --cache <string>       cache mode of disk device            => "default","none","writethrough","writeback","directsync" or "unsafe".
  --io <string>          io policy of disk device             => "threads" and "native"
  --type <string>        target device type                   => 设备类型: disk(default),lun,cdrom,floppy
  --mode <string>        mode of device reading and writing   => readonly/shareable
  --sourcetype <string>  type of source (block|file)
  --serial <string>      serial of disk device                => 设备序列号
  --wwn <string>         wwn of disk device                   => 设备wwn
  --rawio                needs rawio capability
  --address <string>     address of disk device               => address is the address of disk device in the form of pci:domain.bus.slot.function, scsi:controller.bus.unit,
                                                                   ide:controller.bus.unit or ccw:cssid.ssid.devno.
  --multifunction        use multifunction pci under specified address
  --print-xml            print XML document rather than attach the disk
  --persistent           make live change persistent
  --config               affect next boot
  --live                 affect running domain
  --current              affect current domain
```

```sh
$ virsh attach-disk --domain rhel79 --source /data/tmp.qcow2  --target vdb --targetbus virtio --driver qemu --subdriver qcow2 --print-xml 
<disk type='file'>
  <driver name='qemu' type='qcow2'/>
  <source file='/data/tmp.qcow2'/>
  <target dev='vdb' bus='virtio'/>
</disk>
```

#### 删除

```man
SYNOPSIS
    detach-disk <domain> <target> [--persistent] [--config] [--live] [--current] [--print-xml]

OPTIONS
  [--domain] <string>  domain name, id or uuid
  [--target] <string>  target of disk device
  --persistent     make live change persistent
  --config         affect next boot
  --live           affect running domain
  --current        affect current domain
  --print-xml      print XML document rather than detach the disk
```

```sh
virsh detach-disk --domain rhel79-clone --target vdb --config
```

### 连接到虚拟机

```sh
$ virsh console rhel79

# --force          force console connection (disconnect already connected sessions)
# --safe           only connect if safe console handling is supported
```

默认情况下, 直接执行命令连接到虚拟机时, 会卡住, 需要特殊配置

#### RHEL/CentOS 6

- `/etc/securetty`中添加`ttyS0`

```sh
echo "ttyS0" >> /etc/securetty
```

- `/etc/grub.conf`中添加参数`console=ttyS0`

```x
...
title Red Hat Enterprise Linux (2.6.32-358.el6.x86_64)
        root (hd0,0)
        kernel /vmlinuz-2.6.32-358.el6.x86_64 ro ... rhgb quiet console=ttyS0    <== 添加 console=ttyS0
        initrd /initramfs-2.6.32-358.el6.x86_64.img
...
```

- `/etc/inittab`中添加`S0:12345:respawn:/sbin/agetty ttyS0 115200`

```sh
echo "S0:12345:respawn:/sbin/agetty ttyS0 115200"  >> /etc/inittab
```

#### RHEL/CentOS 7

- 方法一: 执行命令添加参数"`console=ttyS0`"

```sh
grubby --update-kernel=ALL --args="console=ttyS0"
```

- 方法二: 手动编辑 `/etc/default/grub` , 添加参数"`console=ttyS0`", 然后使用 `grub2-mkconfig` 命令使配置生效

```x
# /etc/default/grub
...
GRUB_CMDLINE_LINUX="spectre_v2=retpoline rd.lvm.lv=rhel/root rd.lvm.lv=rhel/swap rhgb quiet console=ttyS0"  <== 添加 console=ttyS0
...
```

```sh
grub2-mkconfig -o /boot/grub2/grub.cfg
```

### 快照

> ```x
> snapshot-create                Create a snapshot from XML  
> snapshot-create-as             Create a snapshot from a set of args  
> snapshot-current               Get or set the current snapshot        <=当前快照
> snapshot-delete                Delete a domain snapshot
> snapshot-dumpxml               Dump XML for a domain snapshot         <=导出快照xml文件
> snapshot-edit                  edit XML for a snapshot                <=编辑快照xml文件
> snapshot-info                  snapshot information                   <=查看快照信息
> snapshot-list                  List snapshots for a domain  
> snapshot-parent                Get the name of the parent of a snapshot  
> snapshot-revert                Revert a domain to a snapshot 
> ``` 

### 创建快照

> 1. `snapshot-create-as`    # 创建默认快照（一般为一串数字）
> 2. `snapshot-create`       # 创建自定义名称快照

```sh
$ virsh snapshot-create --domain rhel79
$ virsh snapshot-create-as rhel79 --name rhel79-snapshot-1
$ virsh snapshot-list rhel79

 Name                 Creation Time             State
------------------------------------------------------------
 1614330821           2021-02-26 17:13:41 +0800 shutoff
 rhel79-snapshot-1    2021-02-26 17:14:08 +0800 shutoff
```

- 内置快照

快照数据和base磁盘数据放在一个qcow2文件中。

- 外置快照

快照数据单独的qcow2文件存放。

```sh
# 1. 创建
virsh snapshot-create-as --domain rhel79 --name fresh --disk-only --diskspec vda,snapshot=external,file=/data/rhel79_1.qcow2 --atomic

# 2. 合并快照

## 2.1 blockcommit将top镜像合并至低层的base镜像     快照路径:初始=>rhel79_1=>rhel79_2=>当前
virsh blockcommit --domain rhel79 --base /data/rhel79_1.qcow2 --top /data/rhel79_2.qcow2 --wait --verbose

## 2.2 blockpull将backing-file向上合并至active     快照路径: 初始=>rhel79_3=>rhel79_4=>当前
# 合并快照3到当前使用的快照4中
virsh blockpull --domain rhel79 --path /data/rhel79_3.qcow2 --base /data/test4.qcow2 --wait --verbose
# 迁移虚拟机，合并base-image到active,合并需要一段时间
virsh blockpull --domain rhel79 --path /data/test4.qcow2 --wait --verbose
```

### 恢复快照

```sh
virsh snapshot-revert --domain rhel79 --snapshotname 1614330821
```

### 删除快照

```sh
virsh snapshot-delete rhel79 --snapshotname 1614330821
```
