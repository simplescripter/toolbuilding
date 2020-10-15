[DSCLocalConfigurationManager()]
configuration PartialConfig
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Push'
            ConfigurationMode = 'ApplyandAutoCorrect'
        }
        PartialConfiguration EnvVarsConfig
        {
            Description = 'Custom Environment variable'
            RefreshMode = 'Push'
        }
        PartialConfiguration RegistryConfig
        {
            Description = 'Custom Registry Value'
            RefreshMode = 'Push'
        }       
    }
} 

PartialConfig -OutputPath C:\DscConfigs\Partial
Set-DscLocalConfigurationManager -Path C:\DscConfigs\Partial