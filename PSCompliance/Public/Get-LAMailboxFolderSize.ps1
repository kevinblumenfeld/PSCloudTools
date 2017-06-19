function Get-LAMailboxFolderSize {
    <#

.SYNOPSIS
   Retrieves each mailbox's:
   1. entire TotalItemSize 
   2. and more specifically, TotalItemSize for just the RecoverableItems folder

.DESCRIPTION
   Requires mandatory value(s) from the pipeline.  Specifically, objects that contain the mailbox's UserPrincipalName.
   A CSV is not mandatory as a command could pass the necessary information from the pipeline.
   However, a CSV could certainly be used to break up large datasets.

   Note: This function executes two commands per mailbox and could be subject to Office 365 throttling.
         Therefor, for large tenants it is best to break up mailboxes into CSV's of 5,000 or less UPNS.
         For best results, no more than 2 concurrent sessions of this function should be run.
         It may be necessary to contact Office 365 support to have some throttling reduced.


   A CSV could look like this

   UserPrincipalName
   user01@contoso.com
   user02@contoso.com
   user03@contoso.com
   user04@contoso.com

.EXAMPLE
    Get-Mailbox -identity user01@contoso.com | Select UserPrincipalName | Get-LAFolderSize

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAFolderSize | Out-GridView

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAFolderSize | Export-Csv ./FolderSizes.csv -notypeinformation

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Export-Csv ./upns.csv -notypeinformation
   Import-Csv ./upns.csv | Get-LAFolderSize | Export-Csv ./FolderSizes.csv -notypeinformation

#>
    Param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            ValueFromPipeline = $true)]
        [String]$userprincipalname
    )
    Begin {
        $resultArray = @()
    }
    Process {
        Write-Host "UPN: $UserPrincipalName"
        $mboxsize = Get-MailboxStatistics $_.userprincipalname | select-Object -ExpandProperty TotalItemSize | Select  @{name = "Size"; expression = {[math]::Round((($_.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",", "") / 1GB), 2)}}
        $reitemsize = (Get-MailboxFolderStatistics $_.userprincipalname -FolderScope RecoverableItems)[0] | select @{name = "Size"; expression = {[math]::Round((($_.FolderAndSubfolderSize.ToString()).Split("(")[1].Split(" ")[0].Replace(",", "") / 1GB), 2)}}
        $hash = [Ordered]@{}
        $hash['UserPrincipalName'] = $userprincipalname
        $hash['RecoverableItemsSize'] = $reitemsize.size
        $hash['TotalSize'] = $mboxsize.size
        $resultArray += [psCustomObject]$hash 
    }
    End {
        return $resultArray
    }
}