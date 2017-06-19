function Get-LAComplianceSearch {
    <#
.SYNOPSIS
   Reports on Compliance Searches (the predecessor to Get-MailboxSearch)

.DESCRIPTION
   Reports on Compliance Searches in the Office 365 Security & Compliance Center.  The commmand New-ComplianceSearch does not put any mailboxes on hold, therefor this only reports on searches.
   Holds are all now created through eDiscovery cases in the Office 365 Security & Compliance Center.
   Again, this report simply reports on "Searches"

   Make sure you are first connected to the Office 365 compliance service.  Simply use Get-LAConnected,  e.g. Get-LAConnected -Tenant Contoso -Compliance

   If run with the All switch, it will output all the searches, one per row and a column for each location (all locations of Exchange, SharePoint, OneDrive & PublicFolders)
   If run with no switches, it will output all included mailboxes with each search name
   If run with the SharePoint switch, it will output all included SharePoint Sites with each search name
   If run with the OneDrive switch, it will output all included OneDrive Sites with each search name
   If run with the PublicFolder switch, it will output all included Public Folders with each search name
   
.EXAMPLE
   Get-LAComplianceSearch | Export-Csv ./Exchangecompliancesearch.csv -notypeinformation

.EXAMPLE
   Get-LAComplianceSearch -SharePoint | Export-Csv ./SharePointSearches.csv -notypeinformation

.EXAMPLE
   Get-LAComplianceSearch -OneDrive | Export-Csv ./OneDriveSearches.csv -notypeinformation

.EXAMPLE
   Get-LAComplianceSearch -PublicFolder | Export-Csv ./PublicFolderSearches.csv -notypeinformation

.EXAMPLE
   Get-LAComplianceSearch -All | Export-Csv ./AllSearchesAllLocations.csv -notypeinformation

#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false)]
        [switch] $SharePoint,

        [Parameter(Mandatory = $false)]
        [switch] $OneDrive,

        [Parameter(Mandatory = $false)]
        [switch] $PublicFolder,
    
        [Parameter(Mandatory = $false)]
        [switch] $All
    )
    Begin {
        $resultArray = @()

    }
    Process {
        If ($All) {
            $searches = Get-ComplianceSearch | select name, @{n = "Mailboxes"; e = {(Get-ComplianceSearch $_.identity).ExchangeLocation}}, @{n = "SharePoint"; e = {(Get-ComplianceSearch $_.identity).SharePointLocation}}, @{n = "OneDrive"; e = {(Get-ComplianceSearch $_.identity).OneDriveLocation}}, @{n = "PublicFolder"; e = {(Get-ComplianceSearch $_.identity).PublicFolderLocation}}  
            $searches | Sort name
        }
        If ($SharePoint) {
            $searches = Get-ComplianceSearch | select name, @{n = "SharePoint"; e = {(Get-ComplianceSearch $_.identity).SharePointLocation}} 
            foreach ($row in $searches) {
                $searchHash = @{}
                if ($row.SharePoint) {
                    foreach ($site in $row.SharePoint) {
                        $searchHash['name'] = $row.name
                        $searchHash['SharePoint'] = $site
                        $resultArray += [psCustomObject]$searchHash
                    }    
                }
                else {
                    $searchHash['name'] = $row.name
                    $searchHash['SharePoint'] = "none"
                    $resultArray += [psCustomObject]$searchHash
                }
            }      
        }
        If ($OneDrive) {
            $searches = Get-ComplianceSearch | select name, @{n = "OneDrive"; e = {(Get-ComplianceSearch $_.identity).OneDriveLocation}} 
            foreach ($row in $searches) {
                $searchHash = @{}
                if ($row.OneDrive) {
                    foreach ($mbx in $row.OneDrive) {
                        $searchHash['Search'] = $row.name
                        $searchHash['OneDrive'] = $mbx
                        $resultArray += [psCustomObject]$searchHash
                    }    
                }
                else {
                    $searchHash['Search'] = $row.name
                    $searchHash['OneDrive'] = "none"
                    $resultArray += [psCustomObject]$searchHash
                }
            }     
            $resultArray | Select Search, OneDrive | Sort Search, OneDrive
        }
        If ($PublicFolder) {
            $searches = Get-ComplianceSearch | select name, @{n = "PublicFolder"; e = {(Get-ComplianceSearch $_.identity).PublicFolderLocation}} 
            foreach ($row in $searches) {
                $searchHash = @{}
                if ($row.PublicFolder) {
                    foreach ($mbx in $row.PublicFolder) {
                        $searchHash['Search'] = $row.name
                        $searchHash['PublicFolder'] = $mbx
                        $resultArray += [psCustomObject]$searchHash
                    }    
                }
                else {
                    $searchHash['Search'] = $row.name
                    $searchHash['PublicFolder'] = "none"
                    $resultArray += [psCustomObject]$searchHash
                }
            }     
            $resultArray | Select Search, PublicFolder | Sort Search, PublicFolder
        }
        If (!($All -or $SharePoint -or $OneDrive -or $PublicFolder)) {
            $searches = Get-ComplianceSearch | select name, @{n = "Mailbox"; e = {(Get-ComplianceSearch $_.identity).ExchangeLocation}} 
            foreach ($row in $searches) {
                $searchHash = @{}
                if ($row.Mailbox) {
                    foreach ($mbx in $row.Mailbox) {
                        $searchHash['Search'] = $row.name
                        $searchHash['Mailbox'] = $mbx
                        $resultArray += [psCustomObject]$searchHash
                    }    
                }
                else {
                    $searchHash['Search'] = $row.name
                    $searchHash['Mailbox'] = "none"
                    $resultArray += [psCustomObject]$searchHash
                }
            }     
            $resultArray | Select Search, Mailbox | Sort Search, mailbox
        }
    }
    End {
            
    }
}