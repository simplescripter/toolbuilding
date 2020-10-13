# 1.7 Parameter Attributes: Mandatory Help, Aliases

# Mandatory parameters may include a help message. Aliases can be defined for any parameter

Function Test-Net {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,HelpMessage="Enter the name of a computer to check connectivity to")]
        [Alias("serverName","hostName")]
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