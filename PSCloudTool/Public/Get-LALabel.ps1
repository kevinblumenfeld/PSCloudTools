function Get-LALabel {
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