
::本地策略
@echo off
secedit /export /cfg secbak.inf>nul
::密码必须符合复杂性要求
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "PasswordComplexity" ')  do  set PasswordComplexity=%%j
echo PasswordComplexity%PasswordComplexity%
::密码长度最小值
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "MinimumPasswordLength" ')  do  set MinimumPasswordLength=%%j
echo MinimumPasswordLength%MinimumPasswordLength%
::密码最短使用期限
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "MinimumPasswordAge" ')  do  set MinimumPasswordAge=%%j
echo MinimumPasswordAge%MinimumPasswordAge%
::密码最长使用期限
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "MaximumPasswordAge" ')  do  set MaximumPasswordAge=%%j
echo MaximumPasswordAge %MaximumPasswordAge%
::强制密码历史
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "PasswordHistorySize" ')  do  set PasswordHistorySize=%%j
echo PasswordHistorySize%PasswordHistorySize%
::禁用“用可还原的加密来储存密码”
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "ClearTextPassword" ')  do  set ClearTextPassword=%%j
echo ClearTextPassword%ClearTextPassword%
::帐户锁定时间
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "LockoutDuration" ')  do  set LockoutDuration=%%j
echo LockoutDuration%LockoutDuration%
::帐户锁定阈值
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "LockoutBadCount" ')  do  set LockoutBadCount=%%j
echo LockoutBadCount%LockoutBadCount%
::重置帐户锁定计数器
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "ResetLockoutCount" ')  do  set ResetLockoutCount=%%j
echo ResetLockoutCount%ResetLockoutCount%
::审核策略更改
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditPolicyChange" ')  do  set AuditPolicyChange=%%j
echo AuditPolicyChange%AuditPolicyChange%
::审核登录事件
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditLogonEvents" ')  do  set AuditLogonEvents=%%j
echo AuditLogonEvents%AuditLogonEvents%
::审核对象访问
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditObjectAccess" ')  do  set AuditObjectAccess=%%j
echo AuditObjectAccess%AuditObjectAccess%
::审核进程跟踪
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditProcessTracking" ')  do  set AuditProcessTracking=%%j
echo AuditProcessTracking%AuditProcessTracking%
::审核目录服务访问
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditDSAccess" ')  do  set AuditDSAccess=%%j
echo AuditDSAccess%AuditDSAccess%
::审核权限使用
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditPrivilegeUse" ')  do  set AuditPrivilegeUse=%%j
echo AuditPrivilegeUse%AuditPrivilegeUse%
::审核系统事件
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditSystemEvents" ')  do  set AuditSystemEvents=%%j
echo AuditSystemEvents%AuditSystemEvents%
::审核帐户登录事件
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditAccountLogon" ')  do  set AuditAccountLogon=%%j
echo AuditAccountLogon%AuditAccountLogon%
::审核帐户管理
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "AuditAccountManage" ')  do  set AuditAccountManage=%%j
echo AuditAccountManage%AuditAccountManage%
::“从网络访问此计算机”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeNetworkLogonRight" ')  do  set SeNetworkLogonRight=%%j
echo SeNetworkLogonRight%SeNetworkLogonRight%
::“从远程系统强制关机”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "seremoteshutdownprivilege" ')  do  set seremoteshutdownprivilege=%%j
echo seremoteshutdownprivilege%seremoteshutdownprivilege%
::“更改时区”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeTimeZonePrivilege" ')  do  set SeTimeZonePrivilege=%%j
echo SeTimeZonePrivilege%SeTimeZonePrivilege%
::“更改系统时间”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeSystemtimePrivilege" ')  do  set SeSystemtimePrivilege=%%j
echo SeSystemtimePrivilege%SeSystemtimePrivilege%
::“关闭系统”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeShutdownPrivilege" ')  do  set SeShutdownPrivilege=%%j
echo SeShutdownPrivilege%SeShutdownPrivilege%
::“管理审核和安全日志”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeSecurityPrivilege" ')  do  set SeSecurityPrivilege=%%j
echo SeSecurityPrivilege%SeSecurityPrivilege%
::“还原文件和目录”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeRestorePrivilege" ')  do  set SeRestorePrivilege=%%j
echo SeRestorePrivilege%SeRestorePrivilege%
::“加载和卸载设备驱动程序”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeLoadDriverPrivilege" ')  do  set SeLoadDriverPrivilege=%%j
echo SeLoadDriverPrivilege%SeLoadDriverPrivilege%
::把工作站添加到域
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeMachineAccountPrivilege" ')  do  set SeMachineAccountPrivilege=%%j
echo SeMachineAccountPrivilege%SeMachineAccountPrivilege%
::“拒绝本地登录”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeDenyInteractiveLogonRight" ')  do  set SeDenyInteractiveLogonRight=%%j
echo SeDenyInteractiveLogonRight%SeDenyInteractiveLogonRight%
::“拒绝从网络访问这台计算机”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeDenyNetworkLogonRight" ')  do  set SeDenyNetworkLogonRight=%%j
echo SeDenyNetworkLogonRight%SeDenyNetworkLogonRight%
::“拒绝通过远程桌面服务登录”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeDenyRemoteInteractiveLogonRight" ')  do  set SeDenyRemoteInteractiveLogonRight=%%j
echo SeDenyRemoteInteractiveLogonRight%SeDenyRemoteInteractiveLogonRight%
::“拒绝以服务身份登录”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeDenyServiceLogonRight" ')  do  set SeDenyServiceLogonRight=%%j
echo SeDenyServiceLogonRight%SeDenyServiceLogonRight%
::“拒绝作为批处理作业登录”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeDenyBatchLogonRight" ')  do  set SeDenyBatchLogonRight=%%j
echo SeDenyBatchLogonRight%SeDenyBatchLogonRight%
::“配置文件单个进程”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeProfileSingleProcessPrivilege" ')  do  set SeProfileSingleProcessPrivilege=%%j
echo SeProfileSingleProcessPrivilege%SeProfileSingleProcessPrivilege%
::“配置文件系统性能”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeSystemProfilePrivilege" ')  do  set SeSystemProfilePrivilege=%%j
echo SeSystemProfilePrivilege%SeSystemProfilePrivilege%
::“取得文件或其他对象的所有权”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeTakeOwnershipPrivilege" ')  do  set SeTakeOwnershipPrivilege=%%j
echo SeTakeOwnershipPrivilege%SeTakeOwnershipPrivilege%
::绕过遍历检查
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeChangeNotifyPrivilege" ')  do  set SeChangeNotifyPrivilege=%%j
echo SeChangeNotifyPrivilege%SeChangeNotifyPrivilege%
::“身份验证后模拟客户端”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeImpersonatePrivilege" ')  do  set SeImpersonatePrivilege=%%j
echo SeImpersonatePrivilege%SeImpersonatePrivilege%
::“生成安全审核”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeAuditPrivilege" ')  do  set SeAuditPrivilege=%%j
echo SeAuditPrivilege%SeAuditPrivilege%
::“锁定内存页”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeLockMemoryPrivilege" ')  do  set SeLockMemoryPrivilege=%%j
echo SeLockMemoryPrivilege%SeLockMemoryPrivilege%
::“提高计划优先级”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeIncreaseBasePriorityPrivilege" ')  do  set SeIncreaseBasePriorityPrivilege=%%j
echo SeIncreaseBasePriorityPrivilege%SeIncreaseBasePriorityPrivilege%
::“替换一个进程级令牌”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeAssignPrimaryTokenPrivilege" ')  do  set SeAssignPrimaryTokenPrivilege=%%j
echo SeAssignPrimaryTokenPrivilege%SeAssignPrimaryTokenPrivilege%
::“调试程序”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeDebugPrivilege" ')  do  set SeDebugPrivilege=%%j
echo SeDebugPrivilege%SeDebugPrivilege%
::“同步目录服务数据”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeSyncAgentPrivilege" ')  do  set SeSyncAgentPrivilege=%%j
echo SeSyncAgentPrivilege%SeSyncAgentPrivilege%
::“为进程调整内存配额”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeIncreaseQuotaPrivilege" ')  do  set SeIncreaseQuotaPrivilege=%%j
echo SeIncreaseQuotaPrivilege%SeIncreaseQuotaPrivilege%
::“信任计算机和用户帐户可以执行委派”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeEnableDelegationPrivilege" ')  do  set SeEnableDelegationPrivilege=%%j
echo SeEnableDelegationPrivilege%SeEnableDelegationPrivilege%
::“修改固件环境值”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeSystemEnvironmentPrivilege" ')  do  set SeSystemEnvironmentPrivilege=%%j
echo SeSystemEnvironmentPrivilege%SeSystemEnvironmentPrivilege%
::“修改一个对象标签”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeRelabelPrivilege" ')  do  set SeRelabelPrivilege=%%j
echo SeRelabelPrivilege%SeRelabelPrivilege%
::“以操作系统方式执行”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeTcbPrivilege" ')  do  set SeTcbPrivilege=%%j
echo SeTcbPrivilege%SeTcbPrivilege%
::“允许本地登录”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeInteractiveLogonRight" ')  do  set SeInteractiveLogonRight=%%j
echo SeInteractiveLogonRight%SeInteractiveLogonRight%
::“允许通过远程桌面服务登录”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeRemoteInteractiveLogonRight" ')  do  set SeRemoteInteractiveLogonRight=%%j
echo SeRemoteInteractiveLogonRight%SeRemoteInteractiveLogonRight%
::增加进程工作集
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeIncreaseWorkingSetPrivilege" ')  do  set SeIncreaseWorkingSetPrivilege=%%j
echo SeIncreaseWorkingSetPrivilege%SeIncreaseWorkingSetPrivilege%
::“执行卷维护任务”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeManageVolumePrivilege" ')  do  set SeManageVolumePrivilege=%%j
echo SeManageVolumePrivilege%SeManageVolumePrivilege%
::作为服务登录
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeServiceLogonRight" ')  do  set SeServiceLogonRight=%%j
echo SeServiceLogonRight%SeServiceLogonRight%
::“作为批处理作业登录”权限配置(仅限域控制器)
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeBatchLogonRight" ')  do  set SeBatchLogonRight=%%j
echo SeBatchLogonRight%SeBatchLogonRight%
::“作为受信任的呼叫方访问凭据管理器”权限配置
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "SeTrustedCredManAccessPrivilege" ')  do  set SeTrustedCredManAccessPrivilege=%%j
echo SeTrustedCredManAccessPrivilege%SeTrustedCredManAccessPrivilege%

::帐户：使用空密码的本地帐户只允许进行控制台登录
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "LimitBlankPasswordUse" ') do set LimitBlankPasswordUse=%%k
echo LimitBlankPasswordUse %LimitBlankPasswordUse%

::帐户：阻止Microsoft帐户
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "NoConnectedUser" ') do set NoConnectedUser=%%k
echo NoConnectedUser %NoConnectedUser%

::审核: 对备份和还原权限的使用进行审核
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "fullprivilegeauditing" ') do set FullPrivilegeAuditing=%%k
echo fullprivilegeauditing %FullPrivilegeAuditing%

::审核: 对全局系统对象的访问权限进行审核
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "AuditBaseObjects" ') do set AuditBaseObjects=%%k
echo AuditBaseObjects %AuditBaseObjects%

::审核: 如果无法记录安全审核则立即关闭系统
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "crashonauditfail" ') do set CrashOnAuditFail=%%k
echo crashonauditfail %CrashOnAuditFail%

::设备: 将 CD-ROM 的访问权限仅限于本地登录的用户
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"^|findstr /i "AllocateCDRoms" ') do set AllocateCDRoms=%%k
echo AllocateCDRoms %AllocateCDRoms%

::设备: 将软盘的访问权限仅限于本地登录的用户
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"^|findstr /i "AllocateFloppies" ') do set AllocateFloppies=%%k
echo AllocateFloppies %AllocateFloppies%

::设备: 允许在未登录的情况下移除
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "UndockWithoutLogon" ') do set UndockWithoutLogon=%%k
echo UndockWithoutLogon %UndockWithoutLogon%

::域控制器: 允许服务器操作者计划任务
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "ubmitControl" ') do set ubmitControl=%%k
echo ubmitControl %ubmitControl%

::域控制器: LDAP 服务器签名要求
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters"^|findstr /i "LDAPServerIntegrity" ') do set LDAPServerIntegrity=%%k
echo LDAPServerIntegrity %LDAPServerIntegrity%

::域控制器: 拒绝计算机帐户密码更改
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "RefusePasswordChange" ') do set RefusePasswordChange=%%k
echo RefusePasswordChange %RefusePasswordChange%

::对安全通道数据进行数字加密或数字签名
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "RequireSignOrSeal" ') do set RequireSignOrSeal=%%k
echo RequireSignOrSeal %RequireSignOrSeal%

::域成员: 对安全通道数据进行数字加密(如果可能)
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "ealSecureChannel" ') do set ealSecureChannel=%%k
echo ealSecureChannel %ealSecureChannel%

::域成员: 对安全通道数据进行数字签名(如果可能)
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "ignSecureChannel" ') do set ignSecureChannel=%%k
echo ignSecureChannel %ignSecureChannel%

::域成员：计算机帐户密码最长使用期限
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "MaximumPasswordAge" ') do set MaximumPasswordAge=%%k
echo MaximumPasswordAge %MaximumPasswordAge%

::域成员: 需要使用强会话密钥(Windows 2000 或更高版本)
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "RequireStrongKey" ') do set RequireStrongKey=%%k
echo RequireStrongKey %RequireStrongKey%

::域成员: 禁用计算机帐户密码更改
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "DisablePasswordChange" ') do set DisablePasswordChange=%%k
echo DisablePasswordChange %DisablePasswordChange%

::交互式登录: 不显示上次登录
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr  /i "DontDisplayLastUserName" ') do set DontDisplayLastUserName=%%k
echo DontDisplayLastUserName %DontDisplayLastUserName%

::交互式登录: 需要域控制器身份验证以对工作站进行解锁
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"^|findstr /i "ForceUnlockLogon" ') do set ForceUnlockLogon=%%k
echo ForceUnlockLogon %ForceUnlockLogon%

::交互式登录：之前登录到缓存的次数（域控制器不可用时）
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"^|findstr /i "CachedLogonsCount" ') do set CachedLogonsCount=%%k
echo CachedLogonsCount %CachedLogonsCount%

::Microsoft 网络客户端：对通信进行数字签名(始终)
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters"^|findstr /i "RequireSecuritySignature" ') do set RequireSecuritySignature=%%k
echo RequireSecuritySignature %RequireSecuritySignature%

::Microsoft 网络客户端：对通信进行数字签名(如果服务器允许)
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters"^|findstr /i "EnableSecuritySignature" ') do set EnableSecuritySignature=%%k
echo EnableSecuritySignature %EnableSecuritySignature%

::Microsoft 网络客户端: 不允许将未加密的密码发送到第三方 SMB 服务器
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanmanWorkstation\Parameters"^|findstr /i "EnablePlainTextPassword" ') do set EnablePlainTextPassword=%%k
echo EnablePlainTextPassword %EnablePlainTextPassword%

::Microsoft 网络服务器：对通信进行数字签名(始终)
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "RequireSecuritySignature" ') do set RequireSecuritySignature=%%k
echo RequireSecuritySignature %RequireSecuritySignature%

::Microsoft 网络服务器：对通信进行数字签名(如果客户端允许)
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "EnableSecuritySignature" ') do set EnableSecuritySignature=%%k
echo EnableSecuritySignature %EnableSecuritySignature%

::Microsoft 网络服务器: 服务器 SPN 目标名称验证级别
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "SmbServerNameHardeningLevel" ') do set SmbServerNameHardeningLevel=%%k
echo SmbServerNameHardeningLevel %SmbServerNameHardeningLevel%

::Microsoft 网络服务器: 暂停会话前所需的空闲时间量
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "AutoDisconnect" ') do set AutoDisconnect=%%k
echo AutoDisconnect %AutoDisconnect%

::Microsoft 网络服务器: 尝试使用 S4U2Self 获取声明信息
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "EnableS4U2SelfForClaims" ') do set EnableS4U2SelfForClaims=%%k
echo EnableS4U2SelfForClaims %EnableS4U2SelfForClaims%

::Microsoft 网络服务器: 登录时间过期后断开与客户端的连接
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "EnableForcedLogOff" ') do set EnableForcedLogOff=%%k
echo EnableForcedLogOff %EnableForcedLogOff%

::网络访问: 本地帐户的共享和安全模型
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "ForceGuest" ') do set ForceGuest=%%k
echo ForceGuest %ForceGuest%

::网络访问: 不允许 SAM 帐户的匿名枚举
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "RestrictAnonymousSAM" ') do set RestrictAnonymousSAM=%%k
echo RestrictAnonymousSAM %RestrictAnonymousSAM%

::网络访问: 不允许 SAM 帐户和共享的匿名枚举
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "RestrictAnonymous" ') do set RestrictAnonymous=%%k
echo RestrictAnonymous %RestrictAnonymous%

::网络访问: 不允许存储网络身份验证的密码和凭据
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "DisableDomainCreds" ') do set DisableDomainCreds=%%k
echo DisableDomainCreds %DisableDomainCreds%

::网络访问: 将 Everyone 权限应用于匿名用户
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "EveryoneIncludesAnonymous" ') do set EveryoneIncludesAnonymous=%%k
echo EveryoneIncludesAnonymous %EveryoneIncludesAnonymous%

::网络访问: 可匿名访问的共享
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "NullSessionShares" ') do set NullSessionPipes=%%k
echo NullSessionShares %NullSessionPipes%

::网络访问: 可匿名访问的命名管道
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "NullSessionPipes" ') do set NullSessionShares=%%k
echo NullSessionPipes %NullSessionShares%

::网络访问: 可远程访问的注册表路径
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedExactPaths"^|findstr /i "Machine" ') do set Machine=%%k
echo Machine %Machine%

::网络访问: 可远程访问的注册表路径和子路径
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\SecurePipeServers\Winreg\AllowedPaths"^|findstr /i "Machine" ') do set Machine=%%k
echo Machine %Machine%

::网络访问: 限制对命名管道和共享的匿名访问
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LanManServer\Parameters"^|findstr /i "RestrictNullSessAccess" ') do set RestrictNullSessAccess=%%k
echo RestrictNullSessAccess %RestrictNullSessAccess%

::网络访问: 允许匿名 SID/名称转换
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "LSAAnonymousNameLookup" ')  do  set LSAAnonymousNameLookup=%%j
echo LSAAnonymousNameLookup%LSAAnonymousNameLookup%

::网络安全: LAN 管理器身份验证级别
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "LmCompatibilityLevel" ') do set LmCompatibilityLevel=%%k
echo LmCompatibilityLevel %LmCompatibilityLevel%

::网络安全: LDAP 客户端签名要求
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\LDAP"^|findstr /i "LDAPClientIntegrity" ') do set LDAPClientIntegrity=%%k
echo LDAPClientIntegrity %LDAPClientIntegrity%

::网络安全: 基于 NTLM SSP 的(包括安全 RPC)服务器的最小会话安全
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0"^|findstr /i "NTLMMinServerSec" ') do set NTLMMinServerSec=%%k
echo NTLMMinServerSec %NTLMMinServerSec%

::网络安全: 基于 NTLM SSP 的(包括安全 RPC)客户端的最小会话安全
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0"^|findstr /i "NTLMMinClientSec" ') do set NTLMMinClientSec=%%k
echo NTLMMinClientSec %NTLMMinClientSec%

::网络安全: 配置 Kerberos 允许的加密类型
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"^|findstr /i "SupportedEncryptionTypes" ') do set SupportedEncryptionTypes=%%k
echo SupportedEncryptionTypes %SupportedEncryptionTypes%

::网络安全: 限制 NTLM: 传入 NTLM 流量
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0"^|findstr /i "RestrictReceivingNTLMTraffic" ') do set RestrictReceivingNTLMTraffic=%%k
echo RestrictReceivingNTLMTraffic %RestrictReceivingNTLMTraffic%


::网络安全: 限制 NTLM: 此域中的 NTLM 身份验证
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "RestrictNTLMInDomain" ') do set RestrictNTLMInDomain=%%k
echo RestrictNTLMInDomain %RestrictNTLMInDomain%


::网络安全: 限制 NTLM: 到远程服务器的传出 NTLM 流量
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0"^|findstr /i "RestrictSendingNTLMTraffic" ') do set RestrictSendingNTLMTraffic=%%k
echo RestrictSendingNTLMTraffic %RestrictSendingNTLMTraffic%


::网络安全: 限制 NTLM: 审核传入 NTLM 流量
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0"^|findstr /i "AuditReceivingNTLMTraffic" ') do set AuditReceivingNTLMTraffic=%%k
echo AuditReceivingNTLMTraffic %AuditReceivingNTLMTraffic%


::网络安全: 限制 NTLM: 审核此域中的 NTLM 身份验证
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "AuditNTLMInDomain" ') do set AuditNTLMInDomain=%%k
echo AuditNTLMInDomain %AuditNTLMInDomain%


::网络安全: 限制 NTLM: 添加此域中的服务器例外
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netlogon\Parameters"^|findstr /i "DCAllowedNTLMServers" ') do set DCAllowedNTLMServers=%%k
echo DCAllowedNTLMServers %DCAllowedNTLMServers%


::网络安全: 限制 NTLM: 为 NTLM 身份验证添加远程服务器例外
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0"^|findstr /i "ClientAllowedNTLMServers" ') do set ClientAllowedNTLMServers=%%k
echo ClientAllowedNTLMServers %ClientAllowedNTLMServers%


::网络安全: 允许 LocalSystem NULL 会话回退
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\MSV1_0"^|findstr /i "allownullsessionfallback" ') do set allownullsessionfallback=%%k
echo allownullsessionfallback %allownullsessionfallback%


::网络安全: 允许本地系统将计算机标识用于 NTLM
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "UseMachineId" ') do set UseMachineId=%%k
echo UseMachineId %UseMachineId%


::网络安全: 允许对此计算机的 PKU2U 身份验证请求使用联机标识
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa\pku2u"^|findstr /i "AllowOnlineID" ') do set AllowOnlineID=%%k
echo AllowOnlineID %AllowOnlineID%

::网络安全: 在超过登录时间后强制注销
for /f  "tokens=1,2 delims==" %%i in ('type secbak.inf ^|findstr /i "ForceLogoffWhenHourExpire" ')  do  set ForceLogoffWhenHourExpire=%%j
echo ForceLogoffWhenHourExpire%ForceLogoffWhenHourExpire%

::网络安全: 在下一次更改密码时不存储 LAN 管理器哈希值
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Lsa"^|findstr /i "NoLMHash" ') do set NoLMHash=%%k
echo NoLMHash %NoLMHash%

::关机: 清除虚拟内存页面文件
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management"^|findstr /i "ClearPageFileAtShutdown" ') do set ClearPageFileAtShutdown=%%k
echo ClearPageFileAtShutdown %ClearPageFileAtShutdown%

::用户帐户控制: 标准用户的提升提示行为
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "ConsentPromptBehaviorUser" ') do set ConsentPromptBehaviorUser=%%k
echo ConsentPromptBehaviorUser %ConsentPromptBehaviorUser%

::用户帐户控制: 管理员批准模式中管理员的提升权限提示的行为
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "ConsentPromptBehaviorAdmin" ') do set ConsentPromptBehaviorAdmin=%%k
echo ConsentPromptBehaviorAdmin %ConsentPromptBehaviorAdmin%

::用户帐户控制: 检测应用程序安装并提示提升
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "EnableInstallerDetection" ') do set EnableInstallerDetection=%%k
echo EnableInstallerDetection %EnableInstallerDetection%

::用户帐户控制: 将文件及注册表写入错误虚拟化到每用户位置
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "EnableVirtualization" ') do set EnableVirtualization=%%k
echo MaximumPasswordAge %EnableVirtualization%

::用户帐户控制: 仅提升安装在安全位置的 UIAccess 应用程序
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "EnableSecureUIAPaths" ') do set EnableSecureUIAPaths=%%k
echo EnableSecureUIAPaths %EnableSecureUIAPaths%

::用户帐户控制: 提示提升时切换到安全桌面
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "PromptOnSecureDesktop" ') do set PromptOnSecureDesktop=%%k
echo PromptOnSecureDesktop %PromptOnSecureDesktop%

::用户帐户控制: 以管理员批准模式运行所有管理员
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "EnableLUA" ') do set EnableLUA=%%k
echo EnableLUA %EnableLUA%

::用户帐户控制: 用于内置管理员帐户的管理员批准模式
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "FilterAdministratorToken" ') do set FilterAdministratorToken=%%k
echo FilterAdministratorToken %FilterAdministratorToken%

::用户帐户控制: 允许 UIAccess 应用程序在不使用安全桌面的情况下提升权限
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "EnableUIADesktopToggle" ') do set EnableUIADesktopToggle=%%k
echo EnableUIADesktopToggle %EnableUIADesktopToggle%

::用户帐户控制: 只提升签名并验证的可执行文件
for /f "tokens=1,2,3,4,*" %%i in ('reg query "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System"^|findstr /i "ValidateAdminCodeSignatures" ') do set ValidateAdminCodeSignatures=%%k
echo ValidateAdminCodeSignatures %ValidateAdminCodeSignatures%

del secbak.inf>nul