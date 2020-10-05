# With static values, we need to change the computer name and port number in the script

Param (
    [string]$computerName,
    [int]$port = 135
)

$pingResult = Test-NetConnection -ComputerName $computerName -InformationLevel Quiet -WarningAction SilentlyContinue
If($pingResult){
    Write-Output $pingResult
}Else{
    $portResult = Test-NetConnection -ComputerName $computerName -InformationLevel Quiet -WarningAction SilentlyContinue -Port 135
    Write-Output $portResult
}