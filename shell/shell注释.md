# shell注释

## 单行注释

使用 `#`

## 多行注释

1. 使用多个 `#`

2. 采用 `HERE DOCUMENT` 特性

```sh
<< COMMENT
...
COMMENT
```

3. 采用 `:` 命令的特殊作用

> 这种做法有很多局限性，而且会影响性能

```sh
: '
COMMENT1
COMMENT2
'
```

关于 `:`

```sh
shell> help :
:: :
    Null command.
    
    No effect; the command does nothing.
    
    Exit Status:
    Always succeeds.
```

`:` 也是一个命令，因此可以给它传参数。但因它会过滤掉这些参数，而单引号括起来的是普通的代码部分表示字符串，所以我们刚好可将来用来代表注释，表示在 ·:· 后的单引号括起来的部分在程序执行的时候忽略。

此用法潜藏的问题：

- 它不会注释 shell 脚本中本身带有单引号的语句部分，除非你将程序中的单引号全部换成右引号，这样不爽。
- 此外，虽然 `:` 会忽视后面的参数，但其实参数部分还是可能会被执行些操作，比如**替换操作**，**文件截取操作**等，所以这样会影响到代码的执行效率。例如：
    * `: > file` 会截取 `file`  
    * `: $(dangerous command)` 这个替换操作照样会执行  

4. 采用 `: + << 'COMMENT'` 组合的方式

```sh
: << COMMENT
...
COMMENT
```