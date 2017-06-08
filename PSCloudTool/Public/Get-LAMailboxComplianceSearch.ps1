function Get-LAMailboxComplianceSearch {
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
    [CmdletBinding()]
    Param
    (

    )
    Begin {
 
    }
    Process {
        $resultArray = @()
        # $searchProperties = @("Name", "exchangelocation")
        $searches = Get-ComplianceSearch | select name, @{n = "Mailboxes"; e = {(Get-ComplianceSearch $_.identity).exchangelocation}}
        foreach ($row in $searches) {
            $sp = @{}
            $sp['name'] = $row.name
            foreach ($mbx in $row.Mailboxes) {
                $sp['mailbox'] = $mbx
                $resultArray += [psCustomObject]$sp
            }    
        }                              
    }
    End {
        $resultArray
    }
}