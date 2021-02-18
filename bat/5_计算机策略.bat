::计算机策略
@echo off

::LAPS-不允许密码过期时间超过策略
set regpath01=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft Services\AdmPwd
set regkey01=PwdExpirationProtectionEnabled
reg query %regpath01% /v %regkey01%>nul 2>nul&&goto :AA01||goto :BB01
:AA01
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath01%"^|findstr /i "\<%regkey01%\>" ') do Set PwdExpirationProtectionEnabled=%%k
  echo PwdExpirationProtectionEnabled %PwdExpirationProtectionEnabled%
  goto :reg02
:BB01
  echo PwdExpirationProtectionEnabled null
  goto :reg02

:reg02
::LAPS-启用本地管理密码管理
set regpath02=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft Services\AdmPwd
set regkey02=AdmPwdEnabled
reg query %regpath02% /v %regkey02%>nul 2>nul&&goto :AA02||goto :BB02
:AA02
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath02%"^|findstr /i "\<%regkey02%\>" ') do Set AdmPwdEnabled=%%k
  echo AdmPwdEnabled %AdmPwdEnabled%
  goto :reg03
:BB02
  echo AdmPwdEnabled null
  goto :reg03
  
:reg03
::LAPS-密码复杂度配置
set regpath03=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft Services\AdmPwd
set regkey03=PasswordComplexity
reg query %regpath03% /v %regkey03%>nul 2>nul&&goto :AA03||goto :BB03
:AA03
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath03%"^|findstr /i "\<%regkey03%\>" ') do Set PasswordComplexity=%%k
  echo PasswordComplexity %PasswordComplexity%
  goto :reg04
:BB03
  echo PasswordComplexity null
  goto :reg04
    
:reg04
::LAPS-密码长度配置
set regpath04=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft Services\AdmPwd
set regkey04=PasswordLength
reg query %regpath04% /v %regkey04%>nul 2>nul&&goto :AA04||goto :BB04
:AA04
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath04%"^|findstr /i "\<%regkey04%\>" ') do Set PasswordLength=%%k
  echo PasswordLength %PasswordLength%
  goto :reg05
:BB04
  echo PasswordLength null
  goto :reg05
    
:reg05
::LAPS-密码有效期配置
set regpath05=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft Services\AdmPwd
set regkey05=PasswordAgeDays
reg query %regpath05% /v %regkey05%>nul 2>nul&&goto :AA05||goto :BB05
:AA05
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath05%"^|findstr /i "\<%regkey05%\>" ') do Set PasswordAgeDays=%%k
  echo PasswordAgeDays %PasswordAgeDays%
  goto :reg06
:BB05
  echo PasswordAgeDays null
  goto :reg06

:reg06
::链路层拓扑发现-禁用Mapper I/O (LLTDIO) driver
set regpath06=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LLTD
set regkey06=EnableLLTDIO
reg query %regpath06% /v %regkey06%>nul 2>nul&&goto :AA06||goto :BB06
:AA06
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath06%"^|findstr /i "\<%regkey06%\>" ') do Set EnableLLTDIO=%%k
  echo EnableLLTDIO %EnableLLTDIO%
  goto :reg07
:BB06
  echo EnableLLTDIO null
  goto :reg07
 
:reg07
::链路层拓扑发现-禁用Responder (RSPNDR) driver
set regpath07=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\LLTD
set regkey07=EnableRspndr
reg query %regpath07% /v %regkey07%>nul 2>nul&&goto :AA07||goto :BB07
:AA07
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath07%"^|findstr /i "\<%regkey07%\>" ') do Set EnableRspndr=%%k
  echo EnableRspndr %EnableRspndr%
  goto :reg08
:BB07
  echo EnableRspndr null
  goto :reg08
  
:reg08
::关闭Microsoft对等网络服务
set regpath08=HKEY_LOCAL_MACHINE\Software\policies\Microsoft\Peernet
set regkey08=Disabled
reg query %regpath08% /v %regkey08%>nul 2>nul&&goto :AA08||goto :BB08
:AA08
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath08%"^|findstr /i "\<%regkey08%\>" ') do Set Disabled=%%k
  echo Disabled %Disabled%
  goto :reg09
:BB08
  echo Disabled null
  goto :reg09
  
:reg09
::禁止在DNS域网络上安装和配置网桥
set regpath09=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Network Connections
set regkey09=NC_AllowNetBridge_NLA
reg query %regpath09% /v %regkey09%>nul 2>nul&&goto :AA09||goto :BB09
:AA09
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath09%"^|findstr /i "\<%regkey09%\>" ') do Set NC_AllowNetBridge_NLA=%%k
  echo NC_AllowNetBridge_NLA %NC_AllowNetBridge_NLA%
  goto :reg10
:BB09
  echo NC_AllowNetBridge_NLA null
  goto :reg10
  
:reg10
::要求域用户在设置网络位置时提升权限
set regpath10=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Network Connections
set regkey10=NC_StdDomainUserSetLocation
reg query %regpath10% /v %regkey10%>nul 2>nul&&goto :AA10||goto :BB10
:AA10
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath10%"^|findstr /i "\<%regkey10%\>" ') do Set NC_StdDomainUserSetLocation=%%k
  echo NC_StdDomainUserSetLocation %NC_StdDomainUserSetLocation%
  goto :reg11
:BB10
  echo NC_StdDomainUserSetLocation null
  goto :reg11  
  
:reg11
::在网络登录时对本地帐户实施UAC限制
set regpath11=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
set regkey11=LocalAccountTokenFilterPolicy
reg query %regpath11% /v %regkey11%>nul 2>nul&&goto :AA11||goto :BB11
:AA11
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath11%"^|findstr /i "\<%regkey11%\>" ') do Set LocalAccountTokenFilterPolicy=%%k
  echo LocalAccountTokenFilterPolicy %LocalAccountTokenFilterPolicy%
  goto :reg12
:BB11
  echo LocalAccountTokenFilterPolicy null
  goto :reg12 
  
:reg12
::Wdigest身份验证
set regpath12=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest
set regkey12=UseLogonCredential
reg query %regpath12% /v %regkey12%>nul 2>nul&&goto :AA12||goto :BB12
:AA12
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath12%"^|findstr /i "\<%regkey12%\>" ') do Set UseLogonCredential=%%k
  echo UseLogonCredential %UseLogonCredential%
  goto :reg13
:BB12
  echo UseLogonCredential null
  goto :reg13
  
:reg13
::RPC终点映射程序客户端验证
set regpath13=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Rpc
set regkey13=EnableAuthEpResolution
reg query %regpath13% /v %regkey13%>nul 2>nul&&goto :AA13||goto :BB13
:AA13
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath13%"^|findstr /i "\<%regkey13%\>" ') do Set EnableAuthEpResolution=%%k
  echo EnableAuthEpResolution %EnableAuthEpResolution%
  goto :reg14
:BB13
  echo EnableAuthEpResolution null
  goto :reg14

:reg14
::用于未验证的RPC客户端的限制
set regpath14=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\Rpc
set regkey14=RestrictRemoteClients
reg query %regpath14% /v %regkey14%>nul 2>nul&&goto :AA14||goto :BB14
:AA14
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath14%"^|findstr /i "\<%regkey14%\>" ') do Set RestrictRemoteClients=%%k
  echo RestrictRemoteClients %RestrictRemoteClients%
  goto :reg15
:BB14
  echo RestrictRemoteClients null
  goto :reg15

:reg15
::启用/禁用PerfTrack
set regpath15=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WDI\{9c5a40da-b965-4fc3-8781-88dd50a6299d}
set regkey15=ScenarioExecutionEnabled
reg query %regpath15% /v %regkey15%>nul 2>nul&&goto :AA15||goto :BB15
:AA15
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath15%"^|findstr /i "\<%regkey15%\>" ') do Set ScenarioExecutionEnabled=%%k
  echo ScenarioExecutionEnabled %ScenarioExecutionEnabled%
  goto :reg16
:BB15
  echo ScenarioExecutionEnabled null
  goto :reg16

:reg16
::启用Windows NTP客户端
set regpath16=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\W32time\TimeProviders\NtpClient
set regkey16=Enabled
reg query %regpath16% /v %regkey16%>nul 2>nul&&goto :AA16||goto :BB16
:AA16
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath16%"^|findstr /i "\<%regkey16%\>" ') do Set Enabled=%%k
  echo Enabled %Enabled%
  goto :reg17
:BB16
  echo Enabled null
  goto :reg17

:reg17
::启用Windows NTP服务器
set regpath17=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\W32time\TimeProviders\NtpServer
set regkey17=Enabled
reg query %regpath17% /v %regkey17%>nul 2>nul&&goto :AA17||goto :BB17
:AA17
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath17%"^|findstr /i "\<%regkey17%\>" ') do Set Enabled=%%k
  echo Enabled %Enabled%
  goto :reg18
:BB17
  echo Enabled null
  goto :reg18

:reg18
::提升时枚举管理员帐户
set regpath18=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\CredUI
set regkey18=EnumerateAdministrators
reg query %regpath18% /v %regkey18%>nul 2>nul&&goto :AA18||goto :BB18
:AA18
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath18%"^|findstr /i "\<%regkey18%\>" ') do Set EnumerateAdministrators=%%k
  echo EnumerateAdministrators %EnumerateAdministrators%
  goto :reg19
:BB18
  echo EnumerateAdministrators null
  goto :reg19

:reg19
::应用程序日志设置保留旧事件
set regpath19=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Application
set regkey19=AutoBackupLogFiles
reg query %regpath19% /v %regkey19%>nul 2>nul&&goto :AA19||goto :BB19
:AA19
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath19%"^|findstr /i "\<%regkey19%\>" ') do Set AutoBackupLogFiles=%%k
  echo AutoBackupLogFiles %AutoBackupLogFiles%
  goto :reg20
:BB19
  echo AutoBackupLogFiles null
  goto :reg20

:reg20
::应用程序日志达到最大大小时的动作
set regpath20=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Application
set regkey20=Retention
reg query %regpath20% /v %regkey20%>nul 2>nul&&goto :AA20||goto :BB20
:AA20
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath20%"^|findstr /i "\<%regkey20%\>" ') do Set Retention=%%k
  echo Retention %Retention%
  goto :reg21
:BB20
  echo Retention null
  goto :reg21

:reg21
::应用程序日志最大大小
set regpath21=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Application
set regkey21=MaxSize
reg query %regpath21% /v %regkey21%>nul 2>nul&&goto :AA21||goto :BB21
:AA21
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath21%"^|findstr /i "\<%regkey21%\>" ') do Set MaxSize=%%k
  echo MaxSize %MaxSize%
  goto :reg22
:BB21
  echo MaxSize null
  goto :reg22

:reg22
::安全日志设置保留旧事件
set regpath22=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Security
set regkey22=AutoBackupLogFiles
reg query %regpath22% /v %regkey22%>nul 2>nul&&goto :AA22||goto :BB22
:AA22
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath22%"^|findstr /i "\<%regkey22%\>" ') do Set AutoBackupLogFiles=%%k
  echo AutoBackupLogFiles %AutoBackupLogFiles%
  goto :reg23
:BB22
  echo AutoBackupLogFiles null
  goto :reg23

:reg23
::安全日志达到最大大小时的动作
set regpath23=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Security
set regkey23=Retention
reg query %regpath23% /v %regkey23%>nul 2>nul&&goto :AA23||goto :BB23
:AA23
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath23%"^|findstr /i "\<%regkey23%\>" ') do Set Retention=%%k
  echo Retention %Retention%
  goto :reg24
:BB23
  echo Retention null
  goto :reg24

:reg24
::安全日志最大日志大小
set regpath24=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Security
set regkey24=MaxSize
reg query %regpath24% /v %regkey24%>nul 2>nul&&goto :AA24||goto :BB24
:AA24
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath24%"^|findstr /i "\<%regkey24%\>" ') do Set MaxSize=%%k
  echo MaxSize %MaxSize%
  goto :reg25
:BB24
  echo MaxSize null
  goto :reg25


:reg25
::安装程序日志设置保留旧事件
set regpath25=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Setup
set regkey25=AutoBackupLogFiles
reg query %regpath25% /v %regkey25%>nul 2>nul&&goto :AA25||goto :BB25
:AA25
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath25%"^|findstr /i "\<%regkey25%\>" ') do Set AutoBackupLogFiles=%%k
  echo AutoBackupLogFiles %AutoBackupLogFiles%
  goto :reg26
:BB25
  echo AutoBackupLogFiles null
  goto :reg26


:reg26
::安装程序日志最大日志大小
set regpath26=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\Setup
set regkey26=MaxSize
reg query %regpath26% /v %regkey26%>nul 2>nul&&goto :AA26||goto :BB26
:AA26
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath26%"^|findstr /i "\<%regkey26%\>" ') do Set MaxSize=%%k
  echo MaxSize %MaxSize%
  goto :reg27
:BB26
  echo MaxSize null
  goto :reg27
  
:reg27
::系统日志设置保留旧事件
set regpath27=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\System
set regkey27=AutoBackupLogFiles
reg query %regpath27% /v %regkey27%>nul 2>nul&&goto :AA27||goto :BB27
:AA27
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath27%"^|findstr /i "\<%regkey27%\>" ') do Set AutoBackupLogFiles=%%k
  echo AutoBackupLogFiles %AutoBackupLogFiles%
  goto :reg28
:BB27
  echo AutoBackupLogFiles null
  goto :reg28

:reg28
::系统日志文件达到最大大小时的动作
set regpath28=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\System
set regkey28=Retention
reg query %regpath28% /v %regkey28%>nul 2>nul&&goto :AA28||goto :BB28
:AA28
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath28%"^|findstr /i "\<%regkey28%\>" ') do Set Retention=%%k
  echo Retention %Retention%
  goto :reg29
:BB28
  echo Retention null
  goto :reg29

:reg29
::系统日志最大日志大小
set regpath29=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\EventLog\System
set regkey29=MaxSize
reg query %regpath29% /v %regkey29%>nul 2>nul&&goto :AA29||goto :BB29
:AA29
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath29%"^|findstr /i "\<%regkey29%\>" ') do Set MaxSize=%%k
  echo MaxSize %MaxSize%
  goto :reg30
:BB29
  echo MaxSize null
  goto :reg30

:reg30
::在用户登录期间显示有关以前登录的信息
set regpath30=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System
set regkey30=DisplayLastLogonInfo
reg query %regpath30% /v %regkey30%>nul 2>nul&&goto :AA30||goto :BB30
:AA30
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath30%"^|findstr /i "\<%regkey30%\>" ') do Set DisplayLastLogonInfo=%%k
  echo DisplayLastLogonInfo %DisplayLastLogonInfo%
  goto :reg31
:BB30
  echo DisplayLastLogonInfo null
  goto :reg31

:reg31
::不允许保存密码
set regpath31=HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System
set regkey31=DisablePasswordSaving
reg query %regpath31% /v %regkey31%>nul 2>nul&&goto :AA31||goto :BB31
:AA31
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath31%"^|findstr /i "\<%regkey31%\>" ') do Set DisablePasswordSaving=%%k
  echo DisablePasswordSaving %DisablePasswordSaving%
  goto :reg32
:BB31
  echo DisablePasswordSaving null
  goto :reg32


:reg32
::将远程桌面服务用户限制到单独的远程桌面服务会话
set regpath32=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey32=fSingleSessionPerUser
reg query %regpath32% /v %regkey32%>nul 2>nul&&goto :AA32||goto :BB32
:AA32
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath32%"^|findstr /i "\<%regkey32%\>" ') do Set fSingleSessionPerUser=%%k
  echo fSingleSessionPerUser %fSingleSessionPerUser%
  goto :reg33
:BB32
  echo fSingleSessionPerUser null
  goto :reg33

:reg33
::不允许 COM 端口重定向
set regpath33=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey33=fDisableCcm
reg query %regpath33% /v %regkey33%>nul 2>nul&&goto :AA33||goto :BB33
:AA33
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath33%"^|findstr /i "\<%regkey33%\>" ') do Set fDisableCcm=%%k
  echo fDisableCcm %fDisableCcm%
  goto :reg34
:BB33
  echo fDisableCcm null
  goto :reg34

:reg34
::不允许驱动器重定向
set regpath34=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey34=fDisableCdm
reg query %regpath34% /v %regkey34%>nul 2>nul&&goto :AA34||goto :BB34
:AA34
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath34%"^|findstr /i "\<%regkey34%\>" ') do Set fDisableCdm=%%k
  echo fDisableCdm %fDisableCdm%
  goto :reg35
:BB34
  echo fDisableCdm null
  goto :reg35

:reg35
::不允许 LPT 端口重定向
set regpath35=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey35=fDisableLPT
reg query %regpath35% /v %regkey35%>nul 2>nul&&goto :AA35||goto :BB35
:AA35
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath35%"^|findstr /i "\<%regkey35%\>" ') do Set fDisableLPT=%%k
  echo fDisableLPT %fDisableLPT%
  goto :reg36
:BB35
  echo fDisableLPT null
  goto :reg36

:reg36
::始终在连接时提示输入密码
set regpath36=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey36=fPromptForPassword
reg query %regpath36% /v %regkey36%>nul 2>nul&&goto :AA36||goto :BB36
:AA36
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath36%"^|findstr /i "\<%regkey36%\>" ') do Set fPromptForPassword=%%k
  echo fPromptForPassword %fPromptForPassword%
  goto :reg37
:BB36
  echo fPromptForPassword null
  goto :reg37

:reg37
::要求安全的 RPC 通信
set regpath37=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey37=fEncryptRPCTraffic
reg query %regpath37% /v %regkey37%>nul 2>nul&&goto :AA37||goto :BB37
:AA37
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath37%"^|findstr /i "\<%regkey37%\>" ') do Set fEncryptRPCTraffic=%%k
  echo fEncryptRPCTraffic %fEncryptRPCTraffic%
  goto :reg38
:BB37
  echo fEncryptRPCTraffic null
  goto :reg38
  
:reg38
::设置活动但空闲的远程桌面服务会话的时间限制
set regpath38=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey38=MaxIdleTime
reg query %regpath38% /v %regkey38%>nul 2>nul&&goto :AA38||goto :BB38
:AA38
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath38%"^|findstr /i "\<%regkey38%\>" ') do Set MaxIdleTime=%%k
  echo MaxIdleTime %MaxIdleTime%
  goto :reg39
:BB38
  echo MaxIdleTime null
  goto :reg39  
  
:reg39
::设置已中断会话的时间限制
set regpath39=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey39=MaxDisconnectionTime
reg query %regpath39% /v %regkey39%>nul 2>nul&&goto :AA39||goto :BB39
:AA39
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath39%"^|findstr /i "\<%regkey39%\>" ') do Set MaxDisconnectionTime=%%k
  echo MaxDisconnectionTime %MaxIdleTime%
  goto :reg40
:BB39
  echo MaxDisconnectionTime null
  goto :reg40   

:reg40
::在退出时删除临时文件夹
set regpath40=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
set regkey40=DeleteTempDirsOnExit
reg query %regpath40% /v %regkey40%>nul 2>nul&&goto :AA40||goto :BB40
:AA40
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath40%"^|findstr /i "\<%regkey40%\>" ') do Set DeleteTempDirsOnExit=%%k
  echo DeleteTempDirsOnExit %MaxIdleTime%
  goto :reg41
:BB40
  echo DeleteTempDirsOnExit null
  goto :reg41

:reg41
::打开 PowerShell 脚本块日志记录
set regpath41=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging
set regkey41=EnableScriptBlockLogging
reg query %regpath41% /v %regkey41%>nul 2>nul&&goto :AA41||goto :BB41
:AA41
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath41%"^|findstr /i "\<%regkey41%\>" ') do Set EnableScriptBlockLogging=%%k
  echo EnableScriptBlockLogging %MaxIdleTime%
  goto :reg42
:BB41
  echo EnableScriptBlockLogging null
  goto :reg42

:reg42
::允许基本身份验证
set regpath42=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WinRM\Client
set regkey42=AllowBasic
reg query %regpath42% /v %regkey42%>nul 2>nul&&goto :AA42||goto :BB42
:AA42
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath42%"^|findstr /i "\<%regkey42%\>" ') do Set AllowBasic=%%k
  echo AllowBasic %AllowBasic%
  goto :reg43
:BB42
  echo AllowBasic null
  goto :reg43
 
:reg43
::不允许使用摘要式身份验证
set regpath43=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WinRM\Client
set regkey43=AllowDigest
reg query %regpath43% /v %regkey43%>nul 2>nul&&goto :AA43||goto :BB43
:AA43
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath43%"^|findstr /i "\<%regkey43%\>" ') do Set AllowDigest=%%k
  echo AllowDigest %AllowDigest%
  goto :reg44
:BB43
  echo AllowDigest null
  goto :reg44
 
:reg44
::允许基本身份验证(WinRM 服务)
set regpath44=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WinRM\Service
set regkey44=AllowBasic
reg query %regpath44% /v %regkey44%>nul 2>nul&&goto :AA44||goto :BB44
:AA44
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath44%"^|findstr /i "\<%regkey44%\>" ') do Set AllowBasic=%%k
  echo AllowBasic %AllowBasic%
  goto :reg45
:BB44
  echo AllowBasic null
  goto :reg45
 
:reg45
::不允许 WinRM 储存 RunAs 凭据
set regpath45=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WinRM\Service
set regkey45=DisableRunAs
reg query %regpath45% /v %regkey45%>nul 2>nul&&goto :AA45||goto :BB45
:AA45
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath45%"^|findstr /i "\<%regkey45%\>" ') do Set DisableRunAs=%%k
  echo DisableRunAs %DisableRunAs%
  goto :reg46
:BB45
  echo DisableRunAs null
  goto :reg46 
  
 :reg46
 pause