function Get-FilesByDate(){
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('1','2','3','4','5','6','7','8','9','10','11','12')]
        [int]$month,
        [Parameter(Mandatory=$false)]
        [ValidateRange(1,31)]
        [int]$day = (get-date).Day,
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
        $_.lastwritetime.month -eq $month -AND $_.lastwritetime.year -eq $year 
        }
    }
}