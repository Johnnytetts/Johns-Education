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
        Get-ChildItem -Path $path -Recurse |
        Where-Object {
            if ($day) {
                $_.LastWriteTime.month -eq $month -and $_.LastWriteTime.Year -eq $year -and $_.LastWriteTime.day -eq $day
            }
            else {
                $_.LastWriteTime.month -eq $month -and $_.LastWriteTime.year -eq $year
            }
        }
    }
}

# Get command line arguments
$month = $args[0]
$year = $args[1]
$day = $args[2]

# Call the function with the provided arguments
if ($day) {
    $files = Get-FilesByDate -month $month -day $day -year $year
} else {
    $files = Get-FilesByDate -month $month -year $year
}

$fileCount = $files.Count

# serialize to a xml file
$files | Export-Clixml -Path "C:\Windows\output.xml"

# output file count
$fileCount