# 7.4 Working with JSON

# PowerShell objects can be converted to JSON format

$jSONservices = Get-Service | ConvertTo-Json
$jSONservices
$jSONservices | Out-File C:\services.json
Get-Content C:\services.json | ConvertFrom-Json

# Azure resources are defined using JSON syntax
# We can import an Azure template and convert
# the JSON into PowerShell objects

$json = Get-Content C:\Users\Shawn.ADATUM\Documents\GitHub\toolbuilding\template.json | ConvertFrom-Json
$json
$json.resources
$json.resources[0]
$json.resources[0].properties
$json.resources[0].properties.hardwareProfile