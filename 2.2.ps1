# 2.2 Using Static Members

$pi = [Math]::PI
[Math]::Round($pi,4)

[System.Environment]::MachineName

[Security.Principal.WindowsBuiltInRole]:: # <tab><tab> etc, or
[Security.Principal.WindowsBuiltInRole] | Get-Member -Static


[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12