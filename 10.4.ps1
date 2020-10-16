# 10.4 PowerShell 7+ ForEach-Object -Parallel

#requires -version 7

1..50 | ForEach-Object -Parallel {
    If(Test-NetConnection -computerName "172.16.0.$_" -InformationLevel Quiet -WarningAction SilentlyContinue){
            Write-Host "172.16.0.$_`n" -ForegroundColor Green -NoNewline
    }Else{
        Write-Host "172.16.0.$_`n" -ForegroundColor Red -NoNewline
    }
}
