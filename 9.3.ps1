# 9.3 JEA Session Configuration Files

# Adapted from https://github.com/PowerShell/JEA/blob/master/Samples/GeneralServerMaintenance/CreateRegisterPSSC.ps1
 
$adGroupName = "JEA_General_Lev1"
$adUserName = 'Dante'
If (!(Get-ADGroup -Filter {sAMAccountName -eq $adGroupName})){
    New-ADGroup -Name $adGroupName -GroupCategory Security -GroupScope DomainLocal -Path 'OU=IT,DC=adatum,DC=com'
}
$adGroup = Get-ADGroup -Filter {sAMAccountName -eq $adGroupName}
$adUser = Get-ADUser -Filter {sAMAccountName -eq $adUserName}

Add-ADGroupMember -Identity $adGroup.SamAccountName -Members $adUser.DistinguishedName

# Specify the session configuration details
$managedEndpoint = 'LonSVR1'
$jeaModulePath = 'Program Files\WindowsPowerShell\Modules\AdatumJEA'
$moduleUNCPath = "\\$managedEndpoint\c$\$jeaModulePath"
$rcFolder = 'RoleCapabilities'
$PSSCparams = @{
    Path = "$moduleUNCPath\$rcFolder\SampleJEAConfig.pssc"
    Author = 'Microsoft and Microsoft IT'
    Description = 'This session configuration grants users access to the general and IIS server maintenance roles.'
    SessionType = 'RestrictedRemoteServer'
    TranscriptDirectory = 'C:\ProgramData\JEAConfiguration\Transcripts'
    RunAsVirtualAccount = $true
    Full = $true
    RoleDefinitions = @{
        $adGroup.Name = @{ RoleCapabilities = 'General-Lev1' }
    }
}

# Create the PSSC
New-PSSessionConfigurationFile @PSSCparams

# Open the PSSC to review it

ise "$moduleUNCPath\$rcFolder\SampleJEAConfig.pssc"