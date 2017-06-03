function Get-LAMailboxInPlaceHold_All {
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
        [Parameter(Mandatory = $false)]
        [switch] $ColumnsDontExport     
    )
    Begin {

    }
    Process {
        if ($ColumnsDontExport) {
            Get-MailboxHoldColumns
        } 
        else {
            Get-MailboxHold
        }
    }
    End {

    }
}