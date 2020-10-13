# 1.1  Moving from One-Liners to Scripts to Functions

# Start with a one-liner using fixed values

Test-NetConnection -ComputerName LonSVR1 -InformationLevel Quiet -WarningAction SilentlyContinue

# If the ping fails, let's try a common windows port

$pingResult = Test-NetConnection -ComputerName LonSVR1 -InformationLevel Quiet -WarningAction SilentlyContinue
If($pingResult){
    Write-Output $pingResult
}Else{
    $portResult = Test-NetConnection -ComputerName LonSVR1 -InformationLevel Quiet -WarningAction SilentlyContinue -Port 135
    Write-Output $portResult
}
