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
function Get-InPlaceHold() {
    [CmdletBinding()]

    Param
    (

    )

    Begin {
    }
   
    Process {
        Write-Host "Get-InPlaceHold"
        $script:InPlaceHold = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate
    }

    End {
    }
}