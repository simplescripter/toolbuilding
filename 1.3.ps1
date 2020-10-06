# 1.3

# Functions are a way of writing your own PowerShell commands using PowerShell's language

# Advanced functions use the CmdletBinding attribute to identify them as functions that act similar to cmdlets
# An advanced function requires the Param() block, even if it's empty

Function Test-Net {
    ForEach ($computer in $args){
        $pingResult = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue
        If($pingResult){
            Write-Output $pingResult
        }Else{
            $portResult = Test-NetConnection -ComputerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue -Port 135
            Write-Output $portResult
        }
    }
}

Test-Net LON-DC1 LON-SVR1 # call the function to execute it