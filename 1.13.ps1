# 1.13 Dynamic Parameter Example

Function Test-Net {
    [CmdletBinding(DefaultParameterSetName="Computer")]
    Param(
        [ValidateSet(135,80,22,445)] # ValidateSet allows us to hard-code a list of possible values
        [int]$port = 135
    )
    DynamicParam {
            # Set the dynamic parameters' name
            $ParameterName = 'ComputerName'
            
            # Create the dictionary 
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

            # Create the collection of attributes
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            
            # Create and set the parameters' attributes
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Mandatory = $true
            $ParameterAttribute.Position = 1
            # Add the attributes to the attributes collection
            $AttributeCollection.Add($ParameterAttribute)

            # Generate and set the ValidateSet 
            $arrSet = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name
            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

            # Add the ValidateSet to the attributes collection
            $AttributeCollection.Add($ValidateSetAttribute)

            # Create and return the dynamic parameter
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string[]], $AttributeCollection)
            $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
            return $RuntimeParameterDictionary
    }
    Begin{
        # Bind the parameter to a friendly variable
        $ComputerName = $PsBoundParameters[$ParameterName]
    }
    Process{
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
}