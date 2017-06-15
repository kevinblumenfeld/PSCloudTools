function Get-LAFolderSize {
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
        $mboxsize = Get-MailboxStatistics $userprincipalname | select-Object -ExpandProperty TotalItemSize | Select  @{name = "Size"; expression = {[math]::Round((($_.Value.ToString()).Split("(")[1].Split(" ")[0].Replace(",", "") / 1GB), 2)}}
        $reitemsize = (Get-MailboxFolderStatistics $userprincipalname -FolderScope RecoverableItems)[0] | select @{name = "Size"; expression = {[math]::Round((($_.FolderAndSubfolderSize.ToString()).Split("(")[1].Split(" ")[0].Replace(",", "") / 1GB), 2)}}
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