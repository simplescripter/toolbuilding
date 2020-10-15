Publish-DscConfiguration -Path C:\DscConfigs\EnvVars
Publish-DscConfiguration -Path C:\DscConfigs\Registry
Start-DscConfiguration -UseExisting -ComputerName 'localhost'

Get-ItemProperty -Path 'HKLM:\Software\CustomRegKey'
[Environment]::GetEnvironmentVariable("CustomEnvVar","Machine")
