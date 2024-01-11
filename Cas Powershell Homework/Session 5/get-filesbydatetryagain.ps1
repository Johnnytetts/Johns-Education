function Get-FilesByDate(){
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('1','2','3','4','5','6','7','8','9','10','11','12')]
        [int]$month,
        [ValidateRange(1,31)]
        [int]$day,
        [int]$year = (get-date).Year,
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$path = "./"
    )
    process {
        if ($day){
            Write-verbose "Using the 'day' filter"
            Get-ChildItem -Path $path -Recurse |
            Where-Object {
                    $_.LastWriteTime.month -eq $month -and $_.LastWriteTime.Year -eq $year -and $_.LastWriteTime.day -eq $day
                }
            return
        }

        Write-verbose "Using the 'month' filter"
        Get-ChildItem -Path $path -Recurse |
        Where-Object {
                $_.LastWriteTime.month -eq $month -and $_.LastWriteTime.year -eq $year
            }
    }
}

$SPLAT = @{
    month = 1
    #year = 2023
    #day = 4
    #path = ./
    verbose = $true
}
#Get-FilesByDate @SPLAT | ft mode, lastwritetime, resolvedtarget

$files = Get-FilesByDate @SPLAT

$fileCount = $files.Count

# serialize to a xml file
#$files | Export-Clixml -Path "C:\Users\tettejoh\OneDrive - RoomsToGo\Documents\GitHub\output.xml"
$files | Export-Clixml -Path ".\Cas Powershell Homework\Session 5\output.xml"

# output file count
$fileCount