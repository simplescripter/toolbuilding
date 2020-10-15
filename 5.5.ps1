# 5.5 Multiple Catch {} Blocks

$operation = 1

Try {
    Switch ($operation) {
        1 {Get-Coffee -For 'Me'}
        2 {Get-Item D:\none.txt -ErrorAction Stop}
        3 {throw "another error"}
    }
} Catch [System.Management.Automation.CommandNotFoundException]{
    Write-Warning "That command doesn't exist"
} Catch [System.Management.Automation.ItemNotFoundException]{
    Write-Warning "Can't find file"
} Catch {
    Write-Warning "Unspecified error"
}