@echo off
setlocal enabledelayedexpansion


::physicaldisk

::physicaldisk_percentdisktime
set tee=1
set num=0
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfDisk_PhysicalDisk where (Name^!='_Total') get "PercentDiskTime","Name" /value | findstr "PercentDiskTime Name""') do ( 
    set /a tee+=1
    set /a num=!tee!%%2

    if "!num!" == "0" @for /f "tokens=1,* delims=:" %%x in ("%%j") do (set physicaldisk_name=%%x && set physicaldisk_name=!physicaldisk_name:~-2,-1!)
    if "!num!" == "1" @for /f "tokens=1,* delims=:" %%x in ("%%j") do (set physicaldisk_percentdisktime=%%x && echo physicaldisk_percentdisktime{physicaldisk_name="!physicaldisk_name!:"} !physicaldisk_percentdisktime!)
)

::physicaldisk_avgdiskqueuelength
set tee=1
set num=0
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfDisk_PhysicalDisk where (Name^!='_Total') get "AvgDiskQueueLength","Name" /value | findstr "AvgDiskQueueLength Name""') do ( 
    set /a tee+=1
    set /a num=!tee!%%2

    if "!num!" == "0" set physicaldisk_avgdiskqueuelength=%%j
    if "!num!" == "1" @for /f "tokens=1,* delims=:" %%x in ("%%j") do (set physicaldisk_name=%%x && echo physicaldisk_avgdiskqueuelength{physicaldisk_name="!physicaldisk_name:~-2,-1!:"} !physicaldisk_avgdiskqueuelength!)
)

::physicaldisk_diskreadspersec
set tee=1
set num=0
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfDisk_PhysicalDisk where (Name^!='_Total') get "DiskWritesPerSec","Name" /value | findstr "DiskWritesPersec Name""') do ( 
    set /a tee+=1
    set /a num=!tee!%%2

    if "!num!" == "0" set physicaldisk_diskreadspersec=%%j
    if "!num!" == "1" @for /f "tokens=1,* delims=:" %%x in ("%%j") do (set physicaldisk_name=%%x && echo physicaldisk_diskreadspersec{physicaldisk_name="!physicaldisk_name:~-2,-1!:"} !physicaldisk_diskreadspersec!)
)

::physicaldisk_diskwritespersec
set tee=1
set num=0
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfDisk_PhysicalDisk where (Name^!='_Total') get "DiskWritesPerSec","Name" /value | findstr "DiskWritesPersec Name""') do ( 
    set /a tee+=1
    set /a num=!tee!%%2

    if "!num!" == "0" set physicaldisk_diskwritespersec=%%j
    if "!num!" == "1" @for /f "tokens=1,* delims=:" %%x in ("%%j") do (set physicaldisk_name=%%x && echo physicaldisk_diskwritespersec{physicaldisk_name="!physicaldisk_name:~-2,-1!:"} !physicaldisk_diskwritespersec!)
)