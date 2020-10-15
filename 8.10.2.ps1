Configuration EnvVarsConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Environment CustomEnvVar
    {
        Ensure = 'Present'
        Name = 'CustomEnvVar'
        Value = '1'
    }
}

Configuration RegistryConfig
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Registry RegValue
    {
        Ensure = 'Present'
        Key = 'HKEY_LOCAL_MACHINE\SOFTWARE\CustomRegKey'
        ValueName = 'CustomRegVal'
        ValueData = '1'
    }
}

EnvVarsConfig -OutputPath C:\DscConfigs\EnvVars
RegistryConfig -OutputPATH C:\DscConfigs\Registry
