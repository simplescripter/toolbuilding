# 2.4 Add-Type and Update-TypeData

$params = @{
    TypeName = 'Microsoft.ActiveDirectory.Management.ADComputer'
    MemberType = 'ScriptProperty'
    MemberName = 'ComputerName'
}

Update-TypeData @params -Value {$this.Name}