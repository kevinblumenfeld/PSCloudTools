function Get-LALitigationHold {
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string[]] $list
    )
    Begin {
        $row = @()
        $resultArray = @()
        $mailboxProperties = @("DisplayName", "IsMailboxEnabled", "AccountDisabled", "archivename", "UserPrincipalName", "Office", "RetainDeletedItemsFor", "LitigationHoldEnabled", "LitigationHoldDuration", "LitigationHoldDate", "LitigationHoldOwner", "RetentionPolicy", "SingleItemRecoveryEnabled", "RecipientTypeDetails", "UseDatabaseRetentionDefaults", "RecoverableItemsQuota", "RoleAssignmentPolicy")
    }
    Process {
        $entry = Get-Mailbox -identity $_.UserPrincipalName
        foreach ($mailbox in $entry) {   
            $mailboxHash = [ordered]@{}
            foreach ($field in $mailboxProperties) {
                $mailboxHash[$field] = ($mailbox.$field) -join ","
            }                                            
            $resultArray += [psCustomObject]$mailboxHash        
        }
    }
    End {
        $resultArray 
    }
}