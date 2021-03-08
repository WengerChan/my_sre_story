## 第一种: `"'${VAR_NAME}'"`形式

```sh
limit_L=1000
awk -F: '{if($3<"'${limit_L}'") print $1}' /etc/passwd
```

这种情况下`"'${limit_L}'"`或被解释成`"1000"`, awk比对的结果并不是我们想得到的:

```
[root@mgr html]# awk -F: '{if($3<"'${limit_L}'") print $1}' /etc/passwd
root
bin
```

## 第二种: 外部传参

```sh
awk -F: '{if($3<limit_L) print $1}' limit_L=1000 /etc/passwd 
awk -v limit_L=1000 -F: '{if($3<limit_L) print $1}' /etc/passwd
```

- 格式如：`awk '{action}' name=value` ，这样传入变量，可以在 _action_ 中获得值。 

注意：变量名与值放到`{action}`后面, 这种变量在：`BEGIN`的 _action_ 不能获得。

- 格式如：`awk –v name1=value1 [–v name1=value1 …] 'BEGIN{action}'`

注意：用 `-v` 传入变量顺序在 _action_ 前面, 3种类型的 _action_ 中都可以获得到

## 第二种: 获得环境变量

```sh
awk  'BEGIN{for (i in ENVIRON) {print i"="ENVIRON[i];}}'
```

awk内置变量 `ENVIRON`, 就可以直接获得环境变量。它是一个字典数组。__环境变量名__ 就是它的键值。