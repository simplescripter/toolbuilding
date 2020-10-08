# 2.4 Add-Type and Update-TypeData

# Demo 1

# The Add-Type cmdlet lets you define a Microsoft .NET Framework class in your Windows PowerShell session. 
# You can specify the type by specifying an existing assembly or source code files, or you can specify the 
# source code inline or saved in a variable

# Demo 1: Winforms

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(400,400)
$Form.text                       = "Form"
$Form.TopMost                    = $false

[void]$Form.ShowDialog()

# Demo 2

$params = @{
    TypeName = 'Microsoft.ActiveDirectory.Management.ADComputer'
    MemberType = 'ScriptProperty'
    MemberName = 'ComputerName'
}

Update-TypeData @params -Value {$this.Name}