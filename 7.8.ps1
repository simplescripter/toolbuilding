# 7.8 Working with Non-structured Data: Convert-String and Regex Groupings

# Convert-String formats a string to match examples

'Richie Tozier', 'Beverly Marsh' | Convert-String -Example 'John Doe=Doe, J.'

# Regex groupings use parenthesis

'Richie Tozier' -replace '(\w+) (\w+)', '$2, $1'