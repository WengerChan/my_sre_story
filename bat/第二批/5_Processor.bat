@echo off
setlocal enabledelayedexpansion

::processor

::processor_percentprocessortime
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfOS_Processor where Name='_Total' get PercentProcessorTime /value | findstr "PercentProcessorTime""') do (
    echo processor_percentprocessortime %%j
)

::processor_percentdpctime
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfOS_Processor where Name='_Total' get PercentDPCTime /value | findstr "PercentDPCTime""') do (
    echo processor_percentdpctime %%j
)

::processor_percentinterrupttime
for /f "tokens=1,* delims==" %%i in ('"wmic path Win32_PerfFormattedData_PerfOS_Processor where Name='_Total' get PercentInterruptTime /value | findstr "PercentInterruptTime""') do (
    echo processor_percentinterrupttime %%j
)