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
function Export-MailboxHold() {
    [CmdletBinding()]

    Param
    (

    )

    Begin {
    }
   
    Process {
        Write-Host "Export-MailboxHold"
        Get-MailboxHold
        Get-InPlaceHold
        New-HashTable # -hashkey InPlaceHoldIdentity
        Find-Replace
    }

    End {
    }
}