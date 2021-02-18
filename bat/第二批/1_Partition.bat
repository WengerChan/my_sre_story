@echo off
setlocal enabledelayedexpansion


::partition

::partition_size
set tee=1
set num=0
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_LogicalDisk where (MediaType='12') get DeviceID,Size /value | findstr "DeviceID Size""') do ( 
    set value=%%j
    set /a tee+=1
    set /a num=!tee!%%2

    if "!num!" == "0" @for /f "delims=:" %%x in ("!value!") do set partition_name=%%x
    if "!num!" == "1" set partition_size=!value:~0,-10! && set /a partition_size=!partition_size! * 93 / 100 && echo partition_size{partition_name="!partition_name!:"} !partition_size: =!
)

::partition_free
set tee=1
set num=0
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_LogicalDisk where (MediaType='12') get DeviceID,FreeSpace /value | findstr "DeviceID FreeSpace""') do ( 
    set value=%%j
    set /a tee+=1
    set /a num=!tee!%%2

    if "!num!" == "0" @for /f "delims=:" %%x in ("!value!") do set partition_name=%%x
    if "!num!" == "1" set partition_free=!value:~0,-10! && set /a partition_free=!partition_free! * 93 / 100 && echo partition_free{partition_name="!partition_name!:"} !partition_free: =!
)

::partition_freeper
set tee=2
set num=0
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_LogicalDisk where (MediaType='12') get DeviceID,FreeSpace,Size /value | findstr "DeviceID FreeSpace Size""') do ( 
    set value=%%j
    set /a tee+=1
    set /a num=!tee!%%3

    if "!num!" == "0" @for /f "delims=:" %%x in ("%%j") do set partition_name=%%x
    if "!num!" == "1" set partition_free=!value:~0,-10! && set /a partition_free=!partition_free! * 93 / 100
    if "!num!" == "2" set partition_size=!value:~0,-10! && set /a partition_freeper=!partition_free!*93/!partition_size! && echo partition_freeper{partition_name="!partition_name!:"} !partition_freeper!
)
