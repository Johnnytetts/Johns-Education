<<<<<<< Updated upstream
clear 
$testvar = "Cas"

function mytest(){
    write-output "Inside Function before change: $testvar"
    $global:testvar = "Jonathan"
    write-output "Inside Function after change: $testvar"
}

write-output "Before Function: $testvar"
mytest
write-output "After Function: $testvar"
=======
clear
$testvar = "John"

function mytest(){
    write-output "Inside Function before change: $testvar"
    $global:testvar = "Johnathan"
    Write-Output "Inside Function after change: $testvar"
}

Write-Output "Before Function: $testvar"
mytest
Write-Output "After Function: $testvar"
>>>>>>> Stashed changes
