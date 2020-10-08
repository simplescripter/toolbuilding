# 2.3  Constructors, Overloads, and Enumerations

[System.Collections.Arraylist]$collection = <list>
$array = New-Object System.Collections.Arraylist

			#	-or-
				
$array = [System.Collections.ArrayList]::New

[System.ConsoleColor].GetMembers() | Select Name
