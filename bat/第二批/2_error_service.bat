
@echo off
setlocal enabledelayedexpansion

::error service
set tee=1
set num=0
For /f "tokens=1,* delims==" %%i in  ('"wmic service where (StartMode='Auto' and State='Stopped') get 'Caption','state' /value |findstr "Caption State""') do (
    set value=%%j
    set /a tee+=1
    set /a num=!tee!%%2

    if "!num!" == "0" @for /f "delims=:" %%x in ("!value!") do set service_name=%%x
	if "!num!" == "1"  echo service_state{service_name="!service_name!"} !value!
)


   