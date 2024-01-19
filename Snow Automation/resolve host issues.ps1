#Get credentials
$Credentials = Get-Credential


$uri = 'https://roomstogodev.service-now.com'

$method = "get"

$response = (Invoke-RestMethod -Method $method -Uri $uri -ContentType "application/json" -Credential $Credentials).Result

$response

Write-Host "Ther server name is $($response.name)"