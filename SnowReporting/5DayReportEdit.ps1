#Step 1: Get username and password from EU
$credential = Get-Credential -Message "Enter your Rooms to Go email"

#Step 2: Set url for RTG ServiceNow
$SnowUrl = "https://roomstogo.service-now.com"

#Step 3: Start a new session
$session = New-ServiceNowSession -Url $SnowUrl -Credential $credential

#Step 4: Set assignment group and calculate date 5 days prior to current date
$assignmentGroup = "(SN) Tech Ops SE Stores)"
$updatedDate = (Get-Date).AddDays(-5).Tostring("yyyy-MM-dd")

#Step 5: Create API query
$queryParams = @{
    "sysparm_query" = "assignment_group=$assignmentGroup^sys_updated_on<=$updatedDate";
}

$incidents = Get-ServiceNowRecord -Table incident -Filter @('opened_at', '-ge', (Get-Date).AddDays(-30))


#Step 6: Show output of query results
$incidents.result | Format-Table -Property number, sys_updated_on, assignment_group, short_description -AutoSize