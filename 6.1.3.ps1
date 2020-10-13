# 5.8.3 Write-Debug Continued: Fixed

Function Write-ToLog {
    Param (
        [string]$logPath = 'D:\scratchspace\log.csv',

        [string]$logData        
    )

    $properties = @{
        Date = (Get-Date)
        Data = $logData
    }
    Write-Debug "Attempting to write to log" # this is new
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
            Write-Debug "Attempting to connect to $computer" # this is new
            $ok = $true
            Try{
                $wmi = [wmiclass]"\\$computer\root\default:stdRegProv"
                If($logIt){
                    Write-ToLog -logData "$computer reachable over WMI"
                }
            }Catch{
                $ok = $false
                If($logIt){
                    Write-ToLog -logData "FAILED connecting to $computer over WMI"
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
                    Write-ToLog -logData $return
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
                    Write-ToLog -logData $return
                }
            }
        }
    }
}

Get-OSReleaseID -computerName LonSVR1,LonDC1 -logIt # the command should succeed