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
function Find-Replace() {
    [CmdletBinding()]

    Param
    (
        [Parameter(Mandatory = $False)]
        [switch] $OneHoldPerLine

    )

    Begin {
        $file = import-csv "C:\scripts\lausd\LA_Mbx_upn_holds.csv"
        $HoldList = Get-MailboxSearch | Select Name, InPlaceHoldIdentity
        $hash = @{}
        foreach ($Hold in $HoldList) {
            $hash.add($hold.InPlaceHoldIdentity, $hold.name)
        }
    }
   
    Process {
        foreach ($row in $file) {
            $new = @()
            if (!($OneHoldPerLine)) {
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
                    $row.userprincipalname + "," + $new | Out-File ".\With_Holds.csv" -Append -Encoding utf8
                } # BELOW CREATES CSV ROWS OF USERS WITHOUT IN-PLACE HOLDS
                else {
                    $row.userprincipalname + "," + "" | Out-File ".\Without_Holds.csv" -Append -Encoding utf8
                }
            } # BEGIN One Hold Per Line
            else {
                if ($row.inplaceholds) {
                    if ($row.inplaceholds.split().count -gt 1) {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $new = $temp.Value + ","
                            $new = $new.trim()
                            $row.userprincipalname + "," + $new | Out-File ".\With_Holds.csv" -Append -Encoding utf8
                        }
                        $new = $new.trim(",")
                    }
                    else {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $new = $temp.Value
                            $row.userprincipalname + "," + $new | Out-File ".\With_Holds.csv" -Append -Encoding utf8
                        }
                    }   
                } 
                else {
                    $row.userprincipalname + "," + "" | Out-File ".\Without_Holds.csv" -Append -Encoding utf8
                }
            } 
        }
    }
    End {
    }
}