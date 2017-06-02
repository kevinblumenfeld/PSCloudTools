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
function Get-LAMailboxHoldColumns {
    [CmdletBinding()]

    Param
    (

    )

    Begin {

    }
   
    Process {
        $resultArray = @()
        $mailbox = Get-Mailbox -IncludeInactiveMailbox -ResultSize 200 | Select userprincipalname, inplaceholds, IsInactiveMailbox, accountdisabled, RecipientTypeDetails
        $mbxSearch = Get-MailboxSearch | Select Name, InPlaceHoldIdentity
        $hash = @{}
        foreach ($sRow in $mbxSearch) {
            foreach ($id in $sRow.InPlaceHoldIdentity) {
                $hash[$id] = $sRow 
            }
        }
        $mailboxhash = @{}
        foreach ($row in $mailbox) {
            $mailboxhash['UPN'] = ($($row.userprincipalname))
            $i = 0
            ForEach ($guid in $row.inplaceholds) {
                $i++
                $mailboxhash['HOLDS' + $i] = ($hash[$guid]).name -join ","
            }
            $resultArray += [psCustomObject]$mailboxHash
        }
    }
    End {
        ([psCustomObject]$resultArray)
    }
}