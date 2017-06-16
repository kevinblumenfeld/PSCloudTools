function Get-LAMfaStats {
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
        [string[]] $userprincipalname
    )
    Begin {
        $resultarray = @()
    }
    Process {
        $logProps = Export-MailboxDiagnosticLogs $_.userprincipalname -ExtendedProperties
        $xmlprops = [xml]($logProps.MailboxLog)
        $stats = $xmlprops.Properties.MailboxTable.Property | ? {$_.Name -like "ELC*"} 
        $statHash = [ordered]@{}
        for ($i = 0; $i -lt $stats.count; $i++) {
            $statHash['UPN'] = $_.userprincipalname
            $statHash[$stats[$i].name] = $stats[$i].value
        }
        $resultarray += [PSCustomObject]$statHash
    }
    End {
        $resultarray
    }
}