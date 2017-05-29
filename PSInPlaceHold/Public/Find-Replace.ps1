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
        $Props = @()
        $Props = $MailboxHold | Get-Member -MemberType 'NoteProperty'| where {$_.Name -ne $FindParameter}| Select Name
    }
   
    Process {
        $resultArray = @()
        $find = @()
        $row = @()
        foreach ($row in $MailboxHold) {
            $line = @{}
            $Replace = @{}
            foreach ($field in $Props.name) {
                $line[$field] = ($row.$field) -join ","
            }
            $resultArray += [pscustomobject]$line

            ForEach ($hold in $row.$FindParameter.split()) {
                $Find = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                $replace[$hold] = ($Find.Value.psbase.holdname) -join ","
            }
            $resultArray += [pscustomobject]$Replace
        }
    }

    End {
        $resultArray
        ([PScustomobject]$resultArray)|Export-Csv "C:\scripts\test\333.csv" -nti
    }
}