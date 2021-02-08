#=============================================
# Script Name: discover_web-middleware_win.ps1
#      Author: Wenger Chan
#     Version: V 1.0
#        Date: 2021-02-08
#       Usage: powershell discover_web-middleware_win.ps1
# Description: 发现web中间件及版本
#=============================================

# Define variables -- BEGIN #

$middleware_is_exist = ""
$middleware_version = ""
$system_pans = [System.Environment]::GetLogicalDrives()
$path_middleware = Get-ChildItem -Path $system_pans -Recurse 2>$null| ?{$_.Name -eq "weblogic.jar" -or $_.Name -eq "asadmin.bat"} | %{$_.FullName}

## weblogic相关信息
$version_weblogic = ""
$path_weblogic = echo $path_middleware | findstr "weblogic.jar"

## InforSuite相关信息
$version_inforsuite = ""
$path_inforsuite = echo $path_middleware | findstr "as\\bin\\asadmin\.bat$"

# Define variables -- END #

# Script Body -- BEGIN #

## Weblogic
if($path_weblogic){

    foreach($path1 in $path_weblogic){
    $middleware_is_exist = "1"
    $version_weblogic = $version_weblogic + $(java -cp $path1 weblogic.version 2>$null).split()[3] + ","
    }

    $version_weblogic = "Weblogic-" + $version_weblogic -replace "(^\,|\,*$)",""
}

## InforSuite
if($path_inforsuite){

    foreach($path2 in $path_inforsuite){
    $middleware_is_exist = "1"
    $version_inforsuite = $version_inforsuite + $(.$path2 version | findstr "\(build.*\)").split()[7] + ","
    }
    
    $version_inforsuite = "InforSuite-" + $version_inforsuite -replace "(^\,|\,*$)",""
}


## 输出
$middleware_version = $version_weblogic + "/" + $version_inforsuite -replace "(^\/|\/$)",""
 
if($middleware_is_exist)
{
    Write-Host "{"""middleware_is_exist""":"""1""","""middleware_version""":"""$middleware_version"""}"
}
else
{
    Write-Host "{"""middleware_is_exist""":"""0""","""middleware_version""":""""""}"
}

# Script Body -- END #