# start with a one-liner using fixed values

Test-NetConnection -ComputerName LON-SVR1 -InformationLevel Quiet -WarningAction SilentlyContinue

# If the ping fails, let's try a common windows port

$pingResult = Test-NetConnection -ComputerName LON-SVR1 -InformationLevel Quiet -WarningAction SilentlyContinue
If($pingResult){
    Write-Output $pingResult
}Else{
    $portResult = Test-NetConnection -ComputerName LON-SVR1 -InformationLevel Quiet -WarningAction SilentlyContinue -Port 135
    Write-Output $portResult
}
