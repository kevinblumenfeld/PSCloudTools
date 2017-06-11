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
        [Parameter(Mandatory = $false)]
        [switch] $WithoutInPlaceHold,
        
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true)]
        [object[]]$list
    )
    Begin {
        $resultArray = @()
        $findParameter = "InPlaceHolds"
        $mailboxProperties = @("displayname", "userprincipalname", "IsInactiveMailbox", "accountdisabled", "RecipientTypeDetails", "inplaceholds")
        $mbxSearch = Get-MailboxSearch -ResultSize unlimited | select name, inplaceholdidentity, Status, version, StartDate, EndDate, sourcemailboxes, ItemHoldPeriod
                
        $hash = @{}
        foreach ($sRow in $mbxSearch) {
            foreach ($id in $sRow.InPlaceHoldIdentity) {
                $hash[$id] = $sRow 
            }
        }
    }
    Process {
        if (!($WithoutInPlaceHold)) {
            $each = Get-Mailbox -Identity $_.userprincipalname
            write-host "UPN: $($each.userprincipalname)"
            foreach ($mailbox in $each) {   
                ForEach ($guid in $mailbox.$findParameter) {
                    $mailboxHash = @{}
                    $mailboxHash['InPlaceHoldName'] = ($hash[$guid]).name
                    $mailboxHash['StatusofHold'] = ($hash[$guid]).Status
                    $mailboxHash['StartDate'] = ($hash[$guid]).StartDate
                    $mailboxHash['EndDate'] = ($hash[$guid]).EndDate    
                    $mailboxHash['ItemHoldPeriod'] = ($hash[$guid]).ItemHoldPeriod   
                    foreach ($field in $mailboxProperties) {
                        $mailboxHash[$field] = ($mailbox.$field) -join ","
                    }                                            
                    $resultArray += [psCustomObject]$mailboxHash        
                }
            }
        }
        else {
            $each = Get-Mailbox -Identity $_.userprincipalname | where {$_.inplaceholds -eq $null}
            write-host "NoHold UPN: $($each.userprincipalname)"
            foreach ($mailbox in $each) {   
                ForEach ($guid in $mailbox.$findParameter) {
                    $mailboxHash = @{}
                    $mailboxHash['InPlaceHoldName'] = ($hash[$guid]).name
                    $mailboxHash['StatusofHold'] = ($hash[$guid]).Status
                    $mailboxHash['StartDate'] = ($hash[$guid]).StartDate
                    $mailboxHash['EndDate'] = ($hash[$guid]).EndDate    
                    $mailboxHash['ItemHoldPeriod'] = ($hash[$guid]).ItemHoldPeriod   
                    foreach ($field in $mailboxProperties) {
                        $mailboxHash[$field] = ($mailbox.$field) -join ","
                    }                                            
                    $resultArray += [psCustomObject]$mailboxHash        
                }
            }
        }
    }
    End {
        $resultArray | Select displayname, userprincipalname, InPlaceHoldName, IsInactiveMailbox, accountdisabled, ItemHoldPeriod, RecipientTypeDetails, StatusofHold, StartDate, EndDate, inplaceholds
    }
}