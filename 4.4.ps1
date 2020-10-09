# 4.4 Using Switch for a menu

$menu = @"
**************************************************************************
Make a selection

p = Display processes consuming the most memory
o = Display processes by manufacturer
s = Display running services
h = Display installed hotfixes
x = Exit this menu

**************************************************************************


"@

Do{
    cmd /c color 71
    $selection = Read-Host -Prompt $menu
    Clear-Host
    Switch ($selection){
        p {
            Get-Process | Sort-Object WS -Descending | Select-Object -first 10 | Format-Table
            pause
        }
        o {
            Get-Process | Sort-Object Company | Format-Table -GroupBy Company
            pause
        }
        s {
            Get-Service | Where-Object Status -eq Running | Format-Table
            pause
        }
        h {
            Get-HotFix | Format-Table HotfixID,InstalledOn -AutoSize
            pause
        }
        Default {
            Write-Host "That is not a valid selection.  Try again."  -ForegroundColor DarkGray -BackgroundColor DarkRed
        }
    }
}Until ($selection -eq "x")
Switch ($PSVersionTable.PSEdition){
    'Core' {cmd /c color 07}
    'Desktop' {cmd /c color 56}
    Default {cmd /c color 56}
}
Clear-Host
