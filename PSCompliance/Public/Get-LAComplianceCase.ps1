function Get-LAComplianceCase {
<#

.SYNOPSIS
   Retrieve Office 365 Compliance Cases, holds and hold queries

.DESCRIPTION
   All Office 365 Compliance Cases are returned from the Office 365 Security & Compliance Center.
   Additionally, each case's hold (Exchange and/or SharePoint) are returned.

   Make sure you are first connected to the Office 365 compliance service.  Simply use Get-LAConnected,  e.g. Get-LAConnected -Tenant Contoso -Compliance

   Credit: https://support.office.com/en-us/article/Create-a-report-on-holds-in-eDiscovery-cases-in-Office-365-cca08d26-6fbf-4b2c-b102-b226e4cd7381

.EXAMPLE
   Get-LAComplianceCase
   User is prompted for path for output.  Simply enter a path and not the file name:
   
   This is what the user will see:
   Enter a file path to save the report to a .csv file:

   Enter the following, for example: c:\scripts\test
   
   This is what the user will see:
   Enter a file path to save the report to a .csv file: c:\scripts\test

#>

    write-host "***********************************************"
    write-host "   Office 365 Security & Compliance Center   " -foregroundColor yellow -backgroundcolor darkgreen
    write-host "        eDiscovery cases - Holds report         " -foregroundColor yellow -backgroundcolor darkgreen 
    write-host "***********************************************"

    #prompt users to specify a path to store the output files
    $time = get-date
    $Path = Read-Host 'Enter a file path to save the report to a .csv file'
    $outputpath = $Path + '\' + 'CaseHoldsReport' + ' ' + $time.day + '-' + $time.month + '-' + $time.year + ' ' + $time.hour + '.' + $time.minute + '.csv'

    #get information on the cases and pass values to the case report function
    write-host "Gathering a list of cases and holds..."
    $edc = Get-ComplianceCase -ErrorAction SilentlyContinue
    foreach ($cc in $edc) {
        write-host "Working on case :" $cc.name
        if ($cc.status -eq 'Closed') {
            $cmembers = ((Get-ComplianceCaseMember -Case $cc.name).windowsLiveID) -join ';'
            add-tocasereport -casename $cc.name -casestatus $cc.Status -caseclosedby $cc.closedby -caseClosedDateTime $cc.ClosedDateTime -casemembers $cmembers 
        }
        else {
            $cmembers = ((Get-ComplianceCaseMember -Case $cc.name).windowsLiveID) -join ';'
            $policies = Get-CaseHoldPolicy -Case $cc.name
            foreach ($policy in $policies) {
                $rule = Get-CaseHoldRule -Policy $policy.name
                Get-AddtoCaseReport -casename $cc.name -casemembers $cmembers -casestatus $cc.Status -casecreatedtime $cc.CreatedDateTime -holdname $policy.name -holdenabled $policy.enabled -holdcreatedby $policy.CreatedBy -holdlastmodifiedby $policy.LastModifiedBy -ExchangeLocation (($policy.exchangelocation.name) -join ';') -SharePointLocation (($policy.sharePointlocation.name) -join ';') -ContentMatchQuery $rule.ContentMatchQuery -holdcreatedtime $policy.WhenCreatedUTC -holdchangedtime $policy.WhenChangedUTC
            }
        }
    }
    " "
    Write-host "Script complete! Report file: '$outputPath'"
    " "
    #script end
}
function Get-AddtoCaseReport {
    Param([string]$casename,
        [String]$casestatus,
        [datetime]$casecreatedtime,
        [string]$casemembers,
        [datetime]$caseClosedDateTime,
        [string]$caseclosedby,
        [string]$holdname,
        [String]$Holdenabled,
        [string]$holdcreatedby,
        [string]$holdlastmodifiedby,
        [string]$ExchangeLocation,
        [string]$sharePointlocation,
        [string]$ContentMatchQuery,
        [datetime]$holdcreatedtime,
        [datetime]$holdchangedtime
    )
    $addRow = New-Object PSObject 
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Case name" -Value $casename
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Case status" -Value $casestatus
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Case members" -Value $casemembers
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Case created time" -Value $casecreatedtime
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Case closed time" -Value $caseClosedDateTime
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Case closed by" -Value $caseclosedby
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Hold name" -Value $holdname
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Hold enabled" -Value $Holdenabled
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Hold created by" -Value $holdcreatedby
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Hold last changed by" -Value $holdlastmodifiedby
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Exchange locations" -Value  $ExchangeLocation
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "SharePoint locations" -Value $sharePointlocation
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Hold query" -Value $ContentMatchQuery
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Hold created time (UTC)" -Value $holdcreatedtime
    Add-Member -InputObject $addRow -MemberType NoteProperty -Name "Hold changed time (UTC)" -Value $holdchangedtime

    $allholdreport = $addRow | Select-Object "Case name", "Case status", "Hold name", "Hold enabled", "Case members", "Case created time", "Case closed time", "Case closed by", "Exchange locations", "SharePoint locations", "Hold query", "Hold created by", "Hold created time (UTC)", "Hold last changed by", "Hold changed time (UTC)"

    $allholdreport | export-csv -path $outputPath -notypeinfo -append -Encoding ascii 
}