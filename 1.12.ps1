# 1.12 Parameter Validation Attributes: ValidateSet and "enum"

Function Test-Net {
    [CmdletBinding(DefaultParameterSetName="Computer")]
    Param(
        [Parameter(Mandatory=$true,HelpMessage="Enter the name of a computer to check connectivity to",
        ParameterSetName="Computer")]
        [Alias("serverName","hostName")]
        [ValidateCount(1,64)]   
        [ValidateLength(1,15)]
        [ValidatePattern("^LON[a-z]{2,3}\d{1,2}")]  # only allow computer names that match our environment
        [string[]]$computerName,
       
        [Parameter(Mandatory=$true,HelpMessage="Enter the IP of a computer to check connectivity to",
        ParameterSetName="IP")]
        [ValidatePattern("^((25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")] # or valid IPs
        [string[]]$IP,  
                        

        [ValidateSet(135,80,22,445)] # ValidateSet allows us to hard-code a list of possible values
        [int]$port = 135
    )
    

    If($PSBoundParameters.ContainsKey('IP')){
        $computerList = $IP # we also need to store the list in a variable other than $computerName now because
                            # the $computerName variable is restricted to our naming pattern
    }Else{
        $computerList = $computerName
    }
    ForEach ($computer in $computerList){
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