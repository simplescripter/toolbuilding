# 10.3.2 Workflows Continued

Workflow PingSweep{
    $computers = @()
    For ($i = 1; $i -le 50; $i++){$computers += "172.16.0.$i"}
    ForEach -Parallel ($computer in $computers){
        If(Test-NetConnection -computerName $computer -InformationLevel Quiet -WarningAction SilentlyContinue){
            Write-Output -InputObject "$computer,ONLINE"
        }else{
            Write-Output -InputObject "$computer,OFFLINE"
        }
    }
}

PingSweep | ForEach{
    $ip = $_.Split(",")[0]
    $status = $_.Split(",")[1]
    If($status -eq 'ONLINE'){
        Write-Host "$ip" -ForegroundColor Green
    }Else{
        Write-Host "$ip" -ForegroundColor Red
    }
}
