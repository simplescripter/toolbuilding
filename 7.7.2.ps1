Get-Item -Path '\\LON-DC1\Netlogon' | Out-Null

$netstatOutput = netstat -p tcp 
$netstatOutput

$template = @"

Active Connections

  Proto  Local Address          Foreign Address        State
  {Proto*:TCP}    {LocalAddress:192.168.0.40:53119}     {ForeignAddress:msnbot-65-52-108-201:https}  {State:ESTABLISHED}  {Proto*:TCP}    {LocalAddress:192.168.0.40:64400}     {ForeignAddress:SVR01:microsoft-ds}     {State:ESTABLISHED}"@$netstatConverted = $netstatOutput | ConvertFrom-String -TemplateContent $template$netstatConverted$netstatConverted | Where-Object -Property 'ForeignAddress' -Like 'LON-DC1:*'