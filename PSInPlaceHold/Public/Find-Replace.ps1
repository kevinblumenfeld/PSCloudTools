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
        $FindParameter = "inplaceholds"
        $DynamicVars = @()
        $Props = @()
        $f = @()
        $Props = $MailboxHold | Get-Member -MemberType 'NoteProperty'| where {$_.Name -ne $FindParameter}| Select Name
        $DynamicVars = $Props.name -join ","
        # $DynamicVars = "`$`(`$row." + ($Props.name -join "`) + `",`" + `$`(`$row.")
        # $DynamicVars = $DynamicVars + "`)"
        Write-Host "DynamicVARS: $DynamicVars"
    }
   
    Process {
        # Row by Row of each Mailbox to...
        #   FIND    (in this case, INPLACEHOLDS)  - (Get-Mailbox) 
        #   REPLACE (in this case, NAME) - matched from hashtable of InPlaceHolds - (created with Get-MailboxSearch)
        $resultArray = @()
        $line = @{}
        foreach ($row in $MailboxHold) {
            $line = @{}
            foreach ($field in $Props.name) {
                $line[$field] = ($row.$field) -join ","
            }
            $resultArray += [pscustomobject]$line
            $Replace = @()
            if (!($OneHoldPerLine)) {
                if ($row.$FindParameter) {
                    if ($row.$FindParameter.split().count -gt 1) {
                        ForEach ($hold in $row.$FindParameter.split()) {
                            $Find = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $Replace += $Find.Value.holdname + ","
                            $Replace = $Replace.trim()
                        }
                        $Replace = $Replace.trim(",")
                        # Write-Host "REPLACE: $Replace"
                        $it = $it + $Replace
                    }
                    else {
                        ForEach ($hold in $row.$FindParameter.split()) {
                            $Find = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $Replace += $Find.Value.holdname
                            # Write-Host "REPLACE: $Replace"
                            $it = $it + $Replace
                        }
                    } 
                    ([PScustomobject]$resultArray)|Export-Csv "C:\scripts\test\asdsdsdf.csv" -nti
                    
                    # Write-Output "IT: $it"
                    # &([scriptblock]::Create($DynamicVars)) |Out-File "C:\scripts\test\With_Holds.csv" -Append -Encoding utf8
                } # BELOW CREATES CSV ROWS OF USERS WITHOUT IN-PLACE HOLDS
                else {
                    "$DynamicVars" | Out-File "C:\scripts\test\Without_Holds.csv" -Append -Encoding utf8
                }
            } # BEGIN One Hold Per Line
            else {
                Write-Host "INTO ONEHOLDPERLINE!!!!!!!!!!!!"
                if ($row.$FindParameter) {
                    if ($row.$FindParameter.split().count -gt 1) {
                        ForEach ($hold in $row.$FindParameter.split()) {
                            $Find = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $Replace = $Find.Value.holdname + ","
                            $Replace = $Replace.trim()
                            # Write-Output "NEW: $Replace"
                            $DynamicVars + "," + $Replace | Out-File "C:\scripts\test\With_Holds.csv" -Append -Encoding utf8
                        }
                        $Replace = $Replace.trim(",")
                    }
                    else {
                        ForEach ($hold in $row.$FindParameter.split()) {
                            $Find = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                            $Replace = $Find.Value.holdname
                            $DynamicVars + "," + $Replace | Out-File "C:\scripts\test\With_Holds.csv" -Append -Encoding utf8
                        }
                    }   
                } 
                else {
                    $DynamicVars + "," + "" | Out-File "C:\scripts\test\Without_Holds.csv" -Append -Encoding utf8
                }
            } 
        }
    }

    End {
    }
}