function Get-LALabel {
    <#
.Synopsis
   Report on each Label Policy and the Labels linked to each(policy).  Also, reports on Office 365 Retention Policies

.DESCRIPTION
   Report on each Label Policy and the Labels linked to each(policy).  Also, reports on Office 365 Retention Policies

   Make sure you are first connected to compliance when using Get-LAConnected,  e.g. Get-LAConnected -Tenant Contoso -Compliance

.EXAMPLE
   Get-LAConnected -Tenant Contoso -Compliance
   Get-LALabel | Out-GridView

.EXAMPLE
   Get-LAConnected -Tenant Contoso -Compliance
   Get-LALabel | Export-Csv ./labelsandpols.csv -notypeinformation

#>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory = $false)]
        [switch] $SortbyTag,

        [Parameter(Mandatory = $false)]
        [switch] $SortbyPolicy
    )
    Begin {

    }
    Process {
        $resultArray = @()
        $policies = Get-RetentionCompliancePolicy | Select name, guid, comment, type
        $labels = Get-RetentionComplianceRule | Select Policy, RetentionComplianceAction, RetentionDuration, Priority, mode, disabled, @{n = "LabelName"; e = {($_.ComplianceTagProperty).split(",")[1]}}
        
        $policyHash = @{}
        foreach ($policy in $policies) {
            $policyHash[$policy.guid] = $policy 
        }
        foreach ($label in $labels) {           
            $labelHash = [ordered]@{}
            $labelHash['LabelName'] = $label.LabelName
            $labelHash['PolicyName'] = $policyHash[$label.policy].name
            $labelHash['RetentionComplianceAction'] = $label.RetentionComplianceAction
            $labelHash['RetentionDuration'] = $label.RetentionDuration
            $labelHash['Priority'] = $label.Priority
            $labelHash['Mode'] = $label.mode
            $labelHash['Disabled'] = $label.Disabled                                                           
            $resultArray += [psCustomObject]$labelHash        
        }
    }
    End {
        $resultArray 
    }
}