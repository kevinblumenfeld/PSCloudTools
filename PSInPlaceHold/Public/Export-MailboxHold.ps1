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
function Export-MailboxHold() {
    [CmdletBinding()]
    
    Param
    (
        [Parameter(Mandatory = $false, Position = 0)] 
        [string]$csv,
        
        [Parameter(Mandatory = $false, Position = 1)] 
        [string]$find,
        
        [Parameter(Mandatory = $false, Position = 2)] 
        [string]$replace
    )

    Begin {
    }
   
    Process {
        Write-Host "Export-MailboxHold"
        if (!($csv)) {
            Get-MailboxHold
        }        
        else {
            if (!(Test-Path $csv)) {
                Write-Output "File Path/Name $csv is invalid. Please provide proper path to CSV"
            }
            Try {
                Write-Host "IMPORTCSV!!!!!!!!!"
                $script:MailboxHold = Import-Csv $csv # -ErrorAction SilentlyContinue
            }
            Catch {
                throw $_
                Write-Output "Import of $csv failed. Please verify CSV is structured properly"
            }
            
        }
        
        Get-InPlaceHold
        New-HashTable # -hashkey InPlaceHoldIdentity
        Find-Replace
    }

    End {
    }
}