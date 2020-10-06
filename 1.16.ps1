# 1.16 Module manifests
 
$params = @{
    Path = 'C:\Users\Administrator.ADATUM\Documents\WindowsPowerShell\Modules\PSLib\PSLib.psd1'
    RootModule = 'C:\Users\Administrator.ADATUM\Documents\WindowsPowerShell\Modules\PSLib\PSLib.psm1'
    Author = 'Admin'
    ModuleVersion = '1.0.0'
    Description = "A library of internal Powershell functions"
}
New-ModuleManifest @params
 
Test-ModuleManifest 'C:\Users\Administrator.ADATUM\Documents\WindowsPowerShell\Modules\PSLib\PSLib.psd1'