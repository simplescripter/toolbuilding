# 7.3 Modifying XML

Function Update-Assay {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$xml,

        [string]$outputPath
    )
    [XML]$xml = Get-Content $xml
    ForEach ($computer in $xml.computers.computer) {
        $osInfo = Get-Ciminstance -ClassName Win32_OperatingSystem -ComputerName $computer.name
        If ($computer.hasChildNodes) {
            $sysinfo = $computer.SelectSingleNode('sysinfo')
            $computer.RemoveChild($sysinfo) | Out-Null
        }

        $sysinfo = $xml.CreateElement('element','sysinfo','')
        $sysinfo.InnerText = $osInfo.Caption

        $serial = $xml.CreateAttribute('SerialNumber')
        $version = $xml.CreateAttribute('Version')
        $lastboot = $xml.CreateAttribute('LastBootUpTime')

        $sysinfo.SetAttributeNode($serial) | Out-Null
        $sysinfo.SetAttributeNode($version) | Out-Null
        $sysinfo.SetAttributeNode($lastboot) | Out-Null

        $sysinfo.SerialNumber = [string]$osInfo.SerialNumber
        $sysinfo.Version = [string]$osInfo.Version
        $sysinfo.LastBootUpTime = [string]$osInfo.LastBootUpTime

        $computer.AppendChild($sysinfo) | Out-Null
    }

    $xml.Save($OutputPath)

}

Update-Assay -xml C:\assay.xml -OutputPath C:\assay-new.xml