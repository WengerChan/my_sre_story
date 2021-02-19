::其他
@echo off

::计算机名和host名是否相同

:02
::SNMP服务不使用public作为团体字
set regpath02=HKEY_LOCAL_MACHINE\Software\Policies\SNMP\Parameters\ValidCommunities
reg query %regpath02%>nul 2>nul&&goto :AA02||goto :BB02
:AA02
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath02%"') do Set SNMP_number=%%k
  echo SNMP_number %SNMP_number%
  goto :03
:BB02
  echo SNMP_number null
  goto :03
  
:03
::防火墙设置
  goto :04
  
:04
::登录终端的操作超时锁定
set regpath04=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey04=fResetBroken
reg query %regpath04% /v %regkey04%>nul 2>nul&&goto :AA04||goto :BB04
:AA04
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath04%"^|findstr /i "\<%regkey04%\>" ') do Set fResetBroken=%%k
  echo fResetBroken %fResetBroken%
  goto :05
:BB04
  echo fResetBroken null
  goto :05
  
:05
::只允许运行带网络级身份验证的远程桌面的计算机连接
set regpath05=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey05=UserAuthentication
reg query %regpath05% /v %regkey05%>nul 2>nul&&goto :AA05||goto :BB05
:AA05
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath05%"^|findstr /i "\<%regkey05%\>" ') do Set UserAuthentication=%%k
  echo UserAuthentication %UserAuthentication%
  goto :06
:BB05
  echo UserAuthentication null
  goto :06
  
:06
::系统失败自动重新启动
set regpath06=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl
set regkey06=AutoReboot
reg query %regpath06% /v %regkey06%>nul 2>nul&&goto :AA06||goto :BB06
:AA06
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath06%"^|findstr /i "\<%regkey06%\>" ') do Set AutoReboot=%%k
  echo AutoReboot %AutoReboot%
  goto :07
:BB06
  echo AutoReboot null
  goto :07
  
:07
::系统日志要求保存时间

  goto :08
  
:08
::在恢复时需要密码保护(显示登录屏幕)
set regpath08=HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop
set regkey08=ScreenSaverIsSecure
reg query %regpath08% /v %regkey08%>nul 2>nul&&goto :AA08||goto :BB08
:AA08
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath08%"^|findstr /i "\<%regkey08%\>" ') do Set ScreenSaverIsSecure=%%k
  echo ScreenSaverIsSecure %ScreenSaverIsSecure%
  goto :09
:BB08
  echo ScreenSaverIsSecure null
  goto :09
  
:09
::屏幕保护程序等待时间
set regpath09=HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop
set regkey09=ScreenSaveTimeOut
reg query %regpath09% /v %regkey09%>nul 2>nul&&goto :AA09||goto :BB09
:AA09
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath09%"^|findstr /i "\<%regkey09%\>" ') do Set ScreenSaveTimeOut=%%k
  echo ScreenSaveTimeOut %ScreenSaveTimeOut%
  goto :10
:BB09
  echo ScreenSaveTimeOut null
  goto :10
  
:10
::启用屏幕保护
set regpath10=HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Control Panel\Desktop
set regkey10=ScreenSaveActive
reg query %regpath10% /v %regkey10%>nul 2>nul&&goto :AA10||goto :BB10
:AA10
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath10%"^|findstr /i "\<%regkey10%\>" ') do Set ScreenSaveActive=%%k
  echo ScreenSaveActive %ScreenSaveActive%
  goto :11
:BB10
  echo ScreenSaveActive null
  goto :11
  
:11
::链路层拓扑发现-禁用Mapper I/O (LLTDIO) driver
set regpath11=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LLTD
set regkey11=EnableLLTDIO
reg query %regpath11% /v %regkey11%>nul 2>nul&&goto :AA11||goto :BB11
:AA11
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath11%"^|findstr /i "\<%regkey11%\>" ') do Set EnableLLTDIO=%%k
  echo EnableLLTDIO %EnableLLTDIO%
  goto :12
:BB11
  echo EnableLLTDIO null
  goto :12
  
:12
::链路层拓扑发现-禁用Responder (RSPNDR) driver
set regpath12=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LLTD
set regkey12=EnableRspndr
reg query %regpath12% /v %regkey12%>nul 2>nul&&goto :AA12||goto :BB12
:AA12
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath12%"^|findstr /i "\<%regkey12%\>" ') do Set EnableRspndr=%%k
  echo EnableRspndr %EnableRspndr%
  goto :13
:BB12
  echo EnableRspndr null
  goto :13

:13
pause