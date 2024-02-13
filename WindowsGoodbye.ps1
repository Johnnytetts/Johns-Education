$confirmation = Read-Host "Before running this script please advise your end user they will not be able to use a PIN and/or Facial recognition to login to this device before continuing..."

if ($confirmation -ne "y") {
    write-host "Script aborted..."
    exit
}

Set-ItemProperty -path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics" -name "Enabled" -value 0 -Force

write-host "Windows Hello has been disabled for this device"