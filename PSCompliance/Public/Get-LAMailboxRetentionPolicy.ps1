<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LAMailboxRetentionPolicy {

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