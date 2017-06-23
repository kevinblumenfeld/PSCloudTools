<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LAComplianceSearch {

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