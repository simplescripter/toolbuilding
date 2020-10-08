# 3.4 Example: Invoke-ReSTMethod with Intune

$script = Invoke-WebRequest "https://raw.githubusercontent.com/microsoftgraph/powershell-intune-samples/master/ManagedDevices/ManagedDevices_Get.ps1"
$script.Content | Out-File $env:TEMP\intune.ps1
ise $env:TEMP\intune.ps1