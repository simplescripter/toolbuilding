# 5.4 Adding ForEach Enumeration

$computers = 'LonSVR1','LonSVR99','LonDC1'

# Demo 1
# If the error isn't terminating, the Catch {} block won't run

Try {
    Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computers | Select-Object PSComputerName,LastBootu
} Catch {
    Write-Warning "The command on this line never runs because the error is never trapped"
}


# Demo 2
# The error is terminating, but the Try {} is "atomic" in that the entire operation succeeds or fails as a whole
# In other words, because there's an error in Try {}, none of the computers are queried

Try {
    Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computers |
        Select-Object PSComputerName,LastBootupTime -ErrorAction Stop
} Catch {
    Write-Warning "The Catch block runs, but neither of the available computers are queried because the overall command terminates after receiving an error against LonSVR99"
}

# Demo 3
# Adding ForEach enumeration allows error handling for each system individually 

ForEach ($computer in $computers) {
    Try {
        Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $computers |
            Select-Object PSComputerName,LastBootupTime -ErrorAction Stop
    } Catch {
        Write-Warning "Trapped error on $computer"
    }
}