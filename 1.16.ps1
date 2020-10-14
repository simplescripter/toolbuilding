# 1.16 Module manifests
 
$params = @{
    Path = 'C:\Users\Shawn.ADATUM\Documents\WindowsPowerShell\Modules\PSLib\PSLib.psd1'
    RootModule = 'C:\Users\Shawn.ADATUM\Documents\WindowsPowerShell\Modules\PSLib\PSLib.psm1'
    Author = 'Admin'
    ModuleVersion = '1.0.0'
    Description = "A library of internal Powershell functions"
}
New-ModuleManifest @params
 
Test-ModuleManifest 'C:\Users\Shawn.ADATUM\Documents\WindowsPowerShell\Modules\PSLib\PSLib.psd1'
