# 10.2 Background Jobs

For($i = 1;$i -le 10;$i++){
    Start-Job -ScriptBlock {dir C:\ -Recurse}
}