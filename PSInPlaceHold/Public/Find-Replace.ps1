function Find-Replace() {
    [CmdletBinding()]
    Param
    (

    )
    Begin {

    }
    Process {
        $resultArray  = @()
        $Row = @()
        $Mailbox = Get-Mailbox -IncludeInactiveMailbox -ResultSize 10 | Select DisplayName, accountdisabled, IsInactiveMailbox, RecipientTypeDetails, UserPrincipalName, LitigationHoldEnabled, RetentionPolicy, RecoverableItemsQuota, InPlaceHolds
        $InPlaceHold = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate
        $MailboxProperties = $Mailbox | Get-Member -MemberType 'NoteProperty'| where {$_.Name -ne $FindParameter}| Select Name
        $Id2NameLookup = @{}
        foreach ($Hold in $InPlaceHold) {
            $Id2NameLookup.add($hold.InPlaceHoldIdentity, $hold.name)
        }
        $FindParameter = "InPlaceHolds"
        foreach ($Row in $Mailbox) {
            $MailboxHash = @{}
            foreach ($field in $MailboxProperties.name) {
                $MailboxHash[$field] = ($Row.$field) -join ","
            }
            $resultArray += [string]$MailboxHash
            
            ForEach ($HoldID in $Row.$FindParameter.split()) {
                $ReplaceHash = @{}
                #$ReplaceHash['HoldID'] = $HoldId
                $ReplaceHash['Name'] = $Id2NameLookup[$holdid]     
                $resultArray += [PScustomobject]$ReplaceHash        
            }
        }
    }
    End {
        ([PScustomobject]$resultArray)
        [PScustomobject]$resultArray | Export-Csv "C:\scripts\test\333.csv" -nti
    }
}