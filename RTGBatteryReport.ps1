
$battery = get-wmiobject -class win32_battery -erroraction silentlycontinue

$charged = $battery.estimatedchargeremaining

$batterylife = 45800 

$threshold = 60

$degradation = 100 - $batterylife

if ($degradation -ge $threshold) {
    write-host "Battery performance has degraded to ($degradation%), this device should be replaced and retired..."
} else {
    write-host "Battery performance is within operational thresholds, replacement is not needed..."
}

if ($battery.batterystatus -ne 4) {
if ($charged -gt 25) {
    $draintime = ($battery.estimatedruntime / ($battery.estimatedchargeremaining -25)) * ($charged -25)

$hours = [math]::floor($draintime / 60)
$minutes = $draintime % 60

write-host "Estimated time for battery to drain to 25%: $hours hours and $minutes minutes."
}
} else {
    write-host "Please remove the AC power adapter to check the battery's current drain time to 25%..."
}