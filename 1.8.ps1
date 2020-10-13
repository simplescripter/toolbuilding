# 1.8 Parameter Attributes: ParameterSetName and Position

# Parameter sets are mutually exclusive

Function Test-Net {
    [CmdletBinding(DefaultParameterSetName="Computer")]
    Param(
        [Parameter(Mandatory=$true,HelpMessage="Enter the name of a computer to check connectivity to",
        ParameterSetName="Computer")]
        [Alias("serverName","hostName")]
        [string[]]$computerName,

        [Parameter(Mandatory=$true,HelpMessage="Enter the IP of a computer to check connectivity to",
        ParameterSetName="IP")]
        [string[]]$IP,  # We're adding the IP parameter to demonstrate Parameter Sets, but to put IP to 
                        # use, we need to reference the parameter in our code below

        [int]$port = 135
    )
    # The $PSBoundParameters variable Contains a dictionary of the parameters that are passed to a script
    # or function and their current values. We can check the keys of the hash table to see if the $IP parameter
    # was used:

    If($PSBoundParameters.ContainsKey('IP')){
        $computerName = $IP # populate the $computerName variable with the $IPs
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