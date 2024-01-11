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