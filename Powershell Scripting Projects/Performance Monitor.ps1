#This function is used to check the current CPU Usage. Alter reporting time by editing the $threshold value.
function get-cpuusage {
    $cpupwr = get-counter '\processor(_total)\% processor time'
        $cpupwr = $cpupwr.countersamples[0].cookedvalue
       return $cpupwr
   }

   #This function is used to check the percentage of available RAM. Alter reporting time by editing the $threshold value.
function get-ramusage {
    $totalram = get-ciminstance -classname cim_computersystem | select-sbject -expandproperty totalphysicalmemory
    $totalrammb = $totalram / 1MB
    $availableram = get-counter '\memory\available mbytes'
    $availablerammb = $availableram.countersamples[0].cookedvalue
    $usedrammb = $totalrammb - $availablerammb
    return $usedrammb
}

while ($true) {
    $cpupwr = get-cpuusage
    $threshold = 5
if ($cpupwr -gt $threshold) {
    write-verbose "CPU usage is above current threshold of $threshold %" -verbose
}

$rampwr = get-ramusage
$totalram = get-ciminstance -ClassName CIM_ComputerSystem | select-object -expandproperty totalphysicalmemory
$totalrammb = $totalram / 1MB
$threshold = 0.20 * $totalrammb  # This calculates a percentage of total ram gathered from the $totalram variable. Edit the 0.20 value to change the percentage.
if ($rampwr -gt $threshold) {
    write-verbose "RAM usage is above current threshold of $threshold MB" -verbose
}

start-sleep -seconds 60
}


