function Get-MailboxHold {
    [CmdletBinding()]
    Param
    (

    )
    Begin {

    }
    Process {
        $resultArray = @()
        $findParameter = "InPlaceHolds"
        $mailbox = Get-Mailbox -IncludeInactiveMailbox -ResultSize 600 | Select DisplayName, accountdisabled, IsInactiveMailbox, RecipientTypeDetails, UserPrincipalName, LitigationHoldEnabled, RetentionPolicy, RecoverableItemsQuota, InPlaceHolds
        $mbxSearch = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate, sourcemailboxes, ItemHoldPeriod
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
                $mailboxHash['ItemHoldPeriod'] = ($hash[$guid]).ItemHoldPeriod                                             
                foreach ($field in $mailboxProperties.name) {
                    $mailboxHash[$field] = ($row.$field) -join ","
                }  
                $resultArray += [psCustomObject]$mailboxHash        
            }
        }
    }
    End {
        ([psCustomObject]$resultArray)
    }
}