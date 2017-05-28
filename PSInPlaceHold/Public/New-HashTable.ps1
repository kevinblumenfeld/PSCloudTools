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
function New-HashTable() {
    [CmdletBinding()]

    Param
    (

    )

    Begin {
    }
   
    Process {
        Write-Host "New-HashTable"
        # Write-Host $($InPlaceHold[1].name)
        # Write-Host $InPlaceHold.gettype()
        # $InPlaceHold = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate
        $script:hash = @{}
        foreach ($iHold in $InPlaceHold) {
            Write-Host "iHold: $($iHold.InPlaceHoldIdentity)"
            $script:hash.add($iHold.InPlaceHoldIdentity, @{holdname = $iHold.name; status = $iHold.status; version = $iHold.version; StartDate = $iHold.startdate; EndDate = $iHold.enddate})
        }
        $hash
    }
    
    End {
    }
}