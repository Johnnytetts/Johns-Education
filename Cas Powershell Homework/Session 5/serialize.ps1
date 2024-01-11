#Measure-Command { get-azaduser }

#(get-azaduser).length
#get-azaduser | Where-Object -Property Surname -EQ Mollien
#get-azaduser | Where-Object -Property Surname -EQ Flores


$allusers = get-azaduser  # --> 20 sec
$allusers.length
$allusers | Where-Object -Property Surname -EQ Mollien
$allusers | Where-Object -Property Surname -EQ Flores

$allusers[0] | fl *

# Export it to file
$allusers | ConvertTo-Json | Out-File .\AllUsers.json
$allusers | Export-Clixml -Path .\AllUsers.clixml

$allusers.length
Remove-Variable -Name allusers

# Import it
$allusers = Get-Content .\AllUsers.json | ConvertFrom-Json
$allusers = Import-Clixml -Path .\AllUsers


$allusers | ConvertTo-Csv