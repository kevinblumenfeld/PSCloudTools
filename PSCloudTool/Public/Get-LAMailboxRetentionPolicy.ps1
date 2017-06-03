function Get-LAMailboxRetentionPolicy {
    <#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string[]] $list
    )
    Begin {
        $resultArray = @()
        $mailboxProperties = @("DisplayName", "IsMailboxEnabled", "AccountDisabled", "RetentionPolicy", "SingleItemRecoveryEnabled", "RecipientTypeDetails", "UseDatabaseRetentionDefaults", "RecoverableItemsQuota", "archivename", "UserPrincipalName", "Office", "RetainDeletedItemsFor", "LitigationHoldEnabled", "LitigationHoldDuration", "LitigationHoldDate", "LitigationHoldOwner", "RoleAssignmentPolicy")
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