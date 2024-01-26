#This function is used to check the current CPU Usage.
function get-cpuusage {
    $cpupwr = get-counter '\processor(_total)\% processor time'
        $cpupwr = $cpupwr.countersamples[0].cookedvalue
       return $cpupwr
   }

#This function is used to check the percentage of available RAM.
function get-ramusage {
    $totalram = get-ciminstance -classname cim_computersystem | select-object -expandproperty totalphysicalmemory
    $totalrammb = $totalram / 1MB
    $availableram = get-counter '\memory\available mbytes'
    $availablerammb = $availableram.countersamples[0].cookedvalue
    $usedrammb = $totalrammb - $availablerammb
        return $usedrammb
}

#This function is used to check the percentage of used disk space.
function get-diskusage {
    $diskpwr = get-ciminstance -classname win32_logicaldisk -filter "deviceid='c:'"
    $diskuse = $diskpwr.size - $diskpwr.freespace
    $diskused = ($diskuse /$diskpwr.size) * 100
        return $diskused
}

#This function is used to show the current uptime of the system.
function get-uptime {
    $uptime = (get-date) - (gcim win32_operatingsystem).lastbootuptime
        return $uptime
}

#Where the magic happens. This is the main loop that runs the functions and compares them to the thresholds.
while ($true) {
    $cpupwr = get-cpuusage
    $thresholdcpu = 5
        if ($cpupwr -gt $thresholdcpu) {
            write-host "CPU usage is above current threshold of $thresholdcpu %" 
    }
    #start-sleep -seconds 60

    $rampwr = get-ramusage
    $totalram = get-ciminstance -ClassName CIM_ComputerSystem | select-object -expandproperty totalphysicalmemory
    $totalrammb = $totalram / 1MB
    $thresholdram = 0.20 * $totalrammb  # This calculates a percentage of total ram gathered from the $totalram variable. Edit the 0.20 value to change the percentage.
        if ($rampwr -gt $thresholdram) {
            write-host "RAM usage is above current threshold of $thresholdram MB" 
        }

    #start-sleep -seconds 60    

    $diskpwr = get-diskusage
    $thresholddisk = 50 #This uses whole numbers and not a decimal like ram, so 50 = 50% not 0.5 = 50%
        if ($diskpwr -gt $thresholddisk) {
            write-host "Disk usage is above current threshold of $thresholddisk %" 
        }

    #start-sleep -seconds 60

    $uptime = get-uptime
    write-host "Device has been up for $($uptime.days) days, $($uptime.hours) hours, and $($uptime.minutes) minutes"
    
    start-sleep -seconds 60
}