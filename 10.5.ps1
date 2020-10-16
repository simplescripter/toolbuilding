# 10.5 .Net Runspaces

Find-Command Invoke-Parallel

Install-Module WFTools

1..50 | Invoke-Parallel -Throttle 32 -ScriptBlock {
    If(Test-Connection "172.16.0.$_" -Count 1 -Quiet){
        Write-Host "172.16.0.$_`n" -ForegroundColor Green -NoNewline
    }Else{
        Write-Host "172.16.0.$_`n" -ForegroundColor Red -NoNewline
    }
}