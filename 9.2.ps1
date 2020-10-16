# 9.2 JEA Role Capability Files

$demoPath = 'C:\users\Shawn.ADATUM\Documents\GitHub\toolbuilding'
$roleName = 'General-Lev1.psrc'

$roleFilePath = "$demoPath\$roleName"

$managedEndpoint = 'LonSVR1'
$jeaModulePath = 'Program Files\WindowsPowerShell\Modules\AdatumJEA'
$moduleUNCPath = "\\$managedEndpoint\c$\$jeaModulePath"
If (!(Test-Path -Path $moduleUNCPath)){
    New-Item -Path $moduleUNCPath -ItemType Directory
}

$moduleName = 'AdatumJEA.psm1'
$moduleManifestName = 'AdatumJEA.psd1'
New-Item -Path (Join-Path $moduleUNCPath $moduleName) -ErrorAction SilentlyContinue
New-ModuleManifest -Path "$(Join-Path $moduleUNCPath $moduleManifestName)" -RootModule $moduleUNCPath -ErrorAction SilentlyContinue

$rcFolder = 'RoleCapabilities'
$rcFolder = Join-Path $moduleUNCPath $rcFolder
If (!(Test-Path -Path $rcFolder)){
    New-Item -Path $rcFolder -ItemType Directory -ErrorAction SilentlyContinue
}
Copy-Item -Path $roleFilePath -Destination $rcFolder -Force
