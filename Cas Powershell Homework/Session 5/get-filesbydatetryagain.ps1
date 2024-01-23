<# 
.DESCRIPTION 
This is an example function written alongside powershell trainings taught by Cas Mollien. The code itself is a function to find the number of files in a given path, allowing users to also add criteria such as year, month, and day. The output then counts and shows said files and exports them into a CSV format for readability.
#>

<# 
.NOTES 
No dependencies required, created on Powershell 7. 
#>

<# 
.EXAMPLE 
An example for using this command looks like as follows: Get-FilesByDat -Path ".\" -Year "2023" -Month "3" (The day argument is optional)
#>

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

$fileCount = $files.count

# serialize to a xml file
#$files | Export-Clixml -Path "C:\Users\tettejoh\OneDrive - RoomsToGo\Documents\GitHub\output.xml"
$files | Export-Clixml -Path ".\Cas Powershell Homework\Session 5\output.xml"

# output file count
$fileCount

#Read file into Object
#$files = Get-Content ".\Cas Powershell Homework\Session 5\FileCSV.csv"

#Import to a csv
#$files = Import-Csv ".\Cas Powershell Homework\Session 5\FileCSV.csv"

#Output to a csv
$files | Select-Object PSPath, BaseName, Extension | Export-Csv -NoTypeInformation -Path ".\Cas Powershell Homework\Session 5\FileCSV.csv" 