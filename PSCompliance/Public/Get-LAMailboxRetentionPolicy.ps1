function Get-LAMailboxRetentionPolicy {
    <#
.SYNOPSIS
   Reports on which retention policy a mailbox or mailboxes have

.DESCRIPTION
   Reports on which retention policy a mailbox or mailboxes have
   Mailbox UPNs should be passed from the pipeline as demonstrated in the examples below.

   Individual mailboxes, all mailboxes, all mailboxes in a department are all possibilities.

   Also demonstrated in an example below is importing mailboxes (UPNs) from a CSV
   
   A CSV could look like this

   UserPrincipalName
   user01@contoso.com
   user02@contoso.com
   user03@contoso.com
   user04@contoso.com

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxInPlaceHold | Out-GridView

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxInPlaceHold | Export-Csv .\legacyholds.csv -notypeinformation

.EXAMPLE
   Import-Csv .\upns.csv | Get-LAMailboxInPlaceHold | Export-Csv .\legacyHoldsbyMailbox.csv -notypeinformation

.EXAMPLE
   Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LAMailboxInPlaceHold | Export-Csv .\HRsHolds.csv -NoTypeInformation
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