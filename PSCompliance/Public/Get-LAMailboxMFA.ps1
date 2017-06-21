function Get-LAMailboxMFA {
    <#
.Synopsis
   Reports on several key indicators of the Managed Folder Assistant against one or many mailboxes

.DESCRIPTION
   Reports on several key indicators of the Managed Folder Assistant against one or many mailboxes.
   One of which is the last time the managed folder assistant processed the mailbox
   
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