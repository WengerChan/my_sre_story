@echo off
Setlocal enabledelayedexpansion 

::Canway Technology Co.,Ltd

:DomainFirewall
::Windows防火墙域配置：防火墙状态
::Windows防火墙域配置：入站连接:【允许:0x0|阻止:0x1|阻止所有连接: 此时键值依旧为0x1，为了准确表示，人为定义为0x2】
::Windows防火墙域配置：出站连接:【允许:0x0|阻止:0x1】
::Windows防火墙域配置：设置：显示通知
::Windows防火墙域配置：日志：名称
::Windows防火墙域配置：日志：大小限制
::Windows防火墙域配置：日志：记录被丢弃的数据包
::Windows防火墙域配置：日志：记录成功的连接
::Windows防火墙域配置：设置：应用本地防火墙规则
::Windows防火墙域配置：设置：应用本地连接安全规则

:DomainFirewallEnableFirewall
  set RegistryPath11=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile
  set Valuename11=EnableFirewall
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath11%" ^| findstr "%Valuename11%"') do (echo DomainFirewall%%i %%k)

:DomainFirewallDefaultInboundAction
  set RegistryPath12=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile
  set Valuename12=DefaultInboundAction
  reg query "%RegistryPath12%" /v "%Valuename12%" >nul 2>nul && goto :AA12 || goto :BB12
:AA12
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath12%" ^| findstr "%Valuename12%"') do (set DomainFirewallDefaultInboundAction=%%k)
  req query "%RegistryPath12%" /v DoNotAllowExceptions >nul 2>nul && set DomainFirewallDefaultInboundAction=0x2
  echo DomainFirewallDefaultInboundAction %DomainFirewallDefaultInboundAction%
  goto :end12
:BB12
  echo DomainFirewallDefaultInboundAction 0x1
  goto :end12
:end12

:DomainFirewallDefaultOutboundAction
  set RegistryPath13=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile
  set Valuename13=DefaultOutboundAction
  reg query "%RegistryPath13%" /v "%Valuename13%" >nul 2>nul && goto :AA13 || goto :BB13
:AA13
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath13%" ^| findstr "%Valuename13%"') do (echo DomainFirewall%%i %%k)
  goto :end13
:BB13
  echo DomainFirewallDefaultOutboundAction 0x0
  goto :end13
:end13

:DomainFirewallDisableNotifications
  set RegistryPath14=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile
  set Valuename14=DisableNotifications
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath14%" ^| findstr "%Valuename14%"') do (echo DomainFirewall%%i %%k)

:DomainFirewallLogFilePath
  set RegistryPath15=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile\Logging
  set Valuename15=LogFilePath
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath15%" ^| findstr "%Valuename15%"') do (echo DomainFirewall%%i %%k)

:DomainFirewallLogFileSize
  set RegistryPath16=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile\Logging
  set Valuename16=LogFileSize
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath16%" ^| findstr "%Valuename16%"') do (echo DomainFirewall%%i %%k)

:DomainFirewallLogDroppedPackets
  set RegistryPath17=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile\Logging
  set Valuename17=LogDroppedPackets
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath17%" ^| findstr "%Valuename17%"') do (echo DomainFirewall%%i %%k)

:DomainFirewallLogSuccessfulConnections
  set RegistryPath18=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile\Logging
  set Valuename18=LogSuccessfulConnections
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath18%" ^| findstr "%Valuename18%"') do (echo DomainFirewall%%i %%k)

::应用本地防火墙规则
:DomainFirewallAllowLocalPolicyMerge
  set RegistryPath19=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile
  set Valuename19=AllowLocalPolicyMerge
  reg query "%RegistryPath19%" /v "%Valuename19%" >nul 2>nul && goto :AA19 || goto :BB19
:AA19
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath19%" ^| findstr "%Valuename19%"') do (set DomainFirewallAllowLocalPolicyMerge=%%k)
  echo DomainFirewallAllowLocalPolicyMerge %DomainFirewallAllowLocalPolicyMerge%
  goto :end19
:BB19
  echo DomainFirewallAllowLocalPolicyMerge 0x1
  goto :end19
:end19

::应用本地连接安全规则
:DomainFirewallAllowLocalIPsecPolicyMerge
  set RegistryPath110=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\DomainProfile
  set Valuename110=AllowLocalIPsecPolicyMerge
  reg query "%RegistryPath110%" /v "%Valuename110%" >nul 2>nul && goto :AA110 || goto :BB110
:AA110
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath110%" ^| findstr "%RegistryPath110%"') do (set DomainFirewallAllowLocalIPsecPolicyMerge=%%k)
  echo DomainFirewallAllowLocalIPsecPolicyMerge %DomainFirewallAllowLocalIPsecPolicyMerge%
  goto :end110
:BB110
  echo DomainFirewallAllowLocalIPsecPolicyMerge 0x1
  goto :end110
:end110

:PrivateFirewall
::Windows防火墙专用配置：防火墙状态
::Windows防火墙专用配置：入站连接:【允许:0x0|阻止:0x1|阻止所有连接: 此时键值依旧为0x1，为了准确表示，人为定义为0x2】
::Windows防火墙专用配置：出站连接:【允许:0x0|阻止:0x1】
::Windows防火墙专用配置：设置：显示通知
::Windows防火墙专用配置：日志：名称
::Windows防火墙专用配置：日志：大小限制
::Windows防火墙专用配置：日志：记录被丢弃的数据包
::Windows防火墙专用配置：日志：记录成功的连接
::Windows防火墙专用配置：设置：应用本地防火墙规则
::Windows防火墙专用配置：设置：应用本地连接安全规则

:PrivateFirewallEnableFirewall
  set RegistryPath21=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile
  set Valuename21=EnableFirewall
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath21%" ^| findstr "%Valuename21%"') do (echo PrivateFirewall%%i %%k)

:PrivateFirewallDefaultInboundAction
  set RegistryPath22=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile
  set Valuename22=DefaultInboundAction
  reg query "%RegistryPath22%" /v "%Valuename22%" >nul 2>nul && goto :AA22 || goto :BB22
:AA22
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath22%" ^| findstr "%Valuename22%"') do (set PrivateFirewallDefaultInboundAction=%%k)
  req query "%RegistryPath22%" /v DoNotAllowExceptions >nul 2>nul && set PrivateFirewallDefaultInboundAction=0x2
  echo PrivateFirewallDefaultInboundAction %PrivateFirewallDefaultInboundAction%
  goto :end22
:BB22
  echo PrivateFirewallDefaultInboundAction 0x1
  goto :end22
:end22

:PrivateFirewallDefaultOutboundAction
  set RegistryPath23=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile
  set Valuename23=DefaultOutboundAction
  reg query "%RegistryPath23%" /v "%Valuename23%" >nul 2>nul && goto :AA23 || goto :BB23
:AA23
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath23%" ^| findstr "%Valuename23%"') do (echo PrivateFirewall%%i %%k)
  goto :end23
:BB23
  echo PrivateFirewallDefaultOutboundAction 0x0
  goto :end23
:end23

:PrivateFirewallDisableNotifications
  set RegistryPath24=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile
  set Valuename24=DisableNotifications
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath24%" ^| findstr "%Valuename24%"') do (echo PrivateFirewall%%i %%k)

:PrivateFirewallLogFilePath
  set RegistryPath25=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\Logging
  set Valuename25=LogFilePath
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath25%" ^| findstr "%Valuename25%"') do (echo PrivateFirewall%%i %%k)

:PrivateFirewallLogFileSize
  set RegistryPath26=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\Logging
  set Valuename26=LogFileSize
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath26%" ^| findstr "%Valuename26%"') do (echo PrivateFirewall%%i %%k)

:PrivateFirewallLogDroppedPackets
  set RegistryPath27=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\Logging
  set Valuename27=LogDroppedPackets
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath27%" ^| findstr "%Valuename27%"') do (echo PrivateFirewall%%i %%k)

:PrivateFirewallLogSuccessfulConnections
  set RegistryPath28=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\Logging
  set Valuename28=LogSuccessfulConnections
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath28%" ^| findstr "%Valuename28%"') do (echo PrivateFirewall%%i %%k)

::应用本地防火墙规则
:PrivateFirewallAllowLocalPolicyMerge
  set RegistryPath29=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile
  set Valuename29=AllowLocalPolicyMerge
  reg query "%RegistryPath29%" /v "%Valuename29%" >nul 2>nul && goto :AA29 || goto :BB29
:AA29
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath29%" ^| findstr "%Valuename29%"') do (set PrivateFirewallAllowLocalPolicyMerge=%%k)
  echo PrivateFirewallAllowLocalPolicyMerge %PrivateFirewallAllowLocalPolicyMerge%
  goto :end29
:BB29
  echo PrivateFirewallAllowLocalPolicyMerge 0x1
  goto :end29
:end29

::应用本地连接安全规则
:PrivateFirewalAllowLocalIPsecPolicyMerge
  set RegistryPath210=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PrivateProfile
  set Valuename210=AllowLocalIPsecPolicyMerge
  reg query "%RegistryPath210%" /v "%Valuename210%" >nul 2>nul && goto :AA210 || goto :BB210
:AA210
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath210%" ^| findstr "%Valuename210%"') do (set PrivateFirewalAllowLocalIPsecPolicyMerge=%%k)
  echo PrivateFirewalAllowLocalIPsecPolicyMerge %PrivateFirewalAllowLocalIPsecPolicyMerge%
  goto :end210
:BB210
  echo PrivateFirewalAllowLocalIPsecPolicyMerge 0x1
  goto :end210
:end210

:PublicFirewall
::Windows防火墙公用配置：防火墙状态
::Windows防火墙公用配置：入站连接:【允许:0x0|阻止:0x1|阻止所有连接: 此时键值依旧为0x1，为了准确表示，人为定义为0x2】
::Windows防火墙公用配置：出站连接:【允许:0x0|阻止:0x1】
::Windows防火墙公用配置：设置：显示通知
::Windows防火墙公用配置：日志：名称
::Windows防火墙公用配置：日志：大小限制
::Windows防火墙公用配置：日志：记录被丢弃的数据包
::Windows防火墙公用配置：日志：记录成功的连接
::Windows防火墙公用配置：设置：应用本地防火墙规则
::Windows防火墙公用配置：设置：应用本地连接安全规则

:PublicFirewallEnableFirewall
  set RegistryPath31=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile
  set Valuename31=EnableFirewall
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath31%" ^| findstr "%Valuename31%"') do (echo PublicFirewall%%i %%k)

:PublicFirewallDefaultInboundAction
  set RegistryPath32=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile
  set Valuename32=DefaultInboundAction
  reg query "%RegistryPath32%" /v "%Valuename32%" >nul 2>nul && goto :AA32 || goto :BB32
:AA32
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath32%" ^| findstr "%Valuename32%"') do (set PublicFirewallDefaultInboundAction=%%k)
  req query "%RegistryPath32%" /v DoNotAllowExceptions >nul 2>nul && set PublicFirewallDefaultInboundAction=0x2
  echo PublicFirewallDefaultInboundAction %PublicFirewallDefaultInboundAction%
  goto :end32
:BB32
  echo PublicFirewallDefaultInboundAction 0x1
  goto :end32
:end32

:PublicFirewallDefaultOutboundAction
  set RegistryPath33=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile
  set Valuename33=DefaultOutboundAction
  reg query "%RegistryPath33%" /v "%Valuename33%" >nul 2>nul && goto :AA33 || goto :BB33
:AA33
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath33%" ^| findstr "%Valuename33%"') do (echo PublicFirewall%%i %%k)
  goto :end33
:BB33
  echo PublicFirewallDefaultOutboundAction 0x0
  goto :end33
:end33

:PublicFirewallDisableNotifications
  set RegistryPath34=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile
  set Valuename34=DisableNotifications
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath34%" ^| findstr "%Valuename34%"') do (echo PublicFirewall%%i %%k)

:PublicFirewallLogFilePath
  set RegistryPath35=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile\Logging
  set Valuename35=LogFilePath
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath35%" ^| findstr "%Valuename35%"') do (echo PublicFirewall%%i %%k)

:PublicFirewallLogFileSize
  set RegistryPath36=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile\Logging
  set Valuename36=LogFileSize
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath36%" ^| findstr "%Valuename36%"') do (echo PublicFirewall%%i %%k)

:PublicFirewallLogDroppedPackets
  set RegistryPath37=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile\Logging
  set Valuename37=LogDroppedPackets
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath37%" ^| findstr "%Valuename37%"') do (echo PublicFirewall%%i %%k)

:PublicFirewallLogSuccessfulConnections
  set RegistryPath38=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile\Logging
  set Valuename38=LogSuccessfulConnections
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath38%" ^| findstr "%Valuename38%"') do (echo PublicFirewall%%i %%k)

::应用本地防火墙规则
:PublicFirewallAllowLocalPolicyMerge
  set RegistryPath39=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile
  set Valuename39=AllowLocalPolicyMerge
  reg query "%RegistryPath39%" /v "%Valuename39%" >nul 2>nul && goto :AA39 || goto :BB39
:AA39
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath39%" ^| findstr "%Valuename39%"') do (set PublicFirewallAllowLocalPolicyMerge=%%k)
  echo PublicFirewallAllowLocalPolicyMerge %PublicFirewallAllowLocalPolicyMerge%
  goto :end39
:BB39
  echo PublicFirewallAllowLocalPolicyMerge 0x1
  goto :end39
:end39

::应用本地连接安全规则
:PublicFirewallAllowLocalIPsecPolicyMerge
  set RegistryPath310=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\PublicProfile
  set Valuename310=AllowLocalIPsecPolicyMerge
  reg query "%RegistryPath310%" /v "%Valuename310%" >nul 2>nul && goto :AA310 || goto :BB310
:AA310
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath310%" ^| findstr "%RegistryPath310%"') do (set PublicFirewallAllowLocalIPsecPolicyMerge=%%k)
  echo PublicFirewallAllowLocalIPsecPolicyMerge %PublicFirewallAllowLocalIPsecPolicyMerge%
  goto :end310
:BB310
  echo PublicFirewallAllowLocalIPsecPolicyMerge 0x1
  goto :end310
:end310

pause