# 9.4 Registering and Using JEA

$managedEndpoint = 'LonSVR1'
$configName = 'adatum.generalserver.level1'
$jeaModulePath = 'Program Files\WindowsPowerShell\Modules\AdatumJEA'
$rcFolder = 'RoleCapabilities'
$jeaSessionConfigName = 'SampleJEAConfig.pssc'
$jeaSessionConfigFile = Join-Path "c:\$jeaModulePath\$rcFolder" $jeaSessionConfigName
Invoke-Command -ComputerName $managedEndpoint -ScriptBlock {
    Register-PSSessionConfiguration -Path $using:jeaSessionConfigFile -Name $using:configName}

$creds = Get-Credential -Message "Enter your credentials" -UserName 'Adatum\Dante'
Enter-PSSession -ComputerName $managedEndpoint -ConfigurationName $configName -Credential $creds