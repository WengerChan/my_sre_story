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



 Domain Management (help keyword 'domain')
    attach-device                  attach device from an XML file
    attach-disk                    attach disk device
    attach-interface               attach network interface
    autostart                      autostart a domain
    blkdeviotune                   Set or query a block device I/O tuning parameters.
    blkiotune                      Get or set blkio parameters
    blockcommit                    Start a block commit operation.
    blockcopy                      Start a block copy operation.
    blockjob                       Manage active block operations
    blockpull                      Populate a disk from its backing image.
    blockresize                    Resize block device of domain.
    change-media                   Change media of CD or floppy drive
    console                        connect to the guest console
    cpu-stats                      show domain cpu statistics
    create                         create a domain from an XML file
    define                         define (but don't start) a domain from an XML file
    desc                           show or set domain's description or title
    destroy                        destroy (stop) a domain
    detach-device                  detach device from an XML file
    detach-device-alias            detach device from an alias
    detach-disk                    detach disk device
    detach-interface               detach network interface
    domdisplay                     domain display connection URI
    domfsfreeze                    Freeze domain's mounted filesystems.
    domfsthaw                      Thaw domain's mounted filesystems.
    domfsinfo                      Get information of domain's mounted filesystems.
    domfstrim                      Invoke fstrim on domain's mounted filesystems.
    domhostname                    print the domain's hostname
    domid                          convert a domain name or UUID to domain id
    domif-setlink                  set link state of a virtual interface
    domiftune                      get/set parameters of a virtual interface
    domjobabort                    abort active domain job
    domjobinfo                     domain job information
    domname                        convert a domain id or UUID to domain name
    domrename                      rename a domain
    dompmsuspend                   suspend a domain gracefully using power management functions
    dompmwakeup                    wakeup a domain from pmsuspended state
    domuuid                        convert a domain name or id to domain UUID
    domxml-from-native             Convert native config to domain XML
    domxml-to-native               Convert domain XML to native config
    dump                           dump the core of a domain to a file for analysis
    dumpxml                        domain information in XML
    edit                           edit XML configuration for a domain
    event                          Domain Events
    inject-nmi                     Inject NMI to the guest
    iothreadinfo                   view domain IOThreads
    iothreadpin                    control domain IOThread affinity
    iothreadadd                    add an IOThread to the guest domain
    iothreaddel                    delete an IOThread from the guest domain
    send-key                       Send keycodes to the guest
    send-process-signal            Send signals to processes
    lxc-enter-namespace            LXC Guest Enter Namespace
    managedsave                    managed save of a domain state
    managedsave-remove             Remove managed save of a domain
    managedsave-edit               edit XML for a domain's managed save state file
    managedsave-dumpxml            Domain information of managed save state file in XML
    managedsave-define             redefine the XML for a domain's managed save state file
    memtune                        Get or set memory parameters
    perf                           Get or set perf event
    metadata                       show or set domain's custom XML metadata
    migrate                        migrate domain to another host
    migrate-setmaxdowntime         set maximum tolerable downtime
    migrate-getmaxdowntime         get maximum tolerable downtime
    migrate-compcache              get/set compression cache size
    migrate-setspeed               Set the maximum migration bandwidth
    migrate-getspeed               Get the maximum migration bandwidth
    migrate-postcopy               Switch running migration from pre-copy to post-copy
    numatune                       Get or set numa parameters
    qemu-attach                    QEMU Attach
    qemu-monitor-command           QEMU Monitor Command
    qemu-monitor-event             QEMU Monitor Events
    qemu-agent-command             QEMU Guest Agent Command
    reboot                         reboot a domain
    reset                          reset a domain
    restore                        restore a domain from a saved state in a file
    resume                         resume a domain
    save                           save a domain state to a file
    save-image-define              redefine the XML for a domain's saved state file
    save-image-dumpxml             saved state domain information in XML
    save-image-edit                edit XML for a domain's saved state file
    schedinfo                      show/set scheduler parameters
    screenshot                     take a screenshot of a current domain console and store it into a file
    set-lifecycle-action           change lifecycle actions
    set-user-password              set the user password inside the domain
    setmaxmem                      change maximum memory limit
    setmem                         change memory allocation
    setvcpus                       change number of virtual CPUs
    shutdown                       gracefully shutdown a domain
    start                          start a (previously defined) inactive domain
    suspend                        suspend a domain
    ttyconsole                     tty console
    undefine                       undefine a domain
    update-device                  update device from an XML file
    vcpucount                      domain vcpu counts
    vcpuinfo                       detailed domain vcpu information
    vcpupin                        control or query domain vcpu affinity
    emulatorpin                    control or query domain emulator affinity
    vncdisplay                     vnc display
    guestvcpus                     query or modify state of vcpu in the guest (via agent)
    setvcpu                        attach/detach vcpu or groups of threads
    domblkthreshold                set the threshold for block-threshold event for a given block device or it's backing chain element

 Domain Monitoring (help keyword 'monitor')
    domblkerror                    Show errors on block devices
    domblkinfo                     domain block device size information
    domblklist                     list all domain blocks
    domblkstat                     get device block stats for a domain
    domcontrol                     domain control interface state
    domif-getlink                  get link state of a virtual interface
    domifaddr                      Get network interfaces' addresses for a running domain
    domiflist                      list all domain virtual interfaces
    domifstat                      get network interface stats for a domain
    dominfo                        domain information
    dommemstat                     get memory statistics for a domain
    domstate                       domain state
    domstats                       get statistics about one or multiple domains
    domtime                        domain time
    list                           list domains

 Host and Hypervisor (help keyword 'host')
    allocpages                     Manipulate pages pool size
    capabilities                   capabilities
    cpu-baseline                   compute baseline CPU
    cpu-compare                    compare host CPU with a CPU described by an XML file
    cpu-models                     CPU models
    domcapabilities                domain capabilities
    freecell                       NUMA free memory
    freepages                      NUMA free pages
    hostname                       print the hypervisor hostname
    hypervisor-cpu-baseline        compute baseline CPU usable by a specific hypervisor
    hypervisor-cpu-compare         compare a CPU with the CPU created by a hypervisor on the host
    maxvcpus                       connection vcpu maximum
    node-memory-tune               Get or set node memory parameters
    nodecpumap                     node cpu map
    nodecpustats                   Prints cpu stats of the node.
    nodeinfo                       node information
    nodememstats                   Prints memory stats of the node.
    nodesuspend                    suspend the host node for a given time duration
    sysinfo                        print the hypervisor sysinfo
    uri                            print the hypervisor canonical URI
    version                        show version

 Interface (help keyword 'interface')
    iface-begin                    create a snapshot of current interfaces settings, which can be later committed (iface-commit) or restored (iface-rollback)
    iface-bridge                   create a bridge device and attach an existing network device to it
    iface-commit                   commit changes made since iface-begin and free restore point
    iface-define                   define an inactive persistent physical host interface or modify an existing persistent one from an XML file
    iface-destroy                  destroy a physical host interface (disable it / "if-down")
    iface-dumpxml                  interface information in XML
    iface-edit                     edit XML configuration for a physical host interface
    iface-list                     list physical host interfaces
    iface-mac                      convert an interface name to interface MAC address
    iface-name                     convert an interface MAC address to interface name
    iface-rollback                 rollback to previous saved configuration created via iface-begin
    iface-start                    start a physical host interface (enable it / "if-up")
    iface-unbridge                 undefine a bridge device after detaching its slave device
    iface-undefine                 undefine a physical host interface (remove it from configuration)

 Network Filter (help keyword 'filter')
    nwfilter-define                define or update a network filter from an XML file
    nwfilter-dumpxml               network filter information in XML
    nwfilter-edit                  edit XML configuration for a network filter
    nwfilter-list                  list network filters
    nwfilter-undefine              undefine a network filter
    nwfilter-binding-create        create a network filter binding from an XML file
    nwfilter-binding-delete        delete a network filter binding
    nwfilter-binding-dumpxml       network filter information in XML
    nwfilter-binding-list          list network filter bindings

 Networking (help keyword 'network')
    net-autostart                  autostart a network
    net-create                     create a network from an XML file
    net-define                     define an inactive persistent virtual network or modify an existing persistent one from an XML file
    net-destroy                    destroy (stop) a network
    net-dhcp-leases                print lease info for a given network
    net-dumpxml                    network information in XML
    net-edit                       edit XML configuration for a network
    net-event                      Network Events
    net-info                       network information
    net-list                       list networks
    net-name                       convert a network UUID to network name
    net-start                      start a (previously defined) inactive network
    net-undefine                   undefine a persistent network
    net-update                     update parts of an existing network's configuration
    net-uuid                       convert a network name to network UUID

 Node Device (help keyword 'nodedev')
    nodedev-create                 create a device defined by an XML file on the node
    nodedev-destroy                destroy (stop) a device on the node
    nodedev-detach                 detach node device from its device driver
    nodedev-dumpxml                node device details in XML
    nodedev-list                   enumerate devices on this host
    nodedev-reattach               reattach node device to its device driver
    nodedev-reset                  reset node device
    nodedev-event                  Node Device Events

 Secret (help keyword 'secret')
    secret-define                  define or modify a secret from an XML file
    secret-dumpxml                 secret attributes in XML
    secret-event                   Secret Events
    secret-get-value               Output a secret value
    secret-list                    list secrets
    secret-set-value               set a secret value
    secret-undefine                undefine a secret

 Snapshot (help keyword 'snapshot')
    snapshot-create                Create a snapshot from XML
    snapshot-create-as             Create a snapshot from a set of args
    snapshot-current               Get or set the current snapshot
    snapshot-delete                Delete a domain snapshot
    snapshot-dumpxml               Dump XML for a domain snapshot
    snapshot-edit                  edit XML for a snapshot
    snapshot-info                  snapshot information
    snapshot-list                  List snapshots for a domain
    snapshot-parent                Get the name of the parent of a snapshot
    snapshot-revert                Revert a domain to a snapshot

 Storage Pool (help keyword 'pool')
    find-storage-pool-sources-as   find potential storage pool sources
    find-storage-pool-sources      discover potential storage pool sources
    pool-autostart                 autostart a pool
    pool-build                     build a pool
    pool-create-as                 create a pool from a set of args
    pool-create                    create a pool from an XML file
    pool-define-as                 define a pool from a set of args
    pool-define                    define an inactive persistent storage pool or modify an existing persistent one from an XML file
    pool-delete                    delete a pool
    pool-destroy                   destroy (stop) a pool
    pool-dumpxml                   pool information in XML
    pool-edit                      edit XML configuration for a storage pool
    pool-info                      storage pool information
    pool-list                      list pools
    pool-name                      convert a pool UUID to pool name
    pool-refresh                   refresh a pool
    pool-start                     start a (previously defined) inactive pool
    pool-undefine                  undefine an inactive pool
    pool-uuid                      convert a pool name to pool UUID
    pool-event                     Storage Pool Events

 Storage Volume (help keyword 'volume')
    vol-clone                      clone a volume.
    vol-create-as                  create a volume from a set of args
    vol-create                     create a vol from an XML file
    vol-create-from                create a vol, using another volume as input
    vol-delete                     delete a vol
    vol-download                   download volume contents to a file
    vol-dumpxml                    vol information in XML
    vol-info                       storage vol information
    vol-key                        returns the volume key for a given volume name or path
    vol-list                       list vols
    vol-name                       returns the volume name for a given volume key or path
    vol-path                       returns the volume path for a given volume name or key
    vol-pool                       returns the storage pool for a given volume key or path
    vol-resize                     resize a vol
    vol-upload                     upload file contents to a volume
    vol-wipe                       wipe a vol

