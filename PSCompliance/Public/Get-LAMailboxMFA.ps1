function Get-LAMailboxMFA {
    <#
.SYNOPSIS
   Reports on several key indicators of the Managed Folder Assistant against one or more mailboxes.
   Also it can start the Managed Folder Assistant for one more or more mailboxes.

.DESCRIPTION
   Reports on several key indicators of the Managed Folder Assistant against one or more mailboxes.
   Also it can start the Managed Folder Assistant for one more or more mailboxes.
   
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
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxMFA | Out-GridView

.EXAMPLE
   Get-Mailbox -identity "user01@contoso.com" | Select UserPrincipalName | Get-LAMailboxMFA -StartMFA

   ** This command starts the Managed Folder Assistant and could be subject to Microsoft throttling **

.EXAMPLE
   Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxMFA | Export-Csv .\MFAstats.csv -notypeinformation

.EXAMPLE
   Import-Csv .\upns.csv | Get-LAMailboxMFA | Export-Csv .\MFAstats.csv -notypeinformation

.EXAMPLE
   Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LAMailboxMFA | Export-Csv .\HRsMFAstats.csv -NoTypeInformation
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