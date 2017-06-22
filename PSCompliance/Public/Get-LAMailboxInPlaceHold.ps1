function Get-LAMailboxInPlaceHold {
    <#
.SYNOPSIS
   Reports on the legacy In-Place Holds for each mailbox

.DESCRIPTION
   Reports on the legacy In-Place Holds for each mailbox.
   For easy sorting and readability, if a mailbox has more than one In-Place Hold, the mailbox and the cooresponding hold is listed one per row.
   In other words, if a mailbox has 3 legacy holds, that mailbox will appear on three rows.

   Mailbox UPNs should be passed from the pipeline as demonstrated in the examples below.

   Individual mailboxes, all mailboxes, all mailboxes in a department are all possibilities.

   Also demonstrated in an example below is importing mailboxes (UPNs) from a CSV
   
   A CSV could look like this

   UserPrincipalName
   user01@contoso.com
   user02@contoso.com
   user03@contoso.com
   user04@contoso.com

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxInPlaceHold | Out-GridView

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxInPlaceHold | Export-Csv .\legacyholds.csv -notypeinformation

.EXAMPLE
   Import-Csv .\upns.csv | Get-LAMailboxInPlaceHold | Export-Csv .\legacyHoldsbyMailbox.csv -notypeinformation

.EXAMPLE
   Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LAMailboxInPlaceHold | Export-Csv .\HRsHolds.csv -NoTypeInformation
   
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
            foreach ($mailbox in $each) {   
                ForEach ($guid in $mailbox.$findParameter) {
                    if (!($guid.Substring(0, 3) -eq "mbx") -and !($guid.Substring(0, 1) -eq "-") -and !($guid.Substring(0, 3) -eq "uni") -and !($guid.Substring(0, 3) -eq "skp")) {
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
        else {
            $each = Get-Mailbox -Identity $_.userprincipalname | where {$_.inplaceholds -eq $null}
            foreach ($mailbox in $each) {   
                ForEach ($guid in $mailbox.$findParameter) {
                    if (!($guid.Substring(0, 3) -eq "mbx") -and !($guid.Substring(0, 1) -eq "-") -and !($guid.Substring(0, 3) -eq "uni") -and !($guid.Substring(0, 3) -eq "skp")) {
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
    }
    End {
        $resultArray | Select displayname, userprincipalname, InPlaceHoldName, IsInactiveMailbox, accountdisabled, ItemHoldPeriod, RecipientTypeDetails, StatusofHold, StartDate, EndDate, inplaceholds
    }
}