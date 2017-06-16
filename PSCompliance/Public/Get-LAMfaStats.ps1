function Get-LAmfaStats {
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
        [string[]] $userprincipalname,
        
        [Parameter(Mandatory = $false)]
        [switch] $Archive,
  
        [Parameter(Mandatory = $false)]
        [switch] $StartMFA
    )
    Begin {
        $resultarray = @()
    }
    Process {
        if ($StartMFA) {
            Write-Output "Starting Managed Folder Assistant on: $($_.UserPrincipalName)"
            Start-ManagedFolderAssistant $_.userprincipalname
        }
        else {
            if ($Archive) {
                $logProps = Export-MailboxDiagnosticLogs $_.userprincipalname -ExtendedProperties -Archive
            }
            else {
                $logProps = Export-MailboxDiagnosticLogs $_.userprincipalname -ExtendedProperties
            }
            $xmlprops = [xml]($logProps.MailboxLog)
            $stats = $xmlprops.Properties.MailboxTable.Property | ? {$_.Name -like "ELC*"} 
            $statHash = [ordered]@{}
            for ($i = 0; $i -lt $stats.count; $i++) {
                $statHash['UPN'] = $_.userprincipalname
                $statHash[$stats[$i].name] = $stats[$i].value
            }
            $resultarray += [PSCustomObject]$statHash
        }

    }
    End {
        $resultarray
    }
}