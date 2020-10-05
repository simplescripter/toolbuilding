# Parameter sets are mutually exclusive

Function Test-Net {
    [CmdletBinding(DefaultParameterSetName="Computer")]
    Param(
        [Parameter(Mandatory=$true,HelpMessage="Enter the name of a computer to check connectivity to",
        ParameterSetName="Computer")]
        [Alias("serverName","hostName")]
        [string[]]$computerName,

        # For the time being, we're adding the IP parameter to demonstrate Parameter Sets, but to put IP to 
        # use, we'd need to reference the parameter in our code below

        [Parameter(Mandatory=$true,HelpMessage="Enter the IP of a computer to check connectivity to",
        ParameterSetName="IP")]
        [string[]]$IP,

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