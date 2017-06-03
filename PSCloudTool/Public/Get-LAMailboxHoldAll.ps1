function Get-LAMailboxHoldAll {
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