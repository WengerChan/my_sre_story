@echo off
Setlocal enabledelayedexpansion 

::Canway Technology Co.,Ltd

::Category/Subcategory    GUID
::帐户登录                {69979850-797A-11D9-BED3-505054503030}
::帐户管理                {6997984E-797A-11D9-BED3-505054503030}
::详细追踪                {6997984C-797A-11D9-BED3-505054503030}
::DS 访问                 {6997984F-797A-11D9-BED3-505054503030}
::登录/注销               {69979849-797A-11D9-BED3-505054503030}
::对象访问                {6997984A-797A-11D9-BED3-505054503030}
::策略改动                {6997984D-797A-11D9-BED3-505054503030}
::特权使用                {6997984B-797A-11D9-BED3-505054503030}
::系统                    {69979848-797A-11D9-BED3-505054503030}



::1. Account Logon - 账户登录
:: Credential Validation
:: Kerberos Authentication Service
:: Kerberos Service Ticket Operations
:: Other Logon/Logoff Events

:AccountLogon
for /f "tokens=1,2,3*" %%i in ('auditpol /get /Category:"{69979850-797A-11D9-BED3-505054503030}" ^| findstr "Kerberos 服务票证操作"') do (set KerberosServiceTicketOperations=%%k)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979850-797A-11D9-BED3-505054503030}" ^| findstr "其他帐户登录事件"') do (set OtherLogonLogoffEvents=%%j)
for /f "tokens=1,2,3*" %%i in ('auditpol /get /Category:"{69979850-797A-11D9-BED3-505054503030}" ^| findstr "Kerberos 身份验证服务"') do (set KerberosAuthenticationService=%%k)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979850-797A-11D9-BED3-505054503030}" ^| findstr "凭据验证"') do (set CredentialValidation=%%j)
echo KerberosServiceTicketOperations %KerberosServiceTicketOperations%
echo OtherLogonLogoffEvents %OtherLogonLogoffEvents%
echo KerberosAuthenticationService %KerberosAuthenticationService%
echo CredentialValidation %CredentialValidation%


::2. Account Management - 帐户管理
:: Application Group Management
:: Computer Account Management
:: Distribution Group Management
:: Other Account Management Events
:: Security Group Management
:: User Account Management

:AccountManagement
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984E-797A-11D9-BED3-505054503030}" ^| findstr "计算机帐户管理"') do (set ComputerAccountManagement=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984E-797A-11D9-BED3-505054503030}" ^| findstr "安全组管理"') do (set SecurityGroupManagement=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984E-797A-11D9-BED3-505054503030}" ^| findstr "分发组管理"') do (set DistributionGroupManagement=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984E-797A-11D9-BED3-505054503030}" ^| findstr "应用程序组管理"') do (set ApplicationGroupManagement=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984E-797A-11D9-BED3-505054503030}" ^| findstr "其他帐户管理事件"') do (set OtherAccountManagementEvents=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984E-797A-11D9-BED3-505054503030}" ^| findstr "用户帐户管理"') do (set UserAccountManagement=%%j)
echo ComputerAccountManagement %ComputerAccountManagement%
echo SecurityGroupManagement %SecurityGroupManagement%
echo DistributionGroupManagement %DistributionGroupManagement%
echo ApplicationGroupManagement %ApplicationGroupManagement%
echo OtherAccountManagementEvents %OtherAccountManagementEvents%
echo UserAccountManagement %UserAccountManagement%


::3. Detailed Tracking - 详细跟踪
::较旧版本:
::  DPAPI Activity
::  Process Creation
::  Process Termination
::  RPC Events
::Windows Server 2016版本新增：
::  PNP Activity
::  Token Right Adjusted

:DetailedTracking
ver|findstr /r /i " [版本 10.*.*]" >nul && goto :DetailedTracking2016 || goto :DetailedTracking2012

:DetailedTracking2012
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "DPAPI 活动"') do (set DPAPIActivity=%%k)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "进程创建"') do (set ProcessCreation=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "进程终止"') do (set ProcessTermination=%%j)
  for /f "tokens=1,2,3*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "RPC 事件"') do (set RPCEvents=%%k)
  echo DPAPIActivity %DPAPIActivity%
  echo ProcessCreation %ProcessCreation%
  echo ProcessTermination %ProcessTermination%
  echo RPCEvents %RPCEvents%
  goto :DSAccess
:DetailedTracking2016
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "DPAPI 活动"') do (set DPAPIActivity=%%k)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "进程创建"') do (set ProcessCreation=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "进程终止"') do (set ProcessTermination=%%j)
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "RPC 事件"') do (set RPCEvents=%%k)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "“即插即用”事件"') do (set PNPActivity=%%j)
  for /f "tokens=1,2,3,4,5,*" %%i in ('auditpol /get /Category:"{6997984C-797A-11D9-BED3-505054503030}" ^| findstr "Token Right Adjusted Events"') do (set TokenRightAdjusted=%%m)
  echo DPAPIActivity %DPAPIActivity%
  echo ProcessCreation %ProcessCreation%
  echo ProcessTermination %ProcessTermination%
  echo RPCEvents %RPCEvents%
  echo PNPActivity %PNPActivity%
  echo TokenRightAdjusted %TokenRightAdjusted%
  goto :DSAccess


::4. DS Access - DS访问
:: Detailed Directory Service Replication
:: Directory Service Access
:: Directory Service Changes
:: Directory Service Replication

:DSAccess
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984F-797A-11D9-BED3-505054503030}" ^| findstr "详细的目录服务复制"') do (set DetailedDirectoryServiceReplication=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984F-797A-11D9-BED3-505054503030}" ^| findstr "目录服务访问"') do (set DirectoryServiceAccess=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984F-797A-11D9-BED3-505054503030}" ^| findstr "目录服务更改"') do (set DirectoryServiceChanges=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984F-797A-11D9-BED3-505054503030}" ^| findstr "目录服务复制"') do (set DirectoryServiceReplication=%%j)
echo DetailedDirectoryServiceReplication %DetailedDirectoryServiceReplication%
echo DirectoryServiceAccess %DirectoryServiceAccess%
echo DirectoryServiceChanges %DirectoryServiceChanges%
echo DirectoryServiceReplication %DirectoryServiceReplication%


::5. Logon / Logoff - 登录/注销
::较旧版本:
::  Account Lockout
::  User/Device Claims
::  IPsec Extended Mode
::  IPsec Main Mode
::  IPsec Quick Mode
::  Logoff
::  Logon
::  Network Policy Server
::  Other Logon/Logoff Events
::  Special Logon
::Windows Server 2016新增: 
::  Group Membership

:LogonLogoff
ver|findstr /r /i " [版本 10.*.*]" >nul && goto :LogonLogoff2016 || goto :LogonLogoff2012

:LogonLogoff2012
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "帐户锁定"') do (set AccountLockout=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "用户/设备声明"') do (set UserDeviceClaims=%%j)
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "IPsec 扩展模式"') do (set IPsecExtendedMode=%%k)
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "IPsec 主模式"') do (set IPsecMainMode=%%k)
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "IPsec 快速模式"') do (set IPsecQuickMode=%%k)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "注销"') do (set Logoff=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "登录"') do (set Logon=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "网络策略服务器"') do (set NetworkPolicyServer=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "其他登录/注销事件"') do (set OtherLogonLogoffEvents=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "特殊登录"') do (set SpecialLogon=%%j)
  echo AccountLockout %AccountLockout%
  echo UserDeviceClaims %UserDeviceClaims%
  echo IPsecExtendedMode %IPsecExtendedMode%
  echo IPsecMainMode %IPsecMainMode%
  echo IPsecQuickMode %IPsecQuickMode%
  echo Logoff %Logoff%
  echo Logon %Logon%
  echo NetworkPolicyServer %NetworkPolicyServer%
  echo OtherLogonLogoffEvents %OtherLogonLogoffEvents%
  echo SpecialLogon %SpecialLogon%
  goto :ObjectAccess
:LogonLogoff2016
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "帐户锁定"') do (set AccountLockout=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "用户/设备声明"') do (set UserDeviceClaims=%%j)
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "IPsec 扩展模式"') do (set IPsecExtendedMode=%%k)
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "IPsec 主模式"') do (set IPsecMainMode=%%k)
  for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "IPsec 快速模式"') do (set IPsecQuickMode=%%k)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "注销"') do (set Logoff=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "登录"') do (set Logon=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "网络策略服务器"') do (set NetworkPolicyServer=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "其他登录/注销事件"') do (set OtherLogonLogoffEvents=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "特殊登录"') do (set SpecialLogon=%%j)
  for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979849-797A-11D9-BED3-505054503030}" ^| findstr "组成员身份"') do (set GroupMembership=%%j)
  echo AccountLockout %AccountLockout%
  echo UserDeviceClaims %UserDeviceClaims%
  echo IPsecExtendedMode %IPsecExtendedMode%
  echo GroupMembership %GroupMembership%
  echo IPsecMainMode %IPsecMainMode%
  echo IPsecQuickMode %IPsecQuickMode%
  echo Logoff %Logoff%
  echo Logon %Logon%
  echo NetworkPolicyServer %NetworkPolicyServer%
  echo OtherLogonLogoffEvents %OtherLogonLogoffEvents%
  echo SpecialLogon %SpecialLogon%
  goto :ObjectAccess

::6. Object Access - 对象访问 
:: Application Generated
:: Certification Services
:: Detailed File Share
:: File Share
:: File System
:: Filtering Platform Connection
:: Filtering Platform Packet Drop
:: Handle Manipulation
:: Kernel Object
:: Other Object Access Events
:: Registry
:: Removable Storage
:: SAM
:: Central Access Policy Staging

:ObjectAccess
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "已生成应用程序"') do (set ApplicationGenerated=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "证书服务"') do (set CertificationServices=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "详细的文件共享"') do (set DetailedFileShare=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "文件共享"') do (set FileShare=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "文件系统"') do (set FileSystem=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "筛选平台连接"') do (set FilteringPlatformConnection=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "筛选平台数据包丢弃"') do (set FilteringPlatformPacketDrop=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "句柄操作"') do (set HandleManipulation=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "内核对象    "') do (set KernelObject=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "其他对象访问事件"') do (set OtherObjectAccessEvents=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "注册表"') do (set Registry=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "可移动存储"') do (set RemovableStorage=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "SAM"') do (set SAM=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984A-797A-11D9-BED3-505054503030}" ^| findstr "中心策略暂存"') do (set CentralAccessPolicyStaging=%%j)
echo ApplicationGenerated %ApplicationGenerated%
echo CertificationServices %CertificationServices%
echo DetailedFileShare %DetailedFileShare%
echo FileShare %FileShare%
echo FileSystem %FileSystem%
echo FilteringPlatformConnection %FilteringPlatformConnection%
echo FilteringPlatformPacketDrop %FilteringPlatformPacketDrop%
echo HandleManipulation %HandleManipulation%
echo KernelObject %KernelObject%
echo OtherObjectAccessEvents %OtherObjectAccessEvents%
echo Registry %Registry%
echo RemovableStorage %RemovableStorage%
echo SAM %SAM%
echo CentralAccessPolicyStaging %CentralAccessPolicyStaging%


::7. Policy Change - 策略更改
::Audit Policy Change
::Authentication Policy Change
::Authorization Policy Change
::Filtering Platform Policy Change
::MPSSVC Rule-Level Policy Change
::Other Policy Change Events

:PolicyChange
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984D-797A-11D9-BED3-505054503030}" ^| findstr "审核策略更改"') do (set AuditPolicyChange=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984D-797A-11D9-BED3-505054503030}" ^| findstr "身份验证策略更改"') do (set AuthenticationPolicyChange=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984D-797A-11D9-BED3-505054503030}" ^| findstr "授权策略更改"') do (set AuthorizationPolicyChange=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984D-797A-11D9-BED3-505054503030}" ^| findstr "筛选平台策略更改"') do (set FilteringPlatformPolicyChange=%%j)
for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{6997984D-797A-11D9-BED3-505054503030}" ^| findstr "MPSSVC 规则级别策略更改"') do (set MPSSVCRule-LevelPolicyChange=%%k)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984D-797A-11D9-BED3-505054503030}" ^| findstr "其他策略更改事件"') do (set OtherPolicyChangeEvents=%%j)
echo AuditPolicyChange %AuditPolicyChange%
echo AuthenticationPolicyChange %AuthenticationPolicyChange%
echo AuthorizationPolicyChange %AuthorizationPolicyChange%
echo FilteringPlatformPolicyChange %FilteringPlatformPolicyChange%
echo MPSSVCRule-LevelPolicyChange %MPSSVCRule-LevelPolicyChange%
echo OtherPolicyChangeEvents %OtherPolicyChangeEvents%


::8. Privilege Use - 特权使用
::Non-Sensitive Privilege Use
::Sensitive Privilege Use
::Other Privilege Use Events

:PrivilegeUse
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984B-797A-11D9-BED3-505054503030}" ^| findstr "非敏感权限使用"') do (set Non-SensitivePrivilegeUse=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984B-797A-11D9-BED3-505054503030}" ^| findstr "敏感权限使用"') do (set SensitivePrivilegeUse=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{6997984B-797A-11D9-BED3-505054503030}" ^| findstr "其他权限使用事件"') do (set OtherPrivilegeUseEvents=%%j)
echo Non-SensitivePrivilegeUse %Non-SensitivePrivilegeUse%
echo SensitivePrivilegeUse %SensitivePrivilegeUse%
echo OtherPrivilegeUseEvents %OtherPrivilegeUseEvents%

::9. System - 系统
::IPSEC Driver
::Other System Events
::Security State Change
::Security System Extension
::Security System Integrity

:System
for /f "tokens=1,2,3,*" %%i in ('auditpol /get /Category:"{69979848-797A-11D9-BED3-505054503030}" ^| findstr "IPsec 驱动程序"') do (set IPSECDriver=%%k)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979848-797A-11D9-BED3-505054503030}" ^| findstr "其他系统事件"') do (set OtherSystemEvents=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979848-797A-11D9-BED3-505054503030}" ^| findstr "安全状态更改"') do (set SecurityStateChange=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979848-797A-11D9-BED3-505054503030}" ^| findstr "安全系统扩展"') do (set SecuritySystemExtension=%%j)
for /f "tokens=1,2,*" %%i in ('auditpol /get /Category:"{69979848-797A-11D9-BED3-505054503030}" ^| findstr "系统完整性"') do (set SecuritySystemIntegrity=%%j)
echo IPSECDriver %IPSECDriver%
echo OtherSystemEvents %OtherSystemEvents%
echo SecurityStateChange %SecurityStateChange%
echo SecuritySystemExtension %SecuritySystemExtension%
echo SecuritySystemIntegrity %SecuritySystemIntegrity%

pause