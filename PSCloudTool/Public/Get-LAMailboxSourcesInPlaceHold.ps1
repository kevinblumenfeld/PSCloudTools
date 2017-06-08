function Get-LAMailboxSourcesInPlaceHold {
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
        $resultArray = @()
        $findParameter = "SourceMailboxes"
        $mbxSearch = Get-MailboxSearch -ResultSize Unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate, ItemHoldPeriod, @{n = "SourceMailboxes"; e = { (Get-MailboxSearch $_.Identity).SourceMailboxes}}, @{n="SearchQuery";e={ (Get-MailboxSearch $_.Identity).SearchQuery}}
                        
        $hash = @{}
        foreach ($sRow in $mbxSearch) {
            foreach ($id in $sRow.SourceMailboxes) {
                $hash[$id] = $sRow 
            }
        }
    }
    Process {
        ForEach ($source in $mbxSearch.$findParameter) {
            $mailboxHash = @{}
            $mailboxHash['InPlaceHoldName'] = ($hash[$source]).Name
            $mailboxHash['SourceMailboxes'] = $source            
            $mailboxHash['StatusofHold'] = ($hash[$source]).Status
            $mailboxHash['StartDate'] = ($hash[$source]).StartDate
            $mailboxHash['EndDate'] = ($hash[$source]).EndDate    
            $mailboxHash['ItemHoldPeriod'] = ($hash[$source]).ItemHoldPeriod   
            $mailboxHash['SearchQuery'] = ($hash[$source]).SearchQuery                                                
            $resultArray += [psCustomObject]$mailboxHash        
        }
    }
    End {
        $resultArray | Select InPlaceHoldName, SourceMailboxes, SearchQuery, ItemHoldPeriod, StatusofHold, StartDate, EndDate
    }
}