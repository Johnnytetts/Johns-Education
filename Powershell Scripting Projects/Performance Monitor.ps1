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
    $drives = get-ciminstance -classname win32_logicaldisk
    $results = @()
        foreach ($drive in $drives) {
            $diskuse = $drive.size - $drive.FreeSpace
            $diskused = ($diskuse / $drive.size) * 100
            $results += [pscustomobject]@{
                drive = $drive.DeviceID
                usage = $diskused
            }
        }
        
        return $results
}

#This function is used to show the current uptime of the system.
function get-uptime {
    $uptime = (get-date) - (gcim win32_operatingsystem).lastbootuptime
        return $uptime
}

#This function is used to show the current pagefile usage.
function get-pagefileusage {
    $pagefile = get-counter '\paging file(_total)\% usage'
    $pagefile = $pagefile.countersamples[0].cookedvalue
        return $pagefile
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

    $disksused = get-diskusage
        foreach ($diskusage in $disksused) {
            $thresholddisk = 10 #This is also a whole number percentage, 10 = 10%. Edit this value to change the threshold.
                if ($diskusage.usage -gt $thresholddisk) {
                    write-host "Disk $($diskusage.drive) usage is above current threshold of $thresholddisk %" 
                }
        }

    #start-sleep -seconds 60

    $uptime = get-uptime
    write-host "Device has been up for $($uptime.days) days, $($uptime.hours) hours, and $($uptime.minutes) minutes"
    
    #start-sleep -seconds 60

    $pagefile = get-pagefileusage
    write-host "Pagefile usage is at $pagefile %"

    start-sleep -seconds 60
}