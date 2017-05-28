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
        Write-Host "Find-Replace"
        Write-Output $hash
        Write-Output $MailboxHold
    }
   
    Process {
        Write-Output "PROCESS BLOCK!!!!!!!!!"
        foreach ($row in $MailboxHold) {
            $new = @()
            Write-Output "ROW: $ROW"
            if (!($OneHoldPerLine)) {
                if ($row.inplaceholds) {
                    if ($row.inplaceholds.split().count -gt 1) {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $new += $temp.Value.holdname + ","
                            $new = $new.trim()
                        }
                        $new = $new.trim(",")
                    }
                    else {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $new += $temp.Value.holdname
                        }
                    }   
                    $row.userprincipalname + "," + $new | Out-File "C:\scripts\test\With_Holds.csv" -Append -Encoding utf8
                } # BELOW CREATES CSV ROWS OF USERS WITHOUT IN-PLACE HOLDS
                else {
                    $row.userprincipalname + "," + "" | Out-File "C:\scripts\test\Without_Holds.csv" -Append -Encoding utf8
                }
            } # BEGIN One Hold Per Line
            else {
                if ($row.inplaceholds) {
                    if ($row.inplaceholds.split().count -gt 1) {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $new = $temp.Value.holdname + ","
                            $new = $new.trim()
                            Write-Output "NEW: $new"
                            $row.userprincipalname + "," + $new | Out-File "C:\scripts\test\With_Holds.csv" -Append -Encoding utf8
                        }
                        $new = $new.trim(",")
                    }
                    else {
                        ForEach ($hold in $row.inplaceholds.split()) {
                            $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $new = $temp.Value.holdname
                            $row.userprincipalname + "," + $new | Out-File "C:\scripts\test\With_Holds.csv" -Append -Encoding utf8
                        }
                    }   
                } 
                else {
                    $row.userprincipalname + "," + "" | Out-File "C:\scripts\test\Without_Holds.csv" -Append -Encoding utf8
                }
            } 
        }
    }

    End {
    }
}