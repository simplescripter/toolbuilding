# 2.4

$params = @{
    TypeName = 'Microsoft.ActiveDirectory.Management.ADComputer'
    MemberType = ScriptProperty
    MemberName = ComputerName
    Value = "{$this.Name}"
}

Update-TypeData @params