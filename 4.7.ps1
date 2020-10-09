﻿# 4.7 ConvertTo-HTML Fragments for Multi-section Reports

#requires -module PSLib

[CmdletBinding()]
Param(
    [Parameter(ValueFromPipeline=$true)]
    [string[]]$computerName = 'localhost',

    [string]$reportDir = 'C:\Reports'
)
Begin{
If(-not (Test-Path $reportDir)){
    New-Item -Path $reportDir -ItemType Directory
}
$style = @"
    <style>
    body {
        font-family:Segoe,Tahoma,Arial,Helvetica;
        font-size:10pt;
        color:#333;
        background-color:#eee;
        margin:10px;
    }
    th {
        font-weight:bold;
        color:white;
        background-color:#333;
    }
    </style>
"@
}
Process {
    ForEach ($computer in $computerName){
        If(-not (Test-Net -computerName $computer).Reachable){
            # ConvertTo-Html only converts objects, so we'll create one:
            $properties = @{
                computer = $computer
                status = 'OFFLINE'
            }
            $result = New-Object -TypeName psobject -Property $properties
            $result | ConvertTo-Html -Title "Windows Services: $computer" -Body (get-date) `
                -Head $style -Pre "<P>Generated by Corporate IT</P>" -Post "For details, contact Corporate IT." |
                Out-File (Join-Path -Path $reportDir -ChildPath "$computer.html")
        }Else{
            $bios = Get-WMIObject -Class Win32_BIOS -ComputerName $computer |
                 Select-Object -Property Manufacturer,Version,SMBIOSBIOSVersion,SerialNumber |
                 ConvertTo-HTML -Fragment -As List -PreContent "<h2>BIOS Info</h2>" |
                 Out-String
            $services = Get-Service -ComputerName $computer | Select-Object ServiceName,DisplayName,StartType,Status |
                 ConvertTo-HTML -Fragment -As Table -PreContent "<h2>Services</h2>" |
                 Out-String

            ConvertTo-Html -Title "Windows Services: $computer" -Body (get-date),$bios,$services `
            -Head $style -Pre "<P>Generated by Corporate IT</P>" -Post "For details, contact Corporate IT." |
            Out-File (Join-Path -Path $reportDir -ChildPath "$computer.html")
        }
        
    }
}