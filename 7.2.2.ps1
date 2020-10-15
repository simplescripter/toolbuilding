# 7.2.2 Importing and Searching XML Continued

# Read the content as strings with Get-Content and cast it as XML
[xml]$xml = Get-Content C:\assay.xml

# select the single <computer> node having
# the Name attribute of LonDC1
# (This is an XPath query)
$node = $xml.SelectSingleNode('//computer[@name="LonDC1"]')

# display the selected node
$node.InnerXml

# select all <sysinfo> nodes that
# follow the <computer> node having the
# Name attribute of LonDC1. Notice that the
# XPath query follows the hierarchy of the XML.
$nodes = $xml.SelectNodes('//computer[@name="LonDC1"]/sysinfo')
$nodes