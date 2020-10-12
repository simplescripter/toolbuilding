# 1.4 Adding Verbose Output

# Add verbose messages with Write-Verbose

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
            Write-Verbose "Ping failed on $computer. Checking port $port..."
            $portResult = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue -Port $port
            Write-Output $portResult
        }
    }
}

Test-Net LonDC1,LonSVR1,LonSVR2 -Verbose # call the function with the -Verbose parameter