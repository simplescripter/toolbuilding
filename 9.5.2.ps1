# 9.5.2 Demo: DSC and JEA Continued

# Adapted from General Server Maintenance Demo Config.ps1 sample # at https://github.com/dsccommunity/JeaDsc/tree/master/SamplesConfiguration GeneralServerMaintenance
{
    Param(
        [string[]]$computerName
    )
    Import-DscResource -Module JeaDsc

    Node $computerName {
        File StartupScript
        {
            DestinationPath = 'C:\ProgramData\GeneralServerMaintenance\Startup.ps1'
            Contents        = @'
    Write-Host 'General Server Maintenance Endpoint' -ForegroundColor Green
'@
            Ensure          = 'Present'
            Type            = 'File'
            Force           = $true
        }

        JeaRoleCapabilities GenleralLevel1
        {
            Path                    = 'C:\Program Files\WindowsPowerShell\Modules\GeneralServerMaintenance\RoleCapabilities\GeneralLevel1.psrc'
            Description             = 'This role capability exposes basic networking, security, and configuration settings for the local server.'
            VisibleCmdlets          = 'Get-WindowsFeature',
                                      'Get-HotFix',
                                      'Defender\*',
                                      'NetAdapter\*',
                                      'NetConnection\*',
                                      'NetSecurity\Get-*',
                                      'NetTCPIP\*',
                                      'Clear-DnsClientCache',
                                      'Set-DnsClientServerAddress',
                                      'Resolve-DnsName',
                                      'Get-Service',
                                      'Restart-Service',
                                      'Get-Process',
                                      'Stop-Process',
                                      'Get-SystemInfo',
                                      'Restart-Computer',
                                      'Test-Connection',
                                      'Microsoft.PowerShell.LocalAccounts\Get-*'
            VisibleExternalCommands = 'C:\Windows\System32\gpupdate.exe', 'C:\Windows\System32\gpresult.exe'
        }

        JeaSessionConfiguration GeneralServerMaintenanceEndpoint
        {
            Name                = 'GeneralServerMaintenance'
            TranscriptDirectory = 'C:\ProgramData\GeneralServerMaintenance\Transcripts'
            ScriptsToProcess    = 'C:\ProgramData\GeneralServerMaintenance\Startup.ps1'
            DependsOn           = '[JeaRoleCapabilities]GenleralLevel1' #, '[JeaRoleCapabilities]GenleralLevel2', '[JeaRoleCapabilities]IisLevel1', '[JeaRoleCapabilities]IisLevel2'
            SessionType         = 'RestrictedRemoteServer'
            RunAsVirtualAccount = $true
            RoleDefinitions     = "@{
                'Adatum\JEA_General_Lev1' = @{ RoleCapabilities = 'GeneralLevel1' }
            }"
        }
    }
}

Remove-Item -Path C:\DscTest\* -ErrorAction SilentlyContinue
GeneralServerMaintenance -OutputPath C:\DscTest -Verbose -computerName LonSvr1

Start-DscConfiguration -Path C:\DscTest -Wait -Verbose -Force

# Enter-PSSession LonSVR1 -ConfigurationName GeneralServerMaintenance -Credential $creds