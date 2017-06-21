function Get-LAMailboxLitigationHold {
    <#
.SYNOPSIS
   Reports on all mailboxes and whether or not they are on Litigation Hold.  
   Additionally, can report on all mailboxes that do not have litigation hold enabled.

.DESCRIPTION
   Reports on all mailboxes and whether or not they are on Litigation Hold.  
   Additionally, can report on all mailboxes that do not have litigation hold enabled.
   
   Mailbox UPNs should be passed from the pipeline as demonstrated in the examples below.

   Individual mailboxes, all mailboxes, all mailboxes in a department are all possibilities.

   Also demonstrated in an example below is importing mailboxes (UPN's) from a CSV
   
   A CSV could look like this

   UserPrincipalName
   user01@contoso.com
   user02@contoso.com
   user03@contoso.com
   user04@contoso.com

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxLitigationHold | Out-GridView

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxLitigationHold | Export-Csv .\litigationholds.csv -NoTypeInformation

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxLitigationHold -LitigationHoldDisabledOnly | Export-Csv .\litigationholds.csv -NoTypeInformation

   ** This example only reports on those that do NOT have Litigation Hold Enabled (notice the switch -LitigationHoldDisabledOnly) **

.EXAMPLE
   Import-Csv .\upns.csv | Get-LAMailboxLitigationHold | Export-Csv .\litholds.csv -NoTypeInformation

.EXAMPLE
   Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LAMailboxLitigationHold | Export-Csv .\HRlitigationholds.csv -NoTypeInformation

#>
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