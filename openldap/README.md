# OpenLDAP 学习文档

## 基础篇

OpenLDAP目前是一款开源账号集中管理软件, 且属于C/S架构。通过配置服务器和客户端, 实现账号的管理, 并通过与第三方应用相结合, 实现客户端所有账号均可通过服务端进行验证, 例如`Samba`、`Apache`、`Zabbix`、`FTP`、`Postfix`、`EMC存储`以及`系统登录验证并授权`。

### 互联网命名组织架构

![LDAP互联网命名组织架构](./pictures/LDAP互联网命名组织架构.png)

LDAP的目录信息以树形结构进行存储: 

- 在树根一般定义国家（`c=CN`）或者域名（`dc=com`）

- 其次往往定义一个或多个组织（`organization`, `o`）或组织单元（`organization unit`, `ou`）

- 一个组织单元可以包含员工、设备信息（计算机/打印机等）相关信息。例如 `uid=babs,ou=People,dc=example,dc=com`


### 企业命名组织架构

![LDAP企业命名组织架构.png](./pictures/LDAP企业命名组织架构.png)


### openldap工作模型


![openldap工作模型.png](./pictures/openldap工作模型.png)

1. 客户端向OpenLDAP服务器发起验证请求
2. 服务器接收用户请求后, 并通过slapd进程向后端的数据库进行查询
3. slapd将查询的结果返回给客户端即可。如果有缓存机制, 服务器端会先将查询的条目进行缓存, 然后再发给客户端

