function Get-LAMailboxInPlaceHold {
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
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [string[]] $list
    )
    Begin {
        $row = @()
        $resultArray = @()
        $findParameter = "InPlaceHolds"
        $mbxSearch = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate, sourcemailboxes, ItemHoldPeriod
                
        $hash = @{}
        foreach ($sRow in $mbxSearch) {
            foreach ($id in $sRow.InPlaceHoldIdentity) {
                $hash[$id] = $sRow 
            }
        }
    }
    Process {
        if (! $mailboxProperties) {
            $mailboxProperties = Get-Mailbox -Identity $_.userprincipalname | Select displayname, userprincipalname, IsInactiveMailbox, accountdisabled, RecipientTypeDetails, inplaceholds| Get-Member -MemberType 'NoteProperty' | Select Name
        }
        foreach ($mailbox in $list) {   
            $row = Get-Mailbox -ResultSize 1 -Identity $mailbox
            ForEach ($guid in $row.$findParameter) {
                $mailboxHash = @{}
                $mailboxHash['InPlaceHoldName'] = ($hash[$guid]).name
                $mailboxHash['StatusofHold'] = ($hash[$guid]).Status
                $mailboxHash['StartDate'] = ($hash[$guid]).StartDate
                $mailboxHash['EndDate'] = ($hash[$guid]).EndDate    
                $mailboxHash['ItemHoldPeriod'] = ($hash[$guid]).ItemHoldPeriod   
                foreach ($field in $mailboxProperties.name) {
                    $mailboxHash[$field] = ($row.$field) -join ","
                }                                            
                $resultArray += [psCustomObject]$mailboxHash        
            }
        }
    }
    End {
        $resultArray | Select displayname, userprincipalname, InPlaceHoldName, IsInactiveMailbox, accountdisabled, ItemHoldPeriod, RecipientTypeDetails, StatusofHold, StartDate, EndDate, inplaceholds
    }
}