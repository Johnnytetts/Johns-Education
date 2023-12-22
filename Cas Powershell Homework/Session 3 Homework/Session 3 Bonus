# Make arrays to store random numbers 0-200 + make arrays for sorting them into categories
$randomNumbers = @()
$Highs = @() # New array for numbers >100
$Lows = @() # New array for numbers <100

# Generate 10 random numbers
for ($i = 0; $i -lt 10; $i++) {
    $randomNumber = Get-Random -Minimum 0 -Maximum 200
    $randomNumbers += $randomNumber

    # Check if the number is >100
    if ($randomNumber -gt 100) {
        $Highs += $randomNumber  # Sort number into highs table
    } else {
        $Lows += $randomNumber  # Sort number into lows table
    }
}

# Message for higher than numbers
Write-Host "Higher than 100:"
foreach ($number in $Highs) {
    Write-Host "$number"
}

# Message for lower than numbers
Write-Host "Lower than 100:"
foreach ($number in $Lows) {
    Write-Host "$number"
}