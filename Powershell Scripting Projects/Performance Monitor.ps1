#This function is used to check the current CPU Usage. Alter reporting time by editing the $threshold value.
function get-cpuusage {
        $cpupwr = get-counter '\processor(_total)\% processor time'
        $cpupwr = $cpupwr.countersamples[0].cookedvalue
        return $cpupwr
    }

while ($true) {
    $cpupwr = get-cpuusage
    $threshold = 5
if ($cpupwr -gt $threshold) {
    Write-Verbose "CPU usage is above current threshold of $threshold %" -Verbose
}

start-sleep -seconds 60
}

#This function is used to check the current RAM usage. Alter reporting time by editing the $threshold value.
function get-ramusage {
        $rampwr = get-counter '\memory\available mbytes'
        $rampwr = $rampwr.countersamples[0].cookedvalue
        return $rampwr
    }

while($true) {
    $rampwr = get-ramusage
    $threshold = 99
if ($rampwr -lt $threshold) {
    Write-Verbose "RAM usage is above current threshold of $threshold MB" -Verbose
}
}