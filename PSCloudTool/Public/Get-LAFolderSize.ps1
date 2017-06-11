function Get-LAFolderSize {
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
        [string[]] $upn
    )
    Begin {
        $resultArray = @()
    }
    Process {
            $stats = Get-MailboxFolderStatistics -Identity $_.userprincipalname |  where {$_.name -match "Recoverable Items|Top of Information Store"} | Select  @{name = "Size"; expression = {[math]::Round((($_.FolderAndSubfolderSize.ToString()).Split("(")[1].Split(" ")[0].Replace(",", "") / 1GB), 2)}}
            Write-Output "UPN: $($_.userprincipalname)"
            $Hash = [ordered]@{}
            $Hash['UserPrincipalName'] = $_.userprincipalname
            $Hash['RecoverableItemsSize'] = $stats[0].size
            $Hash['TotalSize'] = $stats[1].size
            $resultArray += [psCustomObject]$Hash  
    }
    End {
        $resultArray 
    }
}
