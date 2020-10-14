# 1.17 Publishing Modules Internally

Invoke-Command LonSvr1 {
    New-Item C:\PSRepo -ItemType Directory
    New-SmbShare -Path C:\PSRepo -Name PSRepo -FullAccess Everyone
}
$networkShare = "\\LonSvr1\PSRepo"
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
$repo = @{
    Name = 'MyRepo'
    SourceLocation = $networkShare
    PublishLocation = $networkShare
    InstallationPolicy = 'Trusted'
}
Register-PSRepository @repo

$publishModuleSplat = @{
    Repository = 'MyRepo'
    Path = 'C:\Users\Shawn.ADATUM\Documents\WindowsPowerShell\Modules\PSLib'
}
Publish-Module @publishModuleSplat

Find-Module -Repository 'MyRepo'