# 7.2.1 Importing and Searching XML

# Read the content as strings with Get-Content and cast it as XML
[xml]$xml = Get-Content C:\assay.xml

# Display the XML document element
$xml

# Display the root <computers> element
$xml.computers

# Display the computer nodes
$xml.computers.computer

# Display the first computer node
$xml.computers.computer[0]

# Display the first computer's <sysinfo> element
$xml.computers.computer[0].sysinfo

# display the first computer's Version attribute
$xml.computers.computer[0].sysinfo.Version

