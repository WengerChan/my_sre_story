@echo off 
Setlocal enabledelayedexpansion 

::Canway Technology Co.,Ltd

::本地策略 -> 安全选项: 
::  MSS: 禁用自动登录
::  MSS: 禁用IPv6源路由
::  MSS: 禁用IPv4源路由
::  MSS: 禁用ICMP重定向
::  MSS: KeepAliveTime配置
::  MSS: 忽略NetBIOS的名称发布请求
::  MSS: 允许IRDP检测和配置默认网关地址
::  MSS: 启用安全DLL搜索模式
::  MSS: 屏幕保护程序宽限期
::  MSS: IPv6 TCP未被确认数据重传次数
::  MSS: IPv4 TCP未被确认数据重传次数
::  MSS: IPv4 告警事件在安全日志最高占比配置

::说明
::  如果注册表键值没有，则说明未设置该项，此时输出值 null


:AutoAdminLogon
  set RegistryPath01=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon
  set Valuename01=AutoAdminLogon
  reg query "%RegistryPath01%" /v "%Valuename01%" >nul 2>nul && goto :AA01 || goto :BB01
:AA01
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath01%" ^| findstr "%Valuename01%"') do (echo AutoAdminLogon %%k)
  goto :end01
:BB01
  echo AutoAdminLogon null
  goto :end01
:end01

:DisableIPSourceRouting6
  set RegistryPath02=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip6\Parameters
  set Valuename02=DisableIPSourceRouting
  reg query "%RegistryPath02%" /v "%Valuename02%" >nul 2>nul && goto :AA02 || goto :BB02
:AA02
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath02%" ^| findstr "%Valuename02%"') do (echo DisableIPSourceRouting6 %%k)
  goto :end02
:BB02
  echo DisableIPSourceRouting6 null
  goto :end02
:end02

:DisableIPSourceRouting4
  set RegistryPath03=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters
  set Valuename03=DisableIPSourceRouting
  reg query "%RegistryPath03%" /v "%Valuename03%" >nul 2>nul && goto :AA03 || goto :BB03
:AA03
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath03%" ^| findstr "%Valuename03%"') do (echo DisableIPSourceRouting4 %%k)
  goto :end03
:BB03
  echo DisableIPSourceRouting4 null
  goto :end03
:end03

:EnableICMPRedirect
  set RegistryPath04=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters
  set Valuename04=EnableICMPRedirect
  reg query "%RegistryPath04%" /v "%Valuename04%" >nul 2>nul && goto :AA04 || goto :BB04
:AA04
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath04%" ^| findstr "%Valuename04%"') do (echo EnableICMPRedirect %%k)
  goto :end04
:BB04
  echo EnableICMPRedirect null
  goto :end04
:end04

:KeepAliveTime
  set RegistryPath05=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters
  set Valuename05=KeepAliveTime
  reg query "%RegistryPath05%" /v "%Valuename05%" >nul 2>nul && goto :AA05 || goto :BB05
:AA05
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath05%" ^| findstr "%Valuename05%"') do (echo KeepAliveTime %%k)
  goto :end05
:BB05
  echo KeepAliveTime null
  goto :end04
:end04

:NoNameReleaseOnDemand
  set RegistryPath06=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Netbt\Parameters
  set Valuename06=NoNameReleaseOnDemand
  reg query "%RegistryPath06%" /v "%Valuename06%" >nul 2>nul && goto :AA06 || goto :BB06
:AA06
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath06%" ^| findstr "%Valuename06%"') do (echo NoNameReleaseOnDemand %%k)
  goto :end06
:BB06
  echo NoNameReleaseOnDemand null
  goto :end06
:end06

:PerformRouterDiscovery
  set RegistryPath07=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters
  set Valuename07=PerformRouterDiscovery
  reg query "%RegistryPath07%" /v "%Valuename07%" >nul 2>nul && goto :AA07 || goto :BB07
:AA07
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath07%" ^| findstr "%Valuename07%"') do (echo PerformRouterDiscovery %%k)
  goto :end07
:BB07
  echo PerformRouterDiscovery null
  goto :end07
:end07

:SafeDllSearchMode
  set RegistryPath08=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager
  set Valuename08=SafeDllSearchMode
  reg query "%RegistryPath08%" /v "%Valuename08%" >nul 2>nul && goto :AA08 || goto :BB08
:AA08
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath08%" ^| findstr "%Valuename08%"') do (echo SafeDllSearchMode %%k)
  goto :end08
:BB08
  echo SafeDllSearchMode null
  goto :end08
:end08

:ScreenSaverGracePeriod
  set RegistryPath09=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon
  set Valuename09=ScreenSaverGracePeriod
  reg query "%RegistryPath09%" /v "%Valuename09%" >nul 2>nul && goto :AA09 || goto :BB09
:AA09
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath09%" ^| findstr "%RegistryPath09%"') do (echo ScreenSaverGracePeriod %%k)
  goto :end09
:BB09
  echo ScreenSaverGracePeriod null
  goto :end09
:end09

:TcpMaxDataRetransmissions6
  set RegistryPath10=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip6\Parameters
  set Valuename10=TcpMaxDataRetransmissions
  reg query "%RegistryPath10%" /v "%Valuename10%" >nul 2>nul && goto :AA10 || goto :BB10
:AA10
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath10%" ^| findstr "%Valuename10%"') do (echo TcpMaxDataRetransmissions6 %%k)
  goto :end10
:BB10
  echo TcpMaxDataRetransmissions6 null
  goto :end10
:end10

:TcpMaxDataRetransmissions4
  set RegistryPath11=HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters
  set Valuename11=TcpMaxDataRetransmissions
  reg query "%RegistryPath11%" /v "%Valuename11%" >nul 2>nul && goto :AA11 || goto :BB11
:AA11
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath11%" ^| findstr "%Valuename11%"') do (echo TcpMaxDataRetransmissions4 %%k)
  goto :end11
:BB11
  echo TcpMaxDataRetransmissions4 null
  goto :end11
:end11

:WarningLevel
  set RegistryPath12=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Security
  set Valuename12=WarningLevel
  reg query "%RegistryPath12%" /v "%Valuename12%" >nul 2>nul && goto :AA12 || goto :BB12
:AA12
  for /f "tokens=1,2,3,*" %%i in ('reg query "%RegistryPath12%" ^| findstr "%Valuename12%"') do (echo WarningLevel %%k)
  goto :end12
:BB12
  echo WarningLevel null
  goto :end12
:end12


pause