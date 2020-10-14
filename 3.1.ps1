# 3.1 The Problem with Processing HTML

Function Get-Quote {
    Param(
        $uri = 'http://www.quotationspage.com/qotd.html',
        [ValidateRange(1,4)]
        [int]$numberOfQuotes = 4
    )
    
    $page = Invoke-WebRequest $uri
    $anchorString = 'Michael Moncur'
    $quote = $page.Content.Split("`n") | Select-String $anchorString -Context 0,7
    $quote = $quote -replace '> <div.*</div>',''
    $quote = $quote -replace '</a> </dt>.*"/quotes/\w+/">',' '
    $quote = $quote -replace '</a>.*class="author".*"/quotes/[\w\.]+/">',' '
    $quote = $quote -replace '.*class="quote".*html">',''
    $quote = $quote -replace '</dd>',''    
    $quote = $quote -replace '&nbsp;.*>',''
    $quote = $quote -replace '</[abi]>',''
    $quote = $quote -replace '<i>',''
    $quote = $quote -replace '\n\s*\n',"`n"
    $quote = $quote -replace '<br>',''
    $quote = $quote -split "`n" | Select -Skip 1
    For($i=0;$i -le $numberOfQuotes - 1;$i++){
        Write-Output $quote[$i] `n 
    }
}
