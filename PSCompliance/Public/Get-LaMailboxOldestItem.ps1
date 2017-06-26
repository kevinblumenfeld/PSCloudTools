<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LaMailboxOldestItem {

    Param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true)]
        [String]$userprincipalname,
        
        [Parameter(Mandatory = $false)]
        [switch] $IncludeRecoverableItems,
    
        [Parameter(Mandatory = $false)]
        [switch] $RecoverableItemsOnly
    )
    Begin {
        $resultArray = @()
    }
    Process {
        $oldest = $null
        $ageHash = [ordered]@{}
        if (!$IncludeRecoverableItems -or !$RecoverableItemsOnly) {
            Get-Mailbox -Identity $_.userprincipalname | Select userprincipalname | 
                ForEach-Object {Get-MailboxFolderStatistics -Identity $_.userprincipalname -IncludeOldestAndNewestItems} | 
                where ( {$_.TargetQuota -ne 'Recoverable'}) | Select OldestItemReceivedDate | ForEach-Object {
                if ($_.OldestItemReceivedDate -and (!$oldest -or $oldest -gt $_.OldestItemReceivedDate.tolocaltime())) {
                    $oldest = $_.OldestItemReceivedDate.tolocaltime()
                }
            }
        }
        if ($IncludeRecoverableItems) {
            Get-Mailbox -Identity $_.userprincipalname | Select userprincipalname | 
                ForEach-Object {Get-MailboxFolderStatistics -Identity $_.userprincipalname -IncludeOldestAndNewestItems} | 
                Select OldestItemReceivedDate | ForEach-Object {
                if ($_.OldestItemReceivedDate -and (!$oldest -or $oldest -gt $_.OldestItemReceivedDate.tolocaltime())) {
                    $oldest = $_.OldestItemReceivedDate.tolocaltime()
                }
            }
        }
        if ($RecoverableItemsOnly) {
            Get-Mailbox -Identity $_.userprincipalname | Select userprincipalname | 
                ForEach-Object {Get-MailboxFolderStatistics -Identity $_.userprincipalname -IncludeOldestAndNewestItems} | 
                where ( {$_.TargetQuota -eq 'Recoverable'}) | Select OldestItemReceivedDate | ForEach-Object {
                if ($_.OldestItemReceivedDate -and (!$oldest -or $oldest -gt $_.OldestItemReceivedDate.tolocaltime())) {
                    $oldest = $_.OldestItemReceivedDate.tolocaltime()
                }
            }
        }
        $ageHash['Name'] = $_.userprincipalname
        $ageHash['OldestItem'] = $Oldest
        $resultArray += [psCustomObject]$ageHash
    }
    End {
        return $resultArray
    }
}