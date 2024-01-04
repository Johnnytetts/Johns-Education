function Get-FilesByDate(){
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('1','2','3','4','5','6','7','8','9','10','11','12')]
        [int]$month,
        [int]$day = (get-date).Day,
        [int]$year = (get-date).Year,
        [Parameter(ValueFromPipeline=$true)]
        [string[]]$path = "./"
    )
    process {
        Get-ChildItem -Path $path -Recurse |
        Where-Object {
        $_.lastwritetime.month -eq $month -AND $_.lastwritetime.year -eq $year 
        }
    }
}