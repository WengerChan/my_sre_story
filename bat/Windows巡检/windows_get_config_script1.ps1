$OutputPath = $env:temp
$ErrLogPath = $env:temp
$date=Get-Date -Format "yyyyMMddHHmm"

[string[]]$ErrStrs = @()

function Get-NetAdapterConfig
{
    param
    (
        [string]$ComputerName = $env:COMPUTERNAME
    )

    $NetObjs = @()

    $AdapterConfigs = Get-WmiObject win32_networkadapterconfiguration | Select-Object -Property IPAddress,Description,MacAddress,InterfaceIndex | Where {$_.IPAddress -NE $null}
    if($AdapterConfigs)
    {
        foreach($cfg in $AdapterConfigs)
        {
            # get NIC Name
            $Interface_Str = Netsh int ipv4 show int $cfg.InterfaceIndex
            if(($Interface_Str[1] -match '接口') -or ($Interface_Str[1] -match 'Interface'))
            {
               $StrToList = [System.Collections.ArrayList]$Interface_Str[1].split(' ')
               $StrToList.RemoveAt(0)
               $StrToList.RemoveAt($StrToList.count-1)
               $NICName = $StrToList -join " "
            }

            #get NetAdapter Speed
            #$Speed_Info = Get-WmiObject win32_networkadapter | Select-Object -Property Name,MacAddress,@{Label='Speed(GB)';Expression={$_.speed/1GB}} | Where {$_.MacAddress -EQ $cfg.MacAddress}
            $Speed_Info = Get-WmiObject win32_networkadapter | Select-Object -Property Name,MacAddress,Speed | Where {($_.MacAddress -EQ $cfg.MacAddress) -and ($_.Name -EQ $cfg.description)}
            $Speed = $Speed_Info.Speed/1GB

            foreach($ip in $cfg.IPAddress)
            {
                if(($ip -like '10.*') -or ($ip -like '192.168.*') -or ($ip -like '172.*'))
                {
                    $Properties = @{
                        IPAddress = $ip
                        AdapterDescription = $cfg.Description
                        MAC = $cfg.MacAddress
                        NICName = $NICName
                        'Speed(GB)' = $Speed.ToString("#.####")}

                    $NetObjs += New-Object PSObject -Property $Properties
                }
            }
        }

        $NetObjs = $NetObjs | Select-Object IPAddress,MAC,'Speed(GB)',NICName,AdapterDescription

    }
    else
    {
        $ErrStrs += "[NetAdapterConfig Error]: No Net Adapter info can be found in $ComputerName."
        ExportObjsToCSV -objs $ErrStrs -filepath $ErrLogPath -filename "error_log_$date.txt"
    }

    return $NetObjs
}


function Get-HBAWin
{
    param(
    [String]$Computer = $ENV:ComputerName
    )

    $HBAs = @()

    $Params = @{
	    Namespace    = 'root\WMI'
	    class        = 'MSFC_FCAdapterHBAAttributes'
	    ComputerName = $Computer
	    ErrorAction  = 'Stop'
	    }

	try
    {
        $HBAConfigs = Get-WmiObject @Params
    }Catch{
	    # Write-Warning -Message "$Computer is not supported or has no HBA."
        $ErrStrs += "[HBA Error]: No HBA info can be found in $Computer"
        ExportObjsToCSV -objs $ErrStrs -filepath $ErrLogPath -filename "error_log_$date.txt"
    }

    if($HBAConfigs)
    {
        $HBAConfigs | ForEach-Object {
		    $hash=@{
			    NodeWWN          = (($_.NodeWWN) | ForEach-Object {"{0:X2}" -f $_}) -join ":"
			    Active           = $_.Active
			    AdapterDescription = $_.ModelDescription
			    }

		    $HBAs += New-Object psobject -Property $hash
	    }#Foreach-Object(Adapter)

        $HABs = $HABAs | Select-Object NodeWWN,Active,AdapterDescription
    }

    return $HBAs
}

function ExportObjsToCSV
{
    Param
    (
        [Parameter(Mandatory=$true)]
        [PSObject]$objs,

        [Parameter(Mandatory=$true)]
	    [String]$filepath,

        [Parameter(Mandatory=$true)]
	    [String]$filename
    )

    If(!(test-path $filepath))
    {
        New-Item -ItemType Directory -Force -Path $filepath
    }

    if($filename -like '*.csv')
    {
        $objs| Export-Csv -Path $filepath'\'$filename -NoTypeInformation -Encoding UTF8
    }
    elseif($filename -like '*.txt')
    {
        $objs | Out-File -FilePath $filepath'\'$filename -Encoding UTF8
    }


}

###################################################################################################
$NetObjs = Get-NetAdapterConfig
$HBAs = Get-HBAWin

$head_str = '@net_obj@'
Write-Host $head_str
if($NetObjs)
{
    # Write-Host $NetObjs
    $ip = ''
    $bk_mac = ''
    Foreach($item in $NetObjs)
    {
        # Write-Host $item
        $IPAddress = $item.IPAddress
        $MAC = $item.MAC
        $ip = $IPAddress,$ip -join ";"

        if ($bk_mac -match $MAC)
        {
            # How are you?
        }
        else
        {
            $bk_mac = $MAC,$bk_mac -join ";"
        }
    }
    Write-Host ip=$ip
    Write-Host bk_mac=$bk_mac
}
if($HBAs)
{
    # Write-Host $HBAs
}
$end_str = '@end@'
Write-Host $end_str
