﻿# 6.1.1 Write-Debug

Function Write-ToLog {
    Param (
        [string]$logPath = 'C:\PS\log.csv', # We've parameterized $logPath

        [string]$logData
    )

    $properties = @{
        Date = (Get-Date)
        Data = $logData
    }
    New-Object -TypeName psobject -Property $properties | Export-Csv -NoTypeInformation -Append -Path $logPath 
}

Function Get-OSReleaseID {
    [CmdletBinding()]
    Param (
        [Parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [string[]]$computerName = 'localhost',

        [switch]$logIt
    )
    Process {
        $HKLM = 2147483650
        $key = "SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        $releaseID = "ReleaseId"
        $productName = "ProductName"
        ForEach($computer in $computerName){
            $ok = $true
            Try{
                $wmi = [wmiclass]"\\$computer\root\default:stdRegProv"
                If($logIt){
                    Write-ToLog "$computer reachable over WMI"
                }
            }Catch{
                $ok = $false
                If($logIt){
                    Write-ToLog "FAILED connecting to $computer over WMI"
                }
            }
            If($ok){
                $releaseIDValue = ($wmi.GetStringValue($HKLM,$key,$releaseID)).sValue
                $productNameValue = ($wmi.GetStringValue($HKLM,$key,$productName)).sValue
                $properties = @{
                    ComputerName = $computer
                    ProductName = $productNameValue
                    ReleaseID = $releaseIDValue
                }
                $return = New-Object -TypeName PSObject -Property $properties
                Write-Output $return
                If($logIt){
                    Write-ToLog $return
                }
            }Else{
                $properties = @{
                    ComputerName = $computer
                    ProductName = 'UNKNOWN'
                    ReleaseID = 'UNKNOWN'
                }
                $return = New-Object -TypeName PSObject -Property $properties
                Write-Output $return
                If($logIt){
                    Write-ToLog $return
                }
            }
        }
    }
}

Get-OSReleaseID -computerName LonSVR1,LonDC1 -logIt # the details don't get logged as we expect