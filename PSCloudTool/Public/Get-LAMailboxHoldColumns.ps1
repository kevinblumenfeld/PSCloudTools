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
        $Holds = "c:\scripts\test\withHolds.csv"
        $NoHolds = "c:\scripts\test\withoutHolds.csv"
        $headerstring = "userprincipalname, IsInactiveMailbox, accountdisabled, RecipientTypeDetails"
        Out-File -FilePath $Holds -InputObject $headerstring -Encoding UTF8
        Out-File -FilePath $NoHolds -InputObject $headerstring -Encoding UTF8

        $mailbox = Get-Mailbox -IncludeInactiveMailbox -ResultSize 300 | Select userprincipalname, inplaceholds, IsInactiveMailbox, accountdisabled, RecipientTypeDetails
        $HoldList = Get-MailboxSearch | Select Name, InPlaceHoldIdentity
        $hash = @{}
        foreach ($Hold in $HoldList) {
            $hash.add($hold.InPlaceHoldIdentity, $hold.name)
        }
        foreach ($row in $mailbox) {
            $new = @()
            if ($row.inplaceholds) {
                if ($row.inplaceholds.split().count -gt 1) {
                    ForEach ($hold in $row.inplaceholds.split()) {
                        $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                        $new += $temp.Value + ","
                        $new = $new.trim()
                    }
                    $new = $new.trim(",")
                }
                else {
                    ForEach ($hold in $row.inplaceholds.split()) {
                        $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                        $new += $temp.Value
                    }
                }   
                $row.userprincipalname + "," + $row.IsInactiveMailbox + "," + $row.accountdisabled + "," + $row.RecipientTypeDetails + "," + $new | Out-File -FilePath $Holds -Encoding UTF8 -append
            } # BELOW CREATES CSV ROWS OF USERS WITHOUT IN-PLACE HOLDS
            else {
                $row.userprincipalname + "," + $row.IsInactiveMailbox + "," + $row.accountdisabled + "," + $row.RecipientTypeDetails | Out-File -FilePath $NoHolds -Encoding UTF8 -append
            }
        }
    }
    End {
    }
}