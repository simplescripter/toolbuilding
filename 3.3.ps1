# 3.3 Invoke-RestMethod

# Demo 1

Function Get-OctoCatWisdom {
    # ReST Demo

    # Many sites, including GitHub, now require TLS 1.2 or greater, so let's enable it:
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $url = 'https://api.github.com/octocat'
    Invoke-RestMethod $url
}

# Demo 2

$apiKey = 'fe5c2a60e7255b20b113c52187629653'

$uri = "api.openweathermap.org/data/2.5/weather?q=Denver,us&mode=json&APPID=$apiKey"

$results = Invoke-RestMethod $uri

Function ConvertFrom-Kelvin {
    Param(
        [double]$temp
    )
    ($temp -273.15) * 9/5 + 32 
}
