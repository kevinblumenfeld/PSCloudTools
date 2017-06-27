<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LaComplianceValue {

    [CmdletBinding()]
    Param
    (
        [parameter(Mandatory = $true)]
        [ValidateSet("Include", "Exclude")]
        [string] $Filter,

        [parameter(Mandatory = $true)]
        [ValidateSet("LitigationHoldEnabled", "ArchiveEnabled", "RetainDeletedItemsFor30Days", "UseDatabaseRetentionDefaults", "SingleItemRecoveryEnabled", "InactiveMailboxes")]
        [string] $Value

    )
    Begin {

    }
    Process {
        $resultArray = @() 
        if ($Filter.Equals("Include")) {
            if ($Value.Equals("LitigationHoldEnabled")) {
                $resultsArray = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited -Filter {LitigationHoldEnabled -eq $true} | Select DisplayName, UserPrincipalName, LitigationHoldEnabled, LitigationHoldDuration
            }
            if ($Value.Equals("ArchiveEnabled")) {
                $resultsArray = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited -Filter {ArchiveStatus -ne 'none'} | Select DisplayName, UserPrincipalName, ArchiveName, ArchiveStatus
            }
            if ($Value.Equals("RetainDeletedItemsFor30Days")) {
                $resultsArray = (Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited).where{$_.RetainDeletedItemsFor -eq '30.00:00:00'} | Select DisplayName, UserPrincipalName, RetainDeletedItemsFor
            }
            if ($Value.Equals("UseDatabaseRetentionDefaults")) {
                $resultsArray = (Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited).where{$_.UseDatabaseRetentionDefaults -eq $true} | Select DisplayName, UserPrincipalName, UseDatabaseRetentionDefaults
            }
            if ($Value.Equals("InactiveMailboxes")) {
                $resultsArray = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited -InactiveMailboxOnly | Select DisplayName, UserPrincipalName, LitigationHoldEnabled, LitigationHoldDate, LitigationHoldOwner, LitigationHoldDuration, SingleItemRecoveryEnabled, RetentionPolicy, AccountDisabled, UseDatabaseRetentionDefaults, RetainDeletedItemsFor, RecoverableItemsQuota, ArchiveName, ArchiveStatus, SKUAssigned, IsSoftDeletedByRemove, IsInactiveMailbox, WhenSoftDeleted, InPlaceHolds, RetentionComment, Office, RoleAssignmentPolicy, IsDirSynced, EmailAddresses, HiddenFromAddressListsEnabled, PrimarySmtpAddress, RecipientTypeDetails, DistinguishedName, WhenChanged, WhenCreated, WhenMailboxCreated, Alias, IsResource, IsShared, SamAccountName, CustomAttribute1, CustomAttribute10, CustomAttribute11, CustomAttribute12, CustomAttribute13, CustomAttribute14, CustomAttribute15, CustomAttribute2, CustomAttribute3, CustomAttribute4, CustomAttribute5, CustomAttribute6, CustomAttribute7, CustomAttribute8, CustomAttribute9, ExtensionCustomAttribute1, ExtensionCustomAttribute2, ExtensionCustomAttribute3, ExtensionCustomAttribute4, ExtensionCustomAttribute5  
            }
        }  
        if ($Filter.Equals("Exclude")) {
            if ($Value.Equals("LitigationHoldEnabled")) {
                $resultsArray = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited -Filter {LitigationHoldEnabled -eq $false} | Select DisplayName, UserPrincipalName, LitigationHoldEnabled, LitigationHoldDuration
            }
            if ($Value.Equals("ArchiveEnabled")) {
                $resultsArray = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited -Filter {ArchiveStatus -ne 'none'} | Select DisplayName, UserPrincipalName, ArchiveName, ArchiveStatus
            }
            if ($Value.Equals("RetainDeletedItemsFor30Days")) {
                $resultsArray = (Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited).where{$_.RetainDeletedItemsFor -lt '30.00:00:00'} | Select DisplayName, UserPrincipalName, RetainDeletedItemsFor
            }
            if ($Value.Equals("UseDatabaseRetentionDefaults")) {
                $resultsArray = (Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited).where{$_.UseDatabaseRetentionDefaults -eq $false} | Select DisplayName, UserPrincipalName, UseDatabaseRetentionDefaults
            }
            if ($Value.Equals("InactiveMailboxes")) {
                $resultsArray = Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Select DisplayName, UserPrincipalName, LitigationHoldEnabled, LitigationHoldDate, LitigationHoldOwner, LitigationHoldDuration, SingleItemRecoveryEnabled, RetentionPolicy, AccountDisabled, UseDatabaseRetentionDefaults, RetainDeletedItemsFor, RecoverableItemsQuota, ArchiveName, ArchiveStatus, SKUAssigned, IsSoftDeletedByRemove, IsInactiveMailbox, WhenSoftDeleted, InPlaceHolds, RetentionComment, Office, RoleAssignmentPolicy, IsDirSynced, EmailAddresses, HiddenFromAddressListsEnabled, PrimarySmtpAddress, RecipientTypeDetails, DistinguishedName, WhenChanged, WhenCreated, WhenMailboxCreated, Alias, IsResource, IsShared, SamAccountName, CustomAttribute1, CustomAttribute10, CustomAttribute11, CustomAttribute12, CustomAttribute13, CustomAttribute14, CustomAttribute15, CustomAttribute2, CustomAttribute3, CustomAttribute4, CustomAttribute5, CustomAttribute6, CustomAttribute7, CustomAttribute8, CustomAttribute9, ExtensionCustomAttribute1, ExtensionCustomAttribute2, ExtensionCustomAttribute3, ExtensionCustomAttribute4, ExtensionCustomAttribute5 
            }
        }  
    }
    End {
        $resultsArray
    }
}