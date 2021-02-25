# 

## kvm管理命令

### 查看虚拟机

```
# 显示正在运行的虚拟机
virsh list

# 显示所有虚拟机
virsh list --all
```

### 启动, 关闭, 挂起

```
# 启动
virsh start VM-NAME

# 正常关闭
virsh shutdown VM-NAME

# 挂起
virsh suspend VM-NAME

# 强制关闭
virsh destroy VM-NAME

# 开机自启
virsh autostart VM-NAME

# 取消开机自启
virsh autostart --disable VM-NAME

```
