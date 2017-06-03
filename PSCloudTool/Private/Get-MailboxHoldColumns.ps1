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
function Get-MailboxHoldColumns {
    [CmdletBinding()]

    Param
    (

    )

    Begin {

    }
   
    Process {
        $Holds = [Environment]::GetFolderPath("MyDocuments") + "\withHolds-" + ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + ".csv")
        $NoHolds = [Environment]::GetFolderPath("MyDocuments") + "\withoutHolds-" + ($(get-date -Format yyyy-MM-dd_HH-mm-ss) + ".csv")
        $headerstring = "displayname,userprincipalname,IsInactiveMailbox,accountdisabled,RecipientTypeDetails,Hold01,Hold02,Hold03,Hold04,Hold05,Hold06"
        Out-File -FilePath $Holds -InputObject $headerstring -Encoding UTF8
        Out-File -FilePath $NoHolds -InputObject $headerstring -Encoding UTF8

        $mailbox = Get-Mailbox -IncludeInactiveMailbox -ResultSize 10 | Select displayname, userprincipalname, inplaceholds, IsInactiveMailbox, accountdisabled, RecipientTypeDetails
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
                "`"" + $row.displayname + "`"" + "," + $row.userprincipalname + "," + $row.IsInactiveMailbox + "," + $row.accountdisabled + "," + $row.RecipientTypeDetails + "," + $new | Out-File -FilePath $Holds -Encoding UTF8 -append
            } # BELOW CREATES CSV ROWS OF USERS WITHOUT IN-PLACE HOLDS
            else {
               "`"" + $row.displayname + "`"" + "," + $row.userprincipalname + "," + $row.IsInactiveMailbox + "," + $row.accountdisabled + "," + $row.RecipientTypeDetails | Out-File -FilePath $NoHolds -Encoding UTF8 -append
            }
        }
    }
    End {
    }
}