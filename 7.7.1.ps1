# 7.7.1 Working with Non-structured Data: ConvertFrom-String

# Credit to Don Jones and Jeffrey Hicks for the example

Get-Item -Path '\\LonDC1\Netlogon' | Out-Null

$netstatOutput = netstat -p tcp 
$netstatOutput

$netstatConverted = ($netstatOutput[4..$netstatOutput.Count]).Trim() | 
                ConvertFrom-String -Delimiter '[ ]{2,}' `
                                   -PropertyNames Proto,LocalAddress,ForeignAddress,State
$netstatConverted

$netstatConverted | Where-Object -Property 'ForeignAddress' -Like 'LonDC1:*' 