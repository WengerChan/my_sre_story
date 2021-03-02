## 临时配置

1. 服务器当前IP

```
[root@rhel79 ~]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:f0:a3:23 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.103/24 brd 192.168.1.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::5054:ff:fef0:a323/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:fb:c9:52 brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.103/24 brd 192.168.2.255 scope global eth1
       valid_lft forever preferred_lft forever
    inet6 fe80::5054:ff:fefb:c952/64 scope link 
       valid_lft forever preferred_lft forever
```

2. eth0网卡中有配置`GATEWAY=192.168.1.100`, 而网卡eth1中无相关字段。

```
[root@rhel79 ~]# ip route 
default via 192.168.1.100 dev eth0               <= 默认网关配在eth0上
169.254.0.0/16 dev eth0 scope link metric 1002 
169.254.0.0/16 dev eth1 scope link metric 1003 
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.103 
192.168.2.0/24 dev eth1 proto kernel scope link src 192.168.2.103 


[root@rhel79 ~]# routel 
         target            gateway          source    proto    scope    dev tbl
        default      192.168.1.100                                     eth0 
   169.254.0.0/ 16                                              link   eth0 
   169.254.0.0/ 16                                              link   eth1 
   192.168.1.0/ 24                   192.168.1.103   kernel     link   eth0 
   192.168.2.0/ 24                   192.168.2.103   kernel     link   eth1 
      127.0.0.0          broadcast       127.0.0.1   kernel     link     lo local
     127.0.0.0/ 8            local       127.0.0.1   kernel     host     lo local
      127.0.0.1              local       127.0.0.1   kernel     host     lo local
127.255.255.255          broadcast       127.0.0.1   kernel     link     lo local
    192.168.1.0          broadcast   192.168.1.103   kernel     link   eth0 local
  192.168.1.103              local   192.168.1.103   kernel     host   eth0 local
  192.168.1.255          broadcast   192.168.1.103   kernel     link   eth0 local
    192.168.2.0          broadcast   192.168.2.103   kernel     link   eth1 local
  192.168.2.103              local   192.168.2.103   kernel     host   eth1 local
  192.168.2.255          broadcast   192.168.2.103   kernel     link   eth1 local
```

3. 此时的路由是不满足需求的: 默认网关配置在eth0上, eth1与其他网段通信时存在问题, 如下示例。

```
[root@rhel79 ~]# ping -I eth0 192.168.80.134
PING 192.168.80.134 (192.168.80.134) from 192.168.1.103 eth0: 56(84) bytes of data.
64 bytes from 192.168.80.134: icmp_seq=1 ttl=64 time=0.510 ms
64 bytes from 192.168.80.134: icmp_seq=2 ttl=64 time=0.224 ms
64 bytes from 192.168.80.134: icmp_seq=3 ttl=64 time=0.273 ms
^C
--- 192.168.80.134 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 0.224/0.335/0.510/0.126 ms

[root@rhel79 ~]# ping -I eth1 192.168.80.134                       <= eth1无法通过网关访问其他子网的(192.168.80.134)
PING 192.168.80.134 (192.168.80.134) from 192.168.2.103 eth1: 56(84) bytes of data.
^C
--- 192.168.80.134 ping statistics ---
5 packets transmitted, 0 received, 100% packet loss, time 4006ms
```

4. 配置临时路由表

4.1 需要配置的信息如下：

```
eth0  192.168.1.103/24 GW=192.168.1.100
eth1  192.168.1.103/24 GW=192.168.2.100
```

4.2 执行命令配置:

> 参考: [_How can I route network traffic such that the packets go out via the same interface they came in?_](https://access.redhat.com/solutions/19596)

```sh
ip route add 192.168.1.0/24 dev eth0 table 1
ip route add default via 192.168.1.100 dev eth0 table 1
ip route add 192.168.2.0/24 dev eth1 table 2
ip route add default via 192.168.2.100 dev eth1 table 2

ip rule add iif eth0 table 1
ip rule add iif eth1 table 2

ip rule add from 192.168.1.103 table 1
ip rule add from 192.168.2.103 table 2
```

```
[root@rhel79 ~]# ip route     <== 查看不到变化
default via 192.168.1.100 dev eth0 
169.254.0.0/16 dev eth0 scope link metric 1002 
169.254.0.0/16 dev eth1 scope link metric 1003 
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.103 
192.168.2.0/24 dev eth1 proto kernel scope link src 192.168.2.103


[root@rhel79 ~]# routel       <== 多了两个default和两条规则 
           target            gateway          source    proto    scope    dev tbl
        default      192.168.1.100                                     eth0 1      <=
   192.168.1.0/ 24                                              link   eth0 1      <=
        default      192.168.2.100                                     eth1 2      <=
   192.168.2.0/ 24                                              link   eth1 2      <=
        default      192.168.1.100                                     eth0 
   169.254.0.0/ 16                                              link   eth0 
   169.254.0.0/ 16                                              link   eth1 
   192.168.1.0/ 24                   192.168.1.103   kernel     link   eth0 
   192.168.2.0/ 24                   192.168.2.103   kernel     link   eth1 
      127.0.0.0          broadcast       127.0.0.1   kernel     link     lo local
     127.0.0.0/ 8            local       127.0.0.1   kernel     host     lo local
      127.0.0.1              local       127.0.0.1   kernel     host     lo local
127.255.255.255          broadcast       127.0.0.1   kernel     link     lo local
    192.168.1.0          broadcast   192.168.1.103   kernel     link   eth0 local
  192.168.1.103              local   192.168.1.103   kernel     host   eth0 local
  192.168.1.255          broadcast   192.168.1.103   kernel     link   eth0 local
    192.168.2.0          broadcast   192.168.2.103   kernel     link   eth1 local
  192.168.2.103              local   192.168.2.103   kernel     host   eth1 local
  192.168.2.255          broadcast   192.168.2.103   kernel     link   eth1 local
```

4.3 此时两张网卡都可以单独与192.168.80.134通信

```
[root@rhel79 ~]# ping -I eth0 192.168.80.134
PING 192.168.80.134 (192.168.80.134) from 192.168.1.103 eth0: 56(84) bytes of data.
64 bytes from 192.168.80.134: icmp_seq=1 ttl=64 time=0.679 ms
64 bytes from 192.168.80.134: icmp_seq=2 ttl=64 time=1.41 ms
64 bytes from 192.168.80.134: icmp_seq=3 ttl=64 time=1.64 ms
^C
--- 192.168.80.134 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2019ms
rtt min/avg/max/mdev = 0.679/1.246/1.642/0.413 ms

[root@rhel79 ~]# ping -I eth1 192.168.80.134
PING 192.168.80.134 (192.168.80.134) from 192.168.2.103 eth1: 56(84) bytes of data.
64 bytes from 192.168.80.134: icmp_seq=1 ttl=64 time=0.673 ms
64 bytes from 192.168.80.134: icmp_seq=2 ttl=64 time=0.944 ms
64 bytes from 192.168.80.134: icmp_seq=3 ttl=64 time=1.16 ms
^C
--- 192.168.80.134 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2022ms
rtt min/avg/max/mdev = 0.673/0.927/1.165/0.202 ms
```


5. 配置永久路由表

5.1 需要配置的信息如下：

```
eth0  192.168.1.103/24 GW=192.168.1.100
eth1  192.168.1.103/24 GW=192.168.2.100
```

5.2 配置

```
shell> cat /etc/sysconfig/network-scripts/rule-eth0
iif eth0 table 1
from 192.168.1.103 table 1

shell> cat /etc/sysconfig/network-scripts/rule-eth1
iif eth1 table 2
from 192.168.2.103 table 2

shell> cat /etc/sysconfig/network-scripts/route-eth0
192.168.1.0/24 dev eth0 table 1
default via 192.168.1.100 dev eth0 table 1

shell> cat /etc/sysconfig/network-scripts/route-eth1
192.168.2.0/24 dev eth1 table 2
default via 192.168.2.100 dev eth1 table 2
```

5.3 永久路由配置说明

> 参考: [_How to make routing rules persistent, when I want packets to leave the same interface they came in?_](https://access.redhat.com/knowledge/solutions/288823)

5.3.1 Create a _rule-eth*_ file for each interface, including the following information. This is where the separate routing tables will be created. The table numbers can be modified to fit your environment needs.

- When creating a rule file you need to include a priority number that is unique for each rule defined. Think of the priority numbers as index values that tell the kernel the rule is being updated or is a brand new rule being added. Failure to add in a priority number will cause duplicate rules to show up in the ip rule show output. (see `man ip-rule`)

- _priority_ PREFERENCE: the priority of this rule. PREFERENCE is an unsigned integer value, higher number means lower priority, and rules get processed in order of in-
creasing number. Each rule should have an explicitly set unique priority value. The options preference and order are synonyms with priority.

- Please note that for IP addresses configured on interface aliases (e.g. `eth0:1`) route/rule file should be created as per interface not per alias (e.g. for IP used on `eth0:1` file name should be `route-eth0`).

    * eth0 example

    ```
    shell> cat /etc/sysconfig/network-scripts/rule-eth0

    iif eth0 prio <integer> table 1
    from <ip of eth0> prio <integer> table 1
    ```

    * eth1 example
    

    ```
    shell> cat /etc/sysconfig/network-scripts/rule-eth1

    iif eth1 prio <integer> table 2
    from <ip of eth1> prio <integer-value> table 2
    ```
- In case you need outgoing traffic to be handled from a specific interface, then you can use "`to`" prefix as well. For more information, check `man ip-rule`.

```
oif eth1 prio <integer> table 2
to <ip of remote host or subnet> prio <integer> table 2
```

5.3.2 Create a _route-eth*_ file for each interface, including the default route to the gateway, the directly connected network, and any additional static routes needed. The table numbers would need to match what was used in the _rule-eth*_ files.

- eth0 example

```
shell> cat /etc/sysconfig/network-scripts/route-eth0

<network/prefix> dev eth0 table 1
default via <gateway address> dev eth0 table 1
#to add additional static routes
#<network address> via <gateway address> dev eth0 table 1
```

- eth1 example

```
shell> cat /etc/sysconfig/network-scripts/route-eth1

<network/prefix> dev eth1 table 2
default via <gateway address> dev eth1 table 2
#to add additional static routes
#<network address> via <gateway address> dev eth1 table 2
```

5.3.3 To create IPv6 routes and rules [_How to create static IPv6 Routes and rules_](https://access.redhat.com/solutions/3455031)

5.3.4 To handle traffic initiated from within the system, either maintain the default routing table or add a loopback rule to route the traffic on one of the policy tables:

```
shell> grep "iff lo"  /etc/sysconfig/network-scripts/rule-eth0
iff lo prio <integer>  table 1
```

5.3.4 These files can also be created using the bond interface as well.