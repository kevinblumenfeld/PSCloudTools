function Get-LAMailboxLabelPolicy {
    <#
.Synopsis
   Reports on all Label Policies located in the Security and Compliance Center

.DESCRIPTION
   Reports on all Label Policies located in the Security and Compliance Center
   Label Policies contain labels.

   The Label Policies are applied to (either include OR exclude) 4 different locations/workflows.  
   1. Exchange Email
   2. SharePoint Sites
   3. OneDrive Accounts
   4. Office 365 Groups

   A Label Policy can contain be made up either a set of inclusions or exclusions from anywhere to 1 - 4 locations/workflows.
   For Example, a Label Policy cannot exclude the mailbox of USER01 and include the mailbox of USER02.  It is one or the other.

   This function will display each policy and the included locations and/or the excluded locations of all 4 workflows.

   If the location column displays, "ALL", then all locations of that workflow are included. For example, all mailboxes or all sharePoint sites
   The location column will otherwise display a specific location, for example, a specific mailbox or specific sharepoint site.

   The column ContentLocation can have one if 8 possibilities (all of which are fairly self-explainatory):

   1. Exchange
   2. SharePoint
   3. OneDrive
   4. Groups
   5. Exchange_Exception
   6. SharePoint_Exception
   7. OneDrive_Exception
   8. Groups_Exception   

.EXAMPLE
   Get-LAMailboxLabelPolicy -All -WithExceptions | Out-GridView
   This will display everything so this is a good command to start with.

.EXAMPLE
   Get-LAMailboxLabelPolicy -Exchange -OnlyExceptions | Out-GridView

.EXAMPLE
   Get-LAMailboxLabelPolicy -SharePoint -WithExceptions | Out-GridView

.EXAMPLE
   Get-LAMailboxLabelPolicy -SharePoint -OnlyExceptions | Export-Csv ./sharepointexceptions.csv -notypeinformation

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
                        $hash['ContentLocation'] = "SharePoint_Exception"
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
                        $hash['ContentLocation'] = "SharePoint"
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
                        $hash['ContentLocation'] = "OneDrive_Exception"
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
                        $hash['ContentLocation'] = "Skype_Exception"
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
                        $hash['ContentLocation'] = "Groups_Exception"
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
                        $hash['ContentLocation'] = "Exchange_Exception"
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