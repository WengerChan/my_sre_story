# 所有windows巡检项


| 检查方法分类分组                | 检查项名称                                     | 是否覆盖 | 基线/巡检 |
|--------------------------------|-----------------------------------------------|---------|----------|
| 帐户策略 -> 密码策略            | 密码必须符合复杂性要求                           | 是    | 基线    |
| 帐户策略 -> 密码策略            | 密码长度最小值                                   | 是    | 基线    |
| 帐户策略 -> 密码策略            | 密码最短使用期限                                  | 是    | 基线    |
| 帐户策略 -> 密码策略            | 密码最长使用期限                                  | 是    | 基线    |
| 帐户策略 -> 密码策略            | 强制密码历史                                    | 是    | 基线    |
| 帐户策略 -> 密码策略            | 禁用“用可还原的加密来储存密码”                          | 是    | 基线    |
| 帐户策略 -> 帐户锁定策略        | 帐户锁定时间                                    | 是    | 基线    |
| 帐户策略 -> 帐户锁定策略        | 帐户锁定阈值                                    | 是    | 基线    |
| 帐户策略 -> 帐户锁定策略        | 重置帐户锁定计数器                                 | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核策略更改                                    | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核登录事件                                    | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核对象访问                                    | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核进程跟踪                                    | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核目录服务访问                                  | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核权限使用                                    |      |       |
| 本地策略 -> 审核策略            | 审核系统事件                                    | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核帐户登录事件                                  | 是    | 基线    |
| 本地策略 -> 审核策略            | 审核帐户管理                                    | 是    | 基线    |
| 本地策略 -> 用户权限分配        | “从网络访问此计算机”权限配置                           |      |       |
| 本地策略 -> 用户权限分配        | “从远程系统强制关机”权限配置                           |      |       |
| 本地策略 -> 用户权限分配        | “更改时区”权限配置                                |      |       |
| 本地策略 -> 用户权限分配        | “更改系统时间”权限配置                              |      |       |
| 本地策略 -> 用户权限分配        | “关闭系统”权限配置                                |      |       |
| 本地策略 -> 用户权限分配        | “管理审核和安全日志”权限配置                           |      |       |
| 本地策略 -> 用户权限分配        | “还原文件和目录”权限配置                             |      |       |
| 本地策略 -> 用户权限分配        | 获取同一会话中另一个用户的模拟令牌                         |      |       |
| 本地策略 -> 用户权限分配        | “加载和卸载设备驱动程序”权限配置                         |      |       |
| 本地策略 -> 用户权限分配        | 把工作站添加到域                                  |      |       |
| 本地策略 -> 用户权限分配        | “拒绝本地登录”权限配置                              |      |       |
| 本地策略 -> 用户权限分配        | “拒绝从网络访问这台计算机”权限配置                        |      |       |
| 本地策略 -> 用户权限分配        | “拒绝通过远程桌面服务登录”权限配置                        |      |       |
| 本地策略 -> 用户权限分配        | “拒绝以服务身份登录”权限配置                           |      |       |
| 本地策略 -> 用户权限分配        | “拒绝作为批处理作业登录”权限配置                         |      |       |
| 本地策略 -> 用户权限分配        | “配置文件单个进程”权限配置                            |      |       |
| 本地策略 -> 用户权限分配        | “配置文件系统性能”权限配置                            |      |       |
| 本地策略 -> 用户权限分配        | “取得文件或其他对象的所有权”权限配置                       | 是    | 基线    |
| 本地策略 -> 用户权限分配        | 绕过遍历检查                                    | 是    | 基线    |
| 本地策略 -> 用户权限分配        | “身份验证后模拟客户端”权限配置                          |      |       |
| 本地策略 -> 用户权限分配        | “生成安全审核”权限配置                              |      |       |
| 本地策略 -> 用户权限分配        | “锁定内存页”权限配置                               |      |       |
| 本地策略 -> 用户权限分配        | “提高计划优先级”权限配置                             |      |       |
| 本地策略 -> 用户权限分配        | “替换一个进程级令牌”权限配置                           |      |       |
| 本地策略 -> 用户权限分配        | “调试程序”权限配置                                |      |       |
| 本地策略 -> 用户权限分配        | “同步目录服务数据”权限配置                            |      |       |
| 本地策略 -> 用户权限分配        | “为进程调整内存配额”权限配置                           |      |       |
| 本地策略 -> 用户权限分配        | “信任计算机和用户帐户可以执行委派”权限配置                    |      |       |
| 本地策略 -> 用户权限分配        | “修改固件环境值”权限配置                             |      |       |
| 本地策略 -> 用户权限分配        | “修改一个对象标签”权限配置                            |      |       |
| 本地策略 -> 用户权限分配        | “以操作系统方式执行”权限配置                           |      |       |
| 本地策略 -> 用户权限分配        | “允许本地登录”权限配置                              | 是    | 基线    |
| 本地策略 -> 用户权限分配        | “允许通过远程桌面服务登录”权限配置                        | 是    | 基线    |
| 本地策略 -> 用户权限分配        | 增加进程工作集                                   |      |       |
| 本地策略 -> 用户权限分配        | “执行卷维护任务”权限配置                             |      |       |
| 本地策略 -> 用户权限分配        | 作为服务登录                                    |      |       |
| 本地策略 -> 用户权限分配        | “作为批处理作业登录”权限配置(仅限域控制器)                   | 是    | 基线    |
| 本地策略 -> 用户权限分配        | “作为受信任的呼叫方访问凭据管理器”权限配置                    |      |       |
| 本地策略 -> 安全选项            | 帐户：使用空密码的本地帐户只允许进行控制台登录                   |      |       |
| 本地策略 -> 安全选项            | 帐户：组织Microsoft帐户                          |      |       |
| 本地策略 -> 安全选项            | 审核: 对备份和还原权限的使用进行审核                       |      |       |
| 本地策略 -> 安全选项            | 审核: 对全局系统对象的访问权限进行审核                      |      |       |
| 本地策略 -> 安全选项            | 审核: 如果无法记录安全审核则立即关闭系统                     |      |       |
| 本地策略 -> 安全选项            | 设备: 将 CD-ROM 的访问权限仅限于本地登录的用户              |      |       |
| 本地策略 -> 安全选项            | 设备: 将软盘的访问权限仅限于本地登录的用户                    |      |       |
| 本地策略 -> 安全选项            | 设备: 允许在未登录的情况下移除                          |      |       |
| 本地策略 -> 安全选项            | 域控制器: 允许服务器操作者计划任务                        |      |       |
| 本地策略 -> 安全选项            | 域控制器: LDAP 服务器签名要求                        |      |       |
| 本地策略 -> 安全选项            | 域控制器: 拒绝计算机帐户密码更改                         |      |       |
| 本地策略 -> 安全选项            | 对安全通道数据进行数字加密或数字签名                        |      |       |
| 本地策略 -> 安全选项            | 域成员: 对安全通道数据进行数字加密(如果可能)                  |      |       |
| 本地策略 -> 安全选项            | 域成员: 对安全通道数据进行数字签名(如果可能)                  |      |       |
| 本地策略 -> 安全选项            | 域成员：计算机帐户密码最长使用期限                         |      |       |
| 本地策略 -> 安全选项            | 域成员: 需要使用强会话密钥(Windows 2000 或更高版本)        |      |       |
| 本地策略 -> 安全选项            | 域成员: 禁用计算机帐户密码更改                          |      |       |
| 本地策略 -> 安全选项            | 交互式登录: 不显示上次登录                            | 是    | 基线    |
| 本地策略 -> 安全选项            | 交互式登录: 需要域控制器身份验证以对工作站进行解锁                | 是    | 基线    |
| 本地策略 -> 安全选项            | 交互式登录：之前登录到缓存的次数（域控制器不可用时）                | 是    | 基线    |
| 本地策略 -> 安全选项            | Microsoft 网络客户端：对通信进行数字签名(始终)             |      |       |
| 本地策略 -> 安全选项            | Microsoft 网络客户端：对通信进行数字签名(如果服务器允许)        |      |       |
| 本地策略 -> 安全选项            | Microsoft 网络客户端: 不允许将未加密的密码发送到第三方 SMB 服务器 | 是    | 基线    |
| 本地策略 -> 安全选项            | Microsoft 网络服务器：对通信进行数字签名(始终)             |      |       |
| 本地策略 -> 安全选项            | Microsoft 网络服务器：对通信进行数字签名(如果客户端允许)        |      |       |
| 本地策略 -> 安全选项            | Microsoft 网络服务器: 服务器 SPN 目标名称验证级别         |      |       |
| 本地策略 -> 安全选项            | Microsoft 网络服务器: 暂停会话前所需的空闲时间量            | 是    | 基线    |
| 本地策略 -> 安全选项            | Microsoft 网络服务器: 尝试使用 S4U2Self 获取声明信息     |      |       |
| 本地策略 -> 安全选项            | Microsoft 网络服务器: 登录时间过期后断开与客户端的连接         |      |       |
| 本地策略 -> 安全选项            | 网络访问: 本地帐户的共享和安全模型                        | 是    | 基线    |
| 本地策略 -> 安全选项            | 网络访问: 不允许 SAM 帐户的匿名枚举                     | 是    | 基线    |
| 本地策略 -> 安全选项            | 网络访问: 不允许 SAM 帐户和共享的匿名枚举                  | 是    | 基线    |
| 本地策略 -> 安全选项            | 网络访问: 不允许存储网络身份验证的密码和凭据                   |      |       |
| 本地策略 -> 安全选项            | 网络访问: 将 Everyone 权限应用于匿名用户                | 是    | 基线    |
| 本地策略 -> 安全选项            | 网络访问: 可匿名访问的共享                            |      |       |
| 本地策略 -> 安全选项            | 网络访问: 可匿名访问的命名管道                          |      |       |
| 本地策略 -> 安全选项            | 网络访问: 可远程访问的注册表路径（CIS）                    |      |       |
| 本地策略 -> 安全选项            | 网络访问: 可远程访问的注册表路径(无值)                     |      |       |
| 本地策略 -> 安全选项            | 网络访问: 可远程访问的注册表路径和子路径（CIS）                |      |       |
| 本地策略 -> 安全选项            | 网络访问: 可远程访问的注册表路径和子路径(无值)                 |      |       |
| 本地策略 -> 安全选项            | 网络访问: 限制对命名管道和共享的匿名访问                     | 是    | 基线    |
| 本地策略 -> 安全选项            | 网络访问: 限制允许对 SAM 进行远程调用的客户端                |      |       |
| 本地策略 -> 安全选项            | 网络访问: 允许匿名 SID/名称转换                       | 是    | 基线    |
| 本地策略 -> 安全选项            | 网络安全: LAN 管理器身份验证级别                       |      |       |
| 本地策略 -> 安全选项            | 网络安全: LDAP 客户端签名要求                        | 是    | 基线    |
| 本地策略 -> 安全选项            | 网络安全: 基于 NTLM SSP 的(包括安全 RPC)服务器的最小会话安全   |      |       |
| 本地策略 -> 安全选项            | 网络安全: 基于 NTLM SSP 的(包括安全 RPC)客户端的最小会话安全   |      |       |
| 本地策略 -> 安全选项            | 网络安全: 配置 Kerberos 允许的加密类型                 |      |       |
| 本地策略 -> 安全选项            | 网络安全: 限制 NTLM: 传入 NTLM 流量                 |      |       |
| 本地策略 -> 安全选项            | 网络安全: 限制 NTLM: 此域中的 NTLM 身份验证             |      |       |
| 本地策略 -> 安全选项            | 网络安全: 限制 NTLM: 到远程服务器的传出 NTLM 流量          |      |       |
| 本地策略 -> 安全选项            | 网络安全: 限制 NTLM: 审核传入 NTLM 流量               |      |       |
| 本地策略 -> 安全选项            | 网络安全: 限制 NTLM: 审核此域中的 NTLM 身份验证           |      |       |
| 本地策略 -> 安全选项            | 网络安全: 限制 NTLM: 添加此域中的服务器例外                |      |       |
| 本地策略 -> 安全选项            | 网络安全: 限制 NTLM: 为 NTLM 身份验证添加远程服务器例外       |      |       |
| 本地策略 -> 安全选项            | 网络安全: 允许 LocalSystem NULL 会话回退            |      |       |
| 本地策略 -> 安全选项            | 网络安全: 允许本地系统将计算机标识用于 NTLM                 |      |       |
| 本地策略 -> 安全选项            | 网络安全: 允许对此计算机的 PKU2U 身份验证请求使用联机标识         |      |       |
| 本地策略 -> 安全选项            | 网络安全: 在超过登录时间后强制注销                        |      |       |
| 本地策略 -> 安全选项            | 网络安全: 在下一次更改密码时不存储 LAN 管理器哈希值             | 是    | 基线    |
| 本地策略 -> 安全选项            | 关机: 清除虚拟内存页面文件                            | 是    | 基线    |
| 本地策略 -> 安全选项            | 用户帐户控制: 标准用户的提升提示行为                       |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 管理员批准模式中管理员的提升权限提示的行为             |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 检测应用程序安装并提示提升                     |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 将文件及注册表写入错误虚拟化到每用户位置              |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 仅提升安装在安全位置的 UIAccess 应用程序         |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 提示提升时切换到安全桌面                      |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 以管理员批准模式运行所有管理员                   |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 用于内置管理员帐户的管理员批准模式                 |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 允许 UIAccess 应用程序在不使用安全桌面的情况下提升权限  |      |       |
| 本地策略 -> 安全选项            | 用户帐户控制: 只提升签名并验证的可执行文件                    |      |       |
| 本地策略 -> 安全选项            | MSS: 禁用自动登录                               |      |       |
| 本地策略 -> 安全选项            | MSS: 禁用IPv6源路由                            |      |       |
| 本地策略 -> 安全选项            | MSS: 禁用IPv4源路由                            |      |       |
| 本地策略 -> 安全选项            | MSS: 禁用ICMP重定向                            | 是    | 基线    |
| 本地策略 -> 安全选项            | MSS: KeepAliveTime配置                      |      |       |
| 本地策略 -> 安全选项            | MSS: 忽略NetBIOS的名称发布请求                     |      |       |
| 本地策略 -> 安全选项            | MSS: 允许IRDP检测和配置默认网关地址                    |      |       |
| 本地策略 -> 安全选项            | MSS: 启用安全DLL搜索模式                          |      |       |
| 本地策略 -> 安全选项            | MSS: 屏幕保护程序宽限期                            |      |       |
| 本地策略 -> 安全选项            | MSS: IPv6 TCP未被确认数据重传次数                   |      |       |
| 本地策略 -> 安全选项            | MSS: IPv4 TCP未被确认数据重传次数                   |      |       |
| 本地策略 -> 安全选项            | MSS: IPv4 告警事件在安全日志最高占比配置                 |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：防火墙状态                       |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：入站连接                        |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：出站连接                        |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：设置：显示通知                     |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：设置：应用本地防火墙规则                |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：设置：应用本地连接安全规则               |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：日志：名称                       |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：日志：大小限制                     |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：日志：记录被丢弃的数据包                |      |       |
| 高级安全Windows防火墙 -> 域防火墙   | Windows防火墙域配置：日志：记录成功的连接                  |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：防火墙状态                      |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：入站连接                       |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：出站连接                       |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：设置：显示通知                    |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：设置：应用本地防火墙规则               |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：设置：应用本地连接安全规则              |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：日志：名称                      |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：日志：大小限制                    |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：日志：记录被丢弃的数据包               |      |       |
| 高级安全Windows防火墙 -> 专用防火墙 | Windows防火墙专用配置：日志：记录成功的连接                 |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：防火墙状态                      |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：入站连接                       |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：出站连接                       |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：设置：显示通知                    |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：设置：应用本地防火墙规则               |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：设置：应用本地连接安全规则              |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：日志：名称                      |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：日志：大小限制                    |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：日志：记录被丢弃的数据包               |      |       |
| 高级安全Windows防火墙 -> 公用防火墙 | Windows防火墙公用配置：日志：记录成功的连接                 |      |       |
| 高级审核策略配置 -> 帐户登录        | 审核凭据验证                                    |      |       |
| 高级审核策略配置 -> 帐户登录        | 审核Kerberos身份验证服务                          |      |       |
| 高级审核策略配置 -> 帐户登录        | 审核Kerberos服务票据验证                          |      |       |
| 高级审核策略配置 -> 帐户登录        | 审核其他帐户登录事件                                |      |       |
| 高级审核策略配置 -> 帐户管理        | 审核应用程序组管理                                 |      |       |
| 高级审核策略配置 -> 帐户管理        | 审核计算机帐户管理                                 |      |       |
| 高级审核策略配置 -> 帐户管理        | 审核通讯组管理(仅域控制器)                            |      |       |
| 高级审核策略配置 -> 帐户管理        | 审核其他帐户管理事件                                |      |       |
| 高级审核策略配置 -> 帐户管理        | 审核安全组管理                                   |      |       |
| 高级审核策略配置 -> 帐户管理        | 审核用户帐户管理                                  |      |       |
| 高级审核策略配置 -> 详细跟踪        | 审核DPAPI活动                                 |      |       |
| 高级审核策略配置 -> 详细跟踪        | 审核PNP活动                                   |      |       |
| 高级审核策略配置 -> 详细跟踪        | 审核进程创建                                    |      |       |
| 高级审核策略配置 -> 详细跟踪        | 审核进程终止                                    |      |       |
| 高级审核策略配置 -> 详细跟踪        | 审核RPC事件                                   |      |       |
| 高级审核策略配置 -> 详细跟踪        | 审核令牌权限已调整                                 |      |       |
| 高级审核策略配置 -> DS访问          | 审核详细的目录服务复制                               |      |       |
| 高级审核策略配置 -> DS访问          | 审核目录服务访问(仅域控制器)                           |      |       |
| 高级审核策略配置 -> DS访问          | 审核目录服务更改(仅域控制器)                           |      |       |
| 高级审核策略配置 -> DS访问          | 审核目录服务复制                                  |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核帐户锁定                                    |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核用户/设备声明                                 |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核组成员身份                                   |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核注销                                      |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核登录                                      |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核其他登录/注销事件                               |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核特殊登录                                    |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核网络策略服务器                                 |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核IPsec扩展                                 |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核IPsec主模式                                |      |       |
| 高级审核策略配置 -> 登录/注销       | 审核IPsec快速模式                               |      |       |
| 高级审核策略配置 -> 对象访问        | 审核已生成应用程序                                 |      |       |
| 高级审核策略配置 -> 对象访问        | 审核证书服务                                    |      |       |
| 高级审核策略配置 -> 对象访问        | 审核详细的文件共享                                 |      |       |
| 高级审核策略配置 -> 对象访问        | 审核文件共享                                    |      |       |
| 高级审核策略配置 -> 对象访问        | 审核文件系统                                    |      |       |
| 高级审核策略配置 -> 对象访问        | 审核筛选平台连接                                  |      |       |
| 高级审核策略配置 -> 对象访问        | 审核筛选平台数据包丢弃                               |      |       |
| 高级审核策略配置 -> 对象访问        | 审核句柄操作                                    |      |       |
| 高级审核策略配置 -> 对象访问        | 审核内核对象                                    |      |       |
| 高级审核策略配置 -> 对象访问        | 审核其他对象访问事件                                |      |       |
| 高级审核策略配置 -> 对象访问        | 审核注册表                                     |      |       |
| 高级审核策略配置 -> 对象访问        | 审核SAM                                     |      |       |
| 高级审核策略配置 -> 策略更改        | 审核审核策略更改                                  |      |       |
| 高级审核策略配置 -> 策略更改        | 审核身份验证策略更改                                |      |       |
| 高级审核策略配置 -> 策略更改        | 审核授权策略更改                                  |      |       |
| 高级审核策略配置 -> 策略更改        | 审核筛选平台策略更改                                |      |       |
| 高级审核策略配置 -> 策略更改        | 审核MPSSVC规则级别策略更改                          |      |       |
| 高级审核策略配置 -> 策略更改        | 审核其他策略更改事件                                |      |       |
| 高级审核策略配置 -> 特权使用        | 审核非敏感特权权限使用                               |      |       |
| 高级审核策略配置 -> 特权使用        | 审核其他权限使用事件                                |      |       |
| 高级审核策略配置 -> 特权使用        | 审核敏感权限使用                                  |      |       |
| 高级审核策略配置 -> 系统            | 审核 IPsec 驱动程序                             |      |       |
| 高级审核策略配置 -> 系统            | 审核其他系统事件                                  |      |       |
| 高级审核策略配置 -> 系统            | 审核安全状态更改                                  |      |       |
| 高级审核策略配置 -> 系统            | 审核安全系统扩展                                  |      |       |
| 高级审核策略配置 -> 系统            | 审核系统完整性                                   |      |       |
| 高级审核策略配置 -> 全局对象访问审核 | 全局对象访问审核：文件系统                             |      |       |
| 高级审核策略配置 -> 全局对象访问审核 | 全局对象访问审核：注册表                              |      |       |
| 管理模板(计算机) -> LAPS           | 确保安装LAPS AdmPwd GPO扩展/CSE                 |      |       |
| 管理模板(计算机) -> LAPS           | LAPS-不允许密码过期时间超过策略                        |      |       |
| 管理模板(计算机) -> LAPS           | LAPS-启用本地管理密码管理                           |      |       |
| 管理模板(计算机) -> LAPS           | LAPS-密码复杂度配置                              |      |       |
| 管理模板(计算机) -> LAPS           | LAPS-密码长度配置                               |      |       |
| 管理模板(计算机) -> LAPS           | LAPS-密码有效期配置                              |      |       |
| 管理模板(计算机) -> 网络           | 链路层拓扑发现-禁用Mapper I/O (LLTDIO) driver      |      |       |
| 管理模板(计算机) -> 网络           | 链路层拓扑发现-禁用Responder (RSPNDR) driver       |      |       |
| 管理模板(计算机) -> 网络           | 关闭Microsoft对等网络服务                         |      |       |
| 管理模板(计算机) -> 网络           | 禁止在DNS域网络上安装和配置网桥                         |      |       |
| 管理模板(计算机) -> 网络           | 要求域用户在设置网络位置时提升权限                         |      |       |
| 管理模板(计算机) -> SCM            | 在网络登录时对本地帐户实施UAC限制                        |      |       |
| 管理模板(计算机) -> SCM            | Wdigest身份验证                               |      |       |
|                                   |进程创建事件中包含命令行                              |      |       |
| 管理模板(计算机) -> 系统           | RPC终点映射程序客户端验证                            |      |       |
| 管理模板(计算机) -> 系统           | 用于未验证的RPC客户端的限制                           |      |       |
| 管理模板(计算机) -> 系统           | 启用/禁用PerfTrack                            |      |       |
| 管理模板(计算机) -> 系统           | 启用Windows NTP客户端                          |      |       |
| 管理模板(计算机) -> 系统           | 启用Windows NTP服务器                          |      |       |
| 管理模板(计算机) -> Windows组件    | 提升时枚举管理员帐户                                |      |       |
| 管理模板(计算机) -> Windows组件    | 应用程序日志设置保留旧事件                             |      |       |
| 管理模板(计算机) -> Windows组件    | 应用程序日志达到最大大小时的动作                          |      |       |
| 管理模板(计算机) -> Windows组件    | 应用程序日志最大大小                                |      |       |
| 管理模板(计算机) -> Windows组件    | 安全日志设置保留旧事件                               |      |       |
| 管理模板(计算机) -> Windows组件    | 安全日志达到最大大小时的动作                            |      |       |
| 管理模板(计算机) -> Windows组件    | 安全日志最大日志大小                                |      |       |
| 管理模板(计算机) -> Windows组件    | 安装程序日志设置保留旧事件                             |      |       |
| 管理模板(计算机) -> Windows组件    | 安装程序日志最大日志大小                              |      |       |
| 管理模板(计算机) -> Windows组件    | 系统日志设置保留旧事件                               |      |       |
| 管理模板(计算机) -> Windows组件    | 系统日志文件达到最大大小时的动作                          |      |       |
| 管理模板(计算机) -> Windows组件    | 系统日志最大日志大小                                |      |       |
| 管理模板(计算机) -> Windows组件    | 在用户登录期间显示有关以前登录的信息                        |      |       |
| 管理模板(计算机) -> Windows组件    | 不允许保存密码                                   |      |       |
| 管理模板(计算机) -> Windows组件    | 将远程桌面服务用户限制到单独的远程桌面服务会话                   |      |       |
| 管理模板(计算机) -> Windows组件    | 不允许 COM 端口重定向                             |      |       |
| 管理模板(计算机) -> Windows组件    | 不允许驱动器重定向                                 |      |       |
| 管理模板(计算机) -> Windows组件    | 不允许 LPT 端口重定向                             |      |       |
| 管理模板(计算机) -> Windows组件    | 始终在连接时提示输入密码                              |      |       |
| 管理模板(计算机) -> Windows组件    | 要求安全的 RPC 通信                              |      |       |
| 管理模板(计算机) -> Windows组件    | 设置活动但空闲的远程桌面服务会话的时间限制                     |      |       |
| 管理模板(计算机) -> Windows组件    | 设置已中断会话的时间限制                              |      |       |
| 管理模板(计算机) -> Windows组件    | 在退出时删除临时文件夹                               |      |       |
| 管理模板(计算机) -> Windows组件    | 打开 PowerShell 脚本块日志记录                     |      |       |
| 管理模板(计算机) -> Windows组件    | 允许基本身份验证                                  |      |       |
| 管理模板(计算机) -> Windows组件    | 不允许使用摘要式身份验证                              |      |       |
| 管理模板(计算机) -> Windows组件    | 允许基本身份验证(WinRM 服务)                        |      |       |
| 管理模板(计算机) -> Windows组件    | 不允许 WinRM 储存 RunAs 凭据                     |      |       |
| 其他                            | 启用屏幕保护程序                                  |      |       |
| 管理模板(计算机) -> 网络         | 启用SYN攻击保护                                 | 是    | 基线    |
| 管理模板(计算机) -> 网络         | SYN-EnablePMTUDiscovery                   |      |       |
| 管理模板(计算机) -> 网络         | SYN-NoNameReleaseOnDemand                 |      |       |
| 管理模板(计算机) -> 网络         | SYN-EnableDeadGWDetect                    |      |       |
| 管理模板(计算机) -> 网络         | 防止ICMP重定向报文的攻击                            |      |       |
| 管理模板(计算机) -> 网络         | 设置SYN保护阈值                                 |      |       |
| 管理模板(计算机) -> 网络         | 设置在取消重传尝试之前SYN-ACK的重传次数                   |      |       |
| 管理模板(计算机) -> 网络         | 指定处于SYN_RCVD状态的TCP连接数的阈值                  |      |       |
| 管理模板(计算机) -> 网络         | 指定处于至少已发送一次重传的SYN_RCVD状态中的TCP连接数的阈值       |      |       |
| 管理模板(计算机) -> 网络         | SNMP服务不使用public作为团体字                      |      |       |
| 管理模板(计算机) -> 网络         | SNMP对允许采集的IP网段做限制                         |      |       |
| 管理模板(计算机) -> 网络         | 不支持IGMP协议                                 |      |       |
| 管理模板(计算机) -> 网络         | 禁止响应ICMP路由通告报文                            |      |       |
| 管理模板(计算机) -> 网络         | 禁止IPC空连接                                  |      |       |
| 帐户和密码                      | 创建一个陷阱帐户                                  |      |       |
| 防病毒软件                      | 防病毒设置（SCEP）                               |      |       |
| 管理模板(计算机) -> Windows组件  | 防火墙设置                                     |      |       |
| 管理模板(计算机) -> Windows组件  | 登录终端的操作超时锁定                               |      |       |
| 管理模板(计算机) -> Windows组件  | 只允许运行带网络级身份验证的远程桌面的计算机连接                  |      |       |
| 管理模板(计算机) -> Windows组件  | 系统失败自动重新启动                                |      |       |
| 管理模板(计算机) -> Windows组件  | 系统日志要求保存时间                                |      |       |
| 管理模板(计算机) -> Windows组件  | 在恢复时需要密码保护(显示登录屏幕)                        |      |       |
| 管理模板(计算机) -> Windows组件  | 屏幕保护程序等待时间                                |      |       |
| 管理模板(计算机) -> Windows组件  | 启用屏幕保护                                    |      |       |
| 文件系统                        | 非域环境下禁用Windows硬盘默认共享                      |      |       |
| 安全补丁                        | 判断指定补丁是否安装                                |      |       |
| 安全补丁                        | 列举所有已安装补丁                                 |      |       |
| 文件系统                        | 共享文件夹授权访问                                 |      |       |
| 安全补丁                        | 操作系统版本                                    |      |       |
| 安全补丁                        | 操作系统安装距今天数                                |      |       |
| 安全补丁                        | 上次重启距今天数                                  |      |       |
| 帐户和密码                      | 计算机名和host名是否相同                            |      |       |
| 安全补丁                        | 最后补丁距今天数                                  |      |       |
| 安全补丁                        | 关闭自动更新                                    |      |       |
| 安全补丁                        | 自动更新选项                                    |      |       |
| 安全补丁                        | WSUS服务器                                   |      |       |
| 文件系统                        | 禁用NBT                                     |      |       |