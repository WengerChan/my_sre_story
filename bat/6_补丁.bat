::����
@echo off

::�ж�ָ�������Ƿ�װ
set KB=KBxxxx
wmic qfe get hotfixid | findstr /i "%KB%">nul 2>nul&&goto :AA01||goto :BB01
:AA01
  For /f %%i in ('wmic qfe get hotfixid ^|findstr /i "%KB%" ') do set hotfixid=%%i
  echo hotfixid %hotfixid%
  goto :02
:BB01
  echo hotfixid null
  goto :02
  
:02
::�о������Ѱ�װ����
wmic qfe get hotfixid
  goto :03

:03
::�����ļ�����Ȩ����
set regpath03=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters
set regkey03=AutoShareServer
reg query %regpath03% /v %regkey03%>nul 2>nul&&goto :AA03||goto :BB03
:AA03
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath03%"^|findstr /i "\<%regkey03%\>" ') do Set AutoShareServer=%%k
  echo AutoShareServer %AutoShareServer%
  goto :04
:BB03
  echo AutoShareServer null
  goto :04

:04
::����ϵͳ�汾
  For /f "tokens=1,2,3,4,* delims=] " %%i in ('ver') do set version=%%l
  echo version %version%
  goto :05
  
:05 
::����ϵͳ��װʱ��
  For /f "tokens=1,2,3,4,* delims=, " %%i in ('systeminfo^|findstr "��ʼ��װ����"') do set Initial_installation_date=%%j
  echo Initial_installation_date %Initial_installation_date%
  goto :06

:06
::�ϴ�����ʱ��
  For /f "tokens=1,2,3,4,* delims=, " %%i in ('systeminfo^|findstr "ϵͳ����ʱ��"') do set System_startup_time=%%j
  echo System_startup_time %System_startup_time%
  goto :07

:07
::��󲹶��������
set regpath07=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\Results\Install
set regkey07=LastSuccessTime
reg query %regpath07% /v %regkey07%>nul 2>nul&&goto :AA07||goto :BB07
:AA07
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath07%"^|findstr /i "\<%regkey07%\>" ') do Set LastSuccessTime=%%k
  echo LastSuccessTime %LastSuccessTime%
  goto :08
:BB07
  echo LastSuccessTime null
  goto :08
  
:08
::�ر��Զ�����
set regpath08=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU
set regkey08=NoAutoUpdate
reg query %regpath08% /v %regkey08%>nul 2>nul&&goto :AA08||goto :BB08
:AA08
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath08%"^|findstr /i "\<%regkey08%\>" ') do Set NoAutoUpdate=%%k
  echo NoAutoUpdate %NoAutoUpdate%
  goto :09
:BB08
  echo NoAutoUpdate null
  goto :09
  
:09
::�Զ�����ѡ��
set regpath09=HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsUpdate\AU
set regkey09=AUOptions
reg query %regpath09% /v %regkey09%>nul 2>nul&&goto :AA09||goto :BB09
:AA09
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath09%"^|findstr /i "\<%regkey09%\>" ') do Set AUOptions=%%k
  echo AUOptions %AUOptions%
  goto :10
:BB09
  echo AUOptions null
  goto :10

:10
::WSUS������
set regpath10=HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\windows\WindowsUpdate\AU
set regkey10=UseWUServer
reg query %regpath10% /v %regkey10%>nul 2>nul&&goto :AA10||goto :BB10
:AA10
  For /f "tokens=1,2,3,4,*" %%i in ('Reg Query "%regpath10%"^|findstr /i "\<%regkey10%\>" ') do Set UseWUServer=%%k
  echo UseWUServer %UseWUServer%
  goto :11
:BB10
  echo UseWUServer null
  goto :11
  
:11
pause
