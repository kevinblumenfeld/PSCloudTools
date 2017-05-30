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
        $script:hash = @{}
        foreach ($iHold in $InPlaceHold) {
            foreach ($id in $ihold.InPlaceHoldIdentity) {
                $script:hash[$id] = $iHold 
            } 
        }
    }
    End {
    }
}