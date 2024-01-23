$params =@{
    url = 'http://roomstogodev.service-now.com'
    Credential = $userCred
}
New-ServiceNowSession @params

#Call to grab incidents assigned to the (SN) Tech Ops SE Stores group
Get-ServiceNowRecord -table incident -Filter @('opened_at', 'assignment group=(SN) Tech Ops SE Stores', 'active=true')
