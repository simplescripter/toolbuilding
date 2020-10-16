# 10.1 Invoke-Command

$computers = 'LonCL1','LonSVR1','LonDC1'
help Invoke-Command -Parameter ThrottleLimit

# The -ComputerName parameter is best for ad-hoc commands
Invoke-Command -ComputerName $computers {$log = Get-EventLog -LogName Security -Newest 100;$log}
Invoke-Command -ComputerName $computers {$log} # $log is empty because a session wasn't used

$sessionAll = New-PSSession -ComputerName $computers
Invoke-Command -Session $sessionAll {$log = Get-EventLog -LogName Security -Newest 100;$log}
Invoke-Command -Session $sessionAll {$log} # $log variable is maintained in the session

Invoke-Command -Session $sessionAll {$log} | Sort PSComputerName
Invoke-Command -Session $sessionAll {$log} | Sort PSComputerName | Format-Table -GroupBy PSComputerName