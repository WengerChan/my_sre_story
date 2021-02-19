@echo off
setlocal enabledelayedexpansion

::memory

::memory_availablembytes
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfOS_Memory get AvailableMBytes /value | findstr "AvailableMBytes""') do (
    echo memory_availablembytes %%j
)

::memory_pagespersec
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfOS_Memory get PagesPerSec /value | findstr "PagesPersec""') do (
    echo memory_pagespersec %%j
)

::memory_percentcommittedbytesinuse
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfOS_Memory get PercentCommittedBytesInUse /value | findstr "PercentCommittedBytesInUse""') do (
    echo memory_percentcommittedbytesinuse %%j
)