# 8.4 Demo: LCM Configuration

[DSCLocalConfigurationManager()]
Configuration LCMConfig
{
    Node @('LonCL1','LonSVR1','LonDC1') {
        Settings {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            ConfigurationModeFrequencyMins = 30
            RefreshMode = 'Push'
        }
    }
}

LCMConfig -OutputPath C:\LCMConfigs
Set-DscLocalConfigurationManager -Path C:\LCMConfigs