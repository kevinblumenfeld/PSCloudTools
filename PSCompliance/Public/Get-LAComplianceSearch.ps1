<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LaComplianceSearch {

    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false)]
        [switch] $SharePoint,

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
            $searches = Get-ComplianceSearch | % {Get-ComplianceSearch $_.identity | select name, Items, Size, ExchangeLocation, SharePointLocation, PublicFolderLocation, ContentMatchQuery}
            $searches | Sort name
        }
        If ($SharePoint) {
            $searches = Get-ComplianceSearch | % {Get-ComplianceSearch $_.identity | select name, Items, Size, SharePointLocation, ContentMatchQuery}
            foreach ($row in $searches) {
                $searchHash = [Ordered]@{}
                if ($row.SharePointLocation) {
                    foreach ($site in $row.SharePointLocation) {
                        $searchHash['Search'] = $row.name
                        $searchHash['Items'] = $row.Items
                        $searchHash['Size'] = $row.Size                                               
                        $searchHash['SharePointLocation'] = $site
                        $searchHash['Query'] = $row.ContentMatchQuery  
                        $resultArray += [psCustomObject]$searchHash
                    }    
                }
                else {
                    $searchHash['Search'] = $row.name
                    $searchHash['Items'] = $row.Items
                    $searchHash['Size'] = $row.Size                                               
                    $searchHash['SharePointLocation'] = 'None'
                    $searchHash['Query'] = $row.ContentMatchQuery  
                    $resultArray += [psCustomObject]$searchHash
                }
            }  
            $resultArray | Sort Search, SharePointLocation    
        }
        If ($PublicFolder) {
            $searches = Get-ComplianceSearch | % {Get-ComplianceSearch $_.identity | select name, Items, Size, PublicFolderLocation, ContentMatchQuery}
            foreach ($row in $searches) {
                $searchHash = [Ordered]@{}
                if ($row.PublicFolderLocation) {
                    foreach ($site in $row.PublicFolderLocation) {
                        $searchHash['Search'] = $row.name
                        $searchHash['Items'] = $row.Items
                        $searchHash['Size'] = $row.Size                                               
                        $searchHash['PublicFolderLocation'] = $site
                        $searchHash['Query'] = $row.ContentMatchQuery  
                        $resultArray += [psCustomObject]$searchHash
                    }    
                }
                else {
                    $searchHash['Search'] = $row.name
                    $searchHash['Items'] = $row.Items
                    $searchHash['Size'] = $row.Size                                               
                    $searchHash['PublicFolderLocation'] = 'None'
                    $searchHash['Query'] = $row.ContentMatchQuery  
                    $resultArray += [psCustomObject]$searchHash
                }
            }  
            $resultArray | Sort Search, PublicFolderLocation    
        }
        If (!($All -or $SharePoint -or $PublicFolder)) {
            $searches = Get-ComplianceSearch | % {Get-ComplianceSearch $_.identity | select name, Items, Size, ExchangeLocation, ContentMatchQuery}
            foreach ($row in $searches) {
                $searchHash = [Ordered]@{}
                if ($row.ExchangeLocation) {
                    foreach ($site in $row.ExchangeLocation) {
                        $searchHash['Search'] = $row.name
                        $searchHash['Items'] = $row.Items
                        $searchHash['Size'] = $row.Size                                               
                        $searchHash['ExchangeLocation'] = $site
                        $searchHash['Query'] = $row.ContentMatchQuery  
                        $resultArray += [psCustomObject]$searchHash
                    }    
                }
                else {
                    $searchHash['Search'] = $row.name
                    $searchHash['Items'] = $row.Items
                    $searchHash['Size'] = $row.Size                                               
                    $searchHash['ExchangeLocation'] = 'None'
                    $searchHash['Query'] = $row.ContentMatchQuery  
                    $resultArray += [psCustomObject]$searchHash
                }
            }  
            $resultArray | Sort Search, ExchangeLocation    
        }
    }
    End {
            
    }
}