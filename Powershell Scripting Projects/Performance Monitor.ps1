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