##Written by John Tetterton to disable cameras on windows devices experiencing the constant camera utilization due to windows hello issues.
##If reimaging a device does not correct the issue, this can be used as an alternative. Please note, users will not be able to scan ID's for
##finance apps when this setting is disabled.

$confirmation = read-host "Before running this script please attempt a device reimage to correct issues with Windows Hello camera utilization. If windows hello issues persist this script may be used to disable the camera to extend battery life. PLEASE NOTE: END USERS WILL NOT BE ABLE TO SCAN IDS FOR FINANCE APPS WITH THIS SETTING DISABLED. ENTER 'Y' TO CONFIRM YOU ACKNOWELDGE THIS."

if ($confirmation -ne "y") {
    write-verbose "Script execution stopped..."
    exit
}

$registrypath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Camera"
$registryname = "AllowCamera"

if (-not (Test-Path $registrypath)) {
    new-item -path $registrypath -force | Out-Null
}

set-itemproperty -Path $registrypath -name $registryname -value 0 #To revert this script, change this value to 1

write-host "Camera has been disabled for all users"