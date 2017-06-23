<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LAMailboxLitigationHold {

    [CmdletBinding()]
    Param
    (
        
        [Parameter(Mandatory = $false)]
        [switch] $LitigationHoldDisabledOnly,

        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [object[]] $list

    )
    Begin {
        $resultArray = @()
        $mailboxProperties = @("DisplayName", "IsMailboxEnabled", "AccountDisabled", "LitigationHoldEnabled", "LitigationHoldDuration", "LitigationHoldDate", "LitigationHoldOwner", "UserPrincipalName", "Office", "RetainDeletedItemsFor", "RetentionPolicy", "SingleItemRecoveryEnabled", "RecipientTypeDetails", "UseDatabaseRetentionDefaults", "RecoverableItemsQuota", "archivename", "RoleAssignmentPolicy")
    }
    Process {
        if ($LitigationHoldDisabledOnly) {
            $entry = Get-Mailbox -identity $_.UserPrincipalName | Where {$_.LitigationHoldEnabled -ne $true}
            foreach ($mailbox in $entry) {   
                $mailboxHash = [ordered]@{}
                foreach ($field in $mailboxProperties) {
                    $mailboxHash[$field] = ($mailbox.$field) -join ","
                }                                            
                $resultArray += [psCustomObject]$mailboxHash        
            }
        }
        else {
            $entry = Get-Mailbox -identity $_.UserPrincipalName
            foreach ($mailbox in $entry) {   
                $mailboxHash = [ordered]@{}
                foreach ($field in $mailboxProperties) {
                    $mailboxHash[$field] = ($mailbox.$field) -join ","
                }                                            
                $resultArray += [psCustomObject]$mailboxHash        
            }
        }
    }
    End {
        $resultArray 
    }
}