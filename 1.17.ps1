# 1.17 Publishing modules internally

Invoke-Command LonSvr1 {
    New-Item -Name C:\PSRepo -ItemType Directory
    New-SmbShare -Path C:\PSRepo -Name PSRepo -FullAccess Everyone
}
$networkShare = "\\LonSvr1\PSRepo"
$repo = @{
    Name = 'MyRepo'
    SourceLocation = $networkShare
    PublishLocation = $networkShare
    InstallationPolicy = 'Trusted'
}
Register-PSRepository @repo
Find-Module -Repository 'MyRepo'
$publishModuleSplat = @{
Repository = 'MyRepository'
Path = '.\MyModule'
}
Publish-Module @publishModuleSplat