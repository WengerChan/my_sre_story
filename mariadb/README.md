# mariadb/mysql学习笔记

## 概述

### 检查是否运行

Linux:

```sh
ps aux | grep mysql

2763 ?　　　　00：00：00 mysqld_safe
2900 ?　　　　5-23：48：51 mysqld
```

在 Windows 中，可用 `tasklist` 检查：

```bat
tasklist /fi "IMAGENAME eq mysqld"

Image Name　　　　　PID　Session Name　　 Session#　 Mem Usage
==============　=======　==============　=========　==========
mysqld．exe　　　　 1356　Services　　　　　　　　0　　　 212 K
```

### 版本信息

```
mysqladmin -p version status
```