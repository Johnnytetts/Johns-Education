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
    process { #I know this function dosent work but I forgot what Cas said to help me fix it. I will rewrite it with the correct formatting to see if the additions at the bottom work.
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
# Count number of files found
$files = Get-FilesByDate -month $month -day $day -year $year
$fileCount = $files.Count

# serialize to a xml file, path is wrong becuase of differing machines
$files | Export-Clixml -Path "C:\Windows\output.xml"

# Give file count of found objects? I dont think this works like this.
$fileCount
