# 2.2 Using Static Members

[Math]::PI
[Math]::Round(number,decimal_places)

[Security.Principal.WindowsBuiltInRole]:: <tab><tab> etc, or
[Security.Principal.WindowsBuiltInRole] | Get-Member -Static


# 2.	Using the System.Environment class, display the current computer name.
[System.Environment]::MachineName

# Lots of web services now require TLS 1.2 or greater:

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12