# 1.2 Why Parameterize My Code?

# The $args automatic variable can be used as a kind of "un-named" parameter to accept input to our code
# Using a ForEach enumeration for the $args collection has the added benefit of allowing us to test
# connectivity to more than one system using Test-NetConnection

ForEach ($computer in $args){
    $pingResult = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue
    If($pingResult){
        Write-Output $pingResult
    }Else{
        $portResult = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue -Port 135
        Write-Output $portResult
    }
}


# run the script like this: Script.ps1 Computer1 Computer2
