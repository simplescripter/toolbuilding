# 8.8 Pushing DSC Configurations

Configuration FileServerConfig
{
    Node @('LonSVR1','LonDC1') {
        WindowsFeature FileServer {
            Name = 'FS-FileServer'
            Ensure = 'Present'
        }
        WindowsFeature DataDedup {
            Name = 'FS-Data-Deduplication'
            Ensure = 'Present'
        }
    }
}

FileServerConfig -OutputPath C:\DscConfigs
Start-DscConfiguration -Path C:\DscConfigs -Wait -Verbose