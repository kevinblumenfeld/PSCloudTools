function Find-Replace() {
    [CmdletBinding()]
    Param
    (

    )
    Begin {

    }
    Process {
        $resultArray = @()
        $row = @()
        $MailboxHold = Get-Mailbox -IncludeInactiveMailbox -ResultSize 10 | Select DisplayName, accountdisabled, IsInactiveMailbox, RecipientTypeDetails, UserPrincipalName, LitigationHoldEnabled, RetentionPolicy, RecoverableItemsQuota, InPlaceHolds
        $InPlaceHold = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate
        
        $hash = @{}
        foreach ($Hold in $InPlaceHold) {
            $hash.add($hold.InPlaceHoldIdentity, $hold.name)
        }
        $hash
        $FindParameter = "inplaceholds"
        foreach ($row in $MailboxHold) {
            ForEach ($HoldID in $row.$FindParameter.split()) {
                $ReplaceHash = @{}
                $ReplaceHash['HoldID'] = $HoldId
                $ReplaceHash['Name'] = $hash[$holdid]     
                $resultArray += [PScustomobject]$ReplaceHash          
            }
        }
    }
    End {
        # ([PScustomobject]$resultArray)
        $resultArray | Export-Csv "C:\scripts\test\333.csv" -nti
    }
}