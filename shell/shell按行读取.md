# shell按行读取

## 1 从文件中按行读取(以常见的csv文件为例)

```sh
#! /bin/bash 

file_T="test.csv"   # 给定csv文件名
# test.csv内容示例：
# os_type,os_version,rpm_name,rpm_version
# redhat,6,openssh,5.3p1-124.el6_10.x86_64
# redhat,7,openssh,7.4p1-21.el7.x86_64

num=0
IFS=,     # 修改默认分隔符 <= 注：Internal Field Seprator，内部域分隔符

# 按行读取文件，并将四个值分别赋值给四个变量
while read -r os_type_T os_version_T rpm_name_T rpm_version_T
    do
        let num+=1
        echo "======${num}======"
        echo "os_type_T=${os_type_T}"
        echo "os_version_T=${os_version_T}"
        echo "rpm_name_T=${rpm_name_T}"
        echo "rpm_version_T=${rpm_version_T}"
    done < ${file_T}
```

## 2 从 "`<<EOF`" 输入的文本中按行读取

```sh
#! /bin/bash

num=0
IFS=,     # 修改默认分隔符 <= 注：Internal Field Seprator，内部域分隔符

# 按行读取输入，并将四个值分别赋值给四个变量
while read -r os_type_T os_version_T rpm_name_T rpm_version_T
    do
        let num+=1
        echo "======${num}======"
        echo "os_type_T=${os_type_T}"
        echo "os_version_T=${os_version_T}"
        echo "rpm_name_T=${rpm_name_T}"
        echo "rpm_version_T=${rpm_version_T}"
    done << EOF
redhat,6,openssh,5.3p1-124.el6_10.x86_64
redhat,7,openssh,7.4p1-21.el7.x86_64
EOF
```

## 3 从命令输出结果中按行读取

```sh
#! /bin/bash

num=0
IFS=,     # 修改默认分隔符 <= 注：Internal Field Seprator，内部域分隔符

# 按行读取输入，并将四个值分别赋值给四个变量
while read -r os_type_T os_version_T rpm_name_T rpm_version_T
    do
        let num+=1
        echo "======${num}======"
        echo "os_type_T=${os_type_T}"
        echo "os_version_T=${os_version_T}"
        echo "rpm_name_T=${rpm_name_T}"
        echo "rpm_version_T=${rpm_version_T}"
    done <<< "$(echo -e 'redhat,6,openssh,5.3p1-124.el6_10.x86_64\nredhat,7,openssh,7.4p1-21.el7.x86_64')"
# 此处的""必须加，因为设置了"IFS=,"，如果不加的话，shell将","作为分隔符而隐藏。参考：
# shell> IFS=,
# shell> var='a,b,c'
# shell> echo $var
# a b c
# shell> echo "$var"

# 也可以用下面这种写法完成
while read -r os_type_T os_version_T rpm_name_T rpm_version_T
    do
        let num+=1
        echo "======${num}======"
        echo "os_type_T=${os_type_T}"
        echo "os_version_T=${os_version_T}"
        echo "rpm_name_T=${rpm_name_T}"
        echo "rpm_version_T=${rpm_version_T}"
    done < <(echo -e 'redhat,6,openssh,5.3p1-124.el6_10.x86_64\nredhat,7,openssh,7.4p1-21.el7.x86_64')
```