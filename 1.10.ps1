# 1.10 Parameter Validation Attributes: ValidateCount/Length/Range

Function Test-Net {
    [CmdletBinding(DefaultParameterSetName="Computer")]
    Param(
        [Parameter(Mandatory=$true,HelpMessage="Enter the name of a computer to check connectivity to",
        ParameterSetName="Computer")]
        [Alias("serverName","hostName")]
        [ValidateCount(1,64)]   # maybe we want to limit the number of computers in a single scan
        [ValidateLength(1,15)]  # and we don't want computer names longer than 15 characters
        [string[]]$computerName,

        [Parameter(Mandatory=$true,HelpMessage="Enter the IP of a computer to check connectivity to",
        ParameterSetName="IP")]
        [string[]]$IP,  
                        

        [int]$port = 135
    )
    

    If($PSBoundParameters.ContainsKey('IP')){
        $computerName = $IP 
    }
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