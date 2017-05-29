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
function Get-MailboxHold() {
    [CmdletBinding()]

    Param
    (

    )

    Begin {
    }
   
    Process {
        Write-Host "Get-MailboxHold"
        $script:MailboxHold = Get-Mailbox -IncludeInactiveMailbox -ResultSize 500 | Select DisplayName, accountdisabled, IsInactiveMailbox, RecipientTypeDetails, UserPrincipalName, LitigationHoldEnabled, RetentionPolicy, RecoverableItemsQuota, InPlaceHolds
    }

    End {
    }
}