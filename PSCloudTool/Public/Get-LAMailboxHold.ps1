function Get-LAMailboxHold {
    [CmdletBinding()]
    Param
    (

    )
    Begin {

    }
    Process {
        $resultArray = @()
        $findParameter = "InPlaceHolds"
        $mailbox = Get-Mailbox -IncludeInactiveMailbox -ResultSize 10 | Select DisplayName, accountdisabled, IsInactiveMailbox, RecipientTypeDetails, UserPrincipalName, LitigationHoldEnabled, RetentionPolicy, RecoverableItemsQuota, InPlaceHolds
        $mbxSearch = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate, sourcemailboxes
        $mailboxProperties = $mailbox | Get-Member -MemberType 'NoteProperty' | Select Name
        
        $hash = @{}
        foreach ($sRow in $mbxSearch) {
            foreach ($id in $sRow.InPlaceHoldIdentity) {
                $hash[$id] = $sRow 
            }
        }
      
        foreach ($row in $mailbox) {           
            ForEach ($guid in $row.$findParameter) {
                $mailboxHash = @{}
                $mailboxHash['InPlaceHoldName'] = ($hash[$guid]).name
                $mailboxHash['StatusofHold'] = ($hash[$guid]).Status
                $mailboxHash['StartDate'] = ($hash[$guid]).StartDate
                $mailboxHash['EndDate'] = ($hash[$guid]).EndDate                                             
                foreach ($field in $mailboxProperties.name) {
                    $mailboxHash[$field] = ($row.$field) -join ","
                }  
                $resultArray += [psCustomObject]$mailboxHash        
            }
        }
    }
    End {
        ([psCustomObject]$resultArray)
        [psCustomObject]$resultArray | Export-Csv "C:\scripts\test\333.csv" -nti
    }
}