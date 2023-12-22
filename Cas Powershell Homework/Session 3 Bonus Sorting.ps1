# Make array to store random numbers 0-200
$randomNumbers = @()

# Generate 10 random numbers
for ($i = 0; $i -lt 10; $i++) 
{$randomNumbers += Get-Random -Minimum 0 -Maximum 200}

# Sort the numbers in order
$sortedNumbers = $randomNumbers | Sort-Object

# Sort through each number generated and add to the array
foreach ($number in $sortedNumbers) {
    # Check if number is >100 and write a message
    if ($number -gt 100) {
        Write-Host "$number is over 100"
    }
    # Check if number is <100 and write a message
    else {
        Write-Host "$number is under 100"
    }
}
