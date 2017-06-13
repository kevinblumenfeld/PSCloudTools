function Get-LAMailboxLabelPolicy {
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
        [Parameter(Mandatory = $false)]
        [switch] $All,

        [Parameter(Mandatory = $false)]
        [switch] $Exchange,

        [Parameter(Mandatory = $false)]
        [switch] $SharePoint,

        [Parameter(Mandatory = $false)]
        [switch] $OneDrive,

        [Parameter(Mandatory = $false)]
        [switch] $Skype,

        [Parameter(Mandatory = $false)]
        [switch] $Groups,
        
        [Parameter(Mandatory = $false)]
        [switch] $WithExceptions,
        
        [Parameter(Mandatory = $false)]
        [switch] $OnlyExceptions
    )
    Begin {
        $resultArray = @()        
    
        if ($SharePoint -or $All) {
            for ($i = 0; $i -lt (Get-RetentionCompliancePolicy).count; $i++) {
                $getPol = (Get-RetentionCompliancePolicy -DistributionDetail)[$i]
                if ($WithExceptions -or $OnlyExceptions) {
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "SharePointSites"; e = {$getPol | Select -ExpandProperty SharePointLocationException}}

                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.SharePointSites) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "OneDrive"
                        $hash['Exception'] = "True"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
                if (!($OnlyExceptions)) {
                    
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "SharePointSites"; e = {$getPol | Select -ExpandProperty SharePointLocation}}
                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.SharePointSites) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "OneDrive"
                        $hash['Exception'] = "False"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
            }
        }        

        if ($OneDrive -or $All) {
            for ($i = 0; $i -lt (Get-RetentionCompliancePolicy).count; $i++) {
                $getPol = (Get-RetentionCompliancePolicy -DistributionDetail)[$i]
                if ($WithExceptions -or $OnlyExceptions) {
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "OneDriveLocations"; e = {$getPol | Select -ExpandProperty OneDriveLocationException}}

                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.OneDriveLocations) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "OneDrive"
                        $hash['Exception'] = "True"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
                if (!($OnlyExceptions)) {
                    
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "OneDriveLocations"; e = {$getPol | Select -ExpandProperty OneDriveLocation}}
                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.OneDriveLocations) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "OneDrive"
                        $hash['Exception'] = "False"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
            }
        }    
        if ($Skype -or $All) {
            for ($i = 0; $i -lt (Get-RetentionCompliancePolicy).count; $i++) {
                $getPol = (Get-RetentionCompliancePolicy -DistributionDetail)[$i]
                if ($WithExceptions) {
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "SkypeLocations"; e = {$getPol | Select -ExpandProperty SkypeLocationException}}

                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.SkypeLocations) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "Skype"
                        $hash['Exception'] = "True"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
                if (!($OnlyExceptions)) {
                    
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "SkypeLocations"; e = {$getPol | Select -ExpandProperty SkypeGroupLocation}}
                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.SkypeLocations) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "Skype"
                        $hash['Exception'] = "False"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
            }
        }    
        if ($Groups -or $All) {
            for ($i = 0; $i -lt (Get-RetentionCompliancePolicy).count; $i++) {
                $getPol = (Get-RetentionCompliancePolicy -DistributionDetail)[$i]
                if ($WithExceptions -or $OnlyExceptions) {
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "GroupLocations"; e = {$getPol | Select -ExpandProperty ModernGroupLocationException}}

                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.GroupLocations) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "Groups"
                        $hash['Exception'] = "True"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
                if (!($OnlyExceptions)) {
                    
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "GroupLocations"; e = {$getPol | Select -ExpandProperty ModernGroupLocation}}
                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.GroupLocations) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "Groups"
                        $hash['Exception'] = "False"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
            }
        }    
        if ($Exchange -or $All) {
            for ($i = 0; $i -lt (Get-RetentionCompliancePolicy).count; $i++) {
                $getPol = (Get-RetentionCompliancePolicy -DistributionDetail)[$i]
                if ($WithExceptions -or $OnlyExceptions) {
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "Mailboxes"; e = {$getPol | Select -ExpandProperty ExchangeLocationException}}

                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.Mailboxes) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "Exchange"
                        $hash['Exception'] = "True"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
                if (!($OnlyExceptions)) {
                    
                    $labelPolicy = $getPol | select name, type, enabled, mode, comment, @{n = "Mailboxes"; e = {$getPol | Select -ExpandProperty ExchangeLocation}}
                    $hash = [ordered]@{}
                    foreach ($policyLocation in $labelPolicy.Mailboxes) {
                        $hash['DisplayName'] = $policyLocation.DisplayName
                        $hash['Locations'] = $policyLocation.name
                        $hash['Policy'] = $labelPolicy.name
                        $hash['ContentLocation'] = "Exchange"
                        $hash['Exception'] = "False"
                        $hash['Type'] = $labelPolicy.type
                        $hash['Enabled'] = $labelPolicy.enabled
                        $hash['Mode'] = $labelPolicy.mode
                        $hash['comment'] = $labelPolicy.comment
                        $resultArray += [psCustomObject]$hash  
                    } 
                }
            }
        }    
    }
    Process {
    }
    End {
        $resultArray | Sort Policy, DisplayName
    }
}