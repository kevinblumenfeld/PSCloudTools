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
function Get-LAMailboxHoldSnip {
    [CmdletBinding()]

    Param
    (

    )

    Begin {

    }
   
    Process {
        $mailbox = Get-Mailbox -ResultSize 200 | Select userprincipalname, InPlaceHolds
        $holdList = Get-MailboxSearch | Select Name, InPlaceHoldIdentity
        $hash = @{}
        foreach ($hold in $holdList) {
            $hash.add($hold.InPlaceHoldIdentity, $hold.name)
            foreach ($row in $mailbox) {
                $new = @()
                if ($row.inplaceholds) {
                    if ($row.inplaceholds.split().count -gt 1) {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.getEnumerator() | Where {$_.name -match $hold}
                            $new += $temp.value + ","
                            $new = $new.trim()
                        }
                        $new = $new.trim(",")
                    }
                    else {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.getEnumerator() | Where {$_.name -match $hold}
                            $new += $temp.value
                        }
                    }   
                    $row.userprincipalname + "," + $new | Out-File "c:\scripts\test\With_Holds.csv" -Append -Encoding utf8
                }
                else {
                    $row.userprincipalname + "," + "" | Out-File "c:\scripts\test\Without_Holds.csv" -Append -Encoding utf8
                }
            }
        }
    }
    End {
    }
}