# 7.6 Regex Using -match

# An exact character match:
"Please reboot LONSVR1" -match 'reboot' # TRUE

# A period (dot) matches any single character
"LONSVR1" -match "LONSVR." # TRUE
"LON-SVR" -match "LON-SVR." # FALSE The period matches a single character, and there's no character after LONSVR in the string

# A question mark matches zero or one instance of the preceding character
"LONSVR1" -match "LONSVR?" # TRUE
"LONSVR" -match "LONSVR?" # TRUE

# An asterisk matches zero or more instances of the preceeding character
"LAB-0005" -match "LAB-0*5" # TRUE
"LAB-05" -match "LAB-0*5" # TRUE
"LAB-5" -match "LAB-0*5" # TRUE

# Matches at least one of the characters in the brackets
"bog" -match "b[aeiou]g" # TRUE Will match bag/beg/big/bog/bug

# The caret ^ inside brackets matches anything except the bracketed characters
"BFG" -match "b[^aeiou]g" # TRUE matches anything other than a vowel in between the b and g
"BFG" -cmatch "b[^aeiou]g" # FALSE -cmatch requires a case-sensitive match

# Matches at least one of the characters within the bracketed range
"LAB-3" -match "LAB-[0-4]" # TRUE matches digits 0-4 after 'LAB-'

# The escape character \ lets you match special characters
"1.2.5" -match "[0-9\.[0-9]\.[0-9]" #TRUE

# You can use specific character types with escape codes
"richie357@xyz.com" -match "\w+@\w+.\w+" # TRUE
"A line with     spaces" -match "\s+" # TRUE

# Multiple and limted number of matches
"004523412239" -match "\d+" # TRUE: \d+ looks for one or more digits
"004523412239" -match "\d{16}" # FALSE: Only 12 digits in the string, not a minimum of 16 consecutive digits
123-45-6789
"004523412239ABCD" -match "\d{16}" # FALSE: 16 characters, but not 16 consecutive digits
"12-345-6789" -match "\d{2}-\d{3,4}-\d{4}" # TRUE
"12-34-6789" -match "\d{2}-\d{3,4}-\d{4}" # FALSE

# Use ^ and $ to anchor the pattern to the beginning and/or end of the string
"My email address is richie@xyz.com" -match "\w+@\w+.\w+$" # TRUE
"My email address is richie@xyz.com" -match "^\w+@\w+.\w+$" # FALSE the pattern must begin the string and end the string
"richie@xyz.com" -match "^\w+@\w+.\w+$" # TRUE