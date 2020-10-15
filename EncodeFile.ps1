Function Encode-File {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline=$true,Mandatory=$true)]
        [string[]]$file
    )
    Begin{
    $html1 = @"
            <td><img border=0 alt="image"
            src="data:image/jpeg;base64,
"@
    $html2 = @"
            "></td>
"@ 
    }
    Process{
        $Base64 = [convert]::ToBase64String((Get-Content $file -Encoding Byte))
            Write-Output $html1,$Base64,$html2
    }
}