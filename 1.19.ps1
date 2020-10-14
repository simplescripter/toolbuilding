# 1.19 Adding Function Support for Pipeline Input

# Adding support for pipeline input

Function Test-Net {
    [CmdletBinding(DefaultParameterSetName="Computer")]
    Param(
        [Parameter(Mandatory=$true,HelpMessage="Enter the name of a computer to check connectivity to",
        ParameterSetName="Computer",
        ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)]
        [Alias("serverName","hostName")]
        [ValidateCount(1,64)]   
        [ValidateLength(1,15)]
        [ValidatePattern("^LON[a-z]{2,3}\d{1,2}")]
        [string[]]$computerName,
       
        [Parameter(Mandatory=$true,HelpMessage="Enter the IP of a computer to check connectivity to",
        ParameterSetName="IP")]
        [ValidatePattern("^((25[0-5]|2[0-4][0-9]|[01]?[0-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$")]
        [string[]]$IP,  
                        

        [ValidateSet(135,80,22,445)]
        [int]$port = 135
    )
    
    BEGIN {}
    PROCESS {
        If($PSBoundParameters.ContainsKey('IP')){
            $computerList = $IP 
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
    END {}
}