# Make arrays to store random numbers 0-200
$randomNumbers = @()

# Generate 10 random numbers
for ($i = 0; $i -lt 10; $i++) 
{$randomNumbers += Get-Random -Minimum 0 -Maximum 200}

foreach ($number in $randomNumbers) 
{
    # Check if the number is >100 and write a message
    if ($number -gt 100) {
        Write-Host "$number is over 100"
    }
    # Check if the number is <100 and write a message
    else {
        Write-Host "$number is under 100"
    }
}




####Examples from google search about -gt operator for reference###
# Compare two numbers
#$a = 10
#$b = 5

#if ($a -gt $b) {
#    Write-Host "A is greater than B"
#}