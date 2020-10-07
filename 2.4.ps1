# 2.4

$params = @{
    TypeName = 'Microsoft.ActiveDirectory.Management.ADComputer'
    MemberType = 'ScriptProperty'
    MemberName = 'ComputerName'
}

Update-TypeData @params -Value {$this.Name}