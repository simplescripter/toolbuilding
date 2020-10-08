# 1.5 Parameterizing My Code (Continued)

# With static values, we need to change the computer name and port number in the script

Function Test-Net {
    [CmdletBinding()]
    Param(
        [string[]]$computerName,

        [int]$port = 135
    )
    ForEach ($computer in $computerName){
        Write-Verbose "Now testing $computer"
        $pingResult = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue
        If($pingResult){
            Write-Output $pingResult
        }Else{
            Write-Verbose "Ping failed. Checking port..."
            $portResult = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue -Port $port
            Write-Output $portResult
        }
    }
}

Test-Net LON-DC1,LON-SVR1