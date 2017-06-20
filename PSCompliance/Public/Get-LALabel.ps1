function Get-LALabel {
    <#
.Synopsis
   Report on each Label Policy and the Labels linked to each(policy).  Also, reports on Office 365 Retention Policies

.DESCRIPTION
   Report on each Label Policy and the Labels linked to each(policy).  Also, reports on Office 365 Retention Policies

   Make sure you are first connected to the Office 365 compliance service.  Simply use Get-LAConnected,  e.g. Get-LAConnected -Tenant Contoso -Compliance

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

    )
    Begin {

    }
    Process {
        $resultArray = @()
        $policies = Get-RetentionCompliancePolicy | Select name, guid, comment, type
        $rules = Get-RetentionComplianceRule | Select Name, Policy, RetentionComplianceAction, RetentionDuration, Priority, mode, ContentMatchQuery, disabled, ApplyComplianceTag, @{n = "LabelName"; e = {($_.ComplianceTagProperty).split(",")[1]}}, @{n = "LabelGuid"; e = {($_.ComplianceTagProperty).split(",")[0]}}
        $tags = Get-ComplianceTag | Select name, guid, isRecordLabel, RetentionAction, RetentionDuration

        $policyHash = @{}
        foreach ($policy in $policies) {
            $policyHash[$policy.guid] = $policy 
        }

        $tagHash = @{}
        foreach ($tag in $tags) {
            $tagHash[$tag.guid] = $tag 
        }

        $rtagarray = @()
        foreach ($rtag in $rules) {
            if ($rtag.LabelGuid) {
                $rtagarray += $rtag.LabelGuid
            }
            if ($rtag.ApplyComplianceTag) {
                $rtagarray += $rtag.ApplyComplianceTag                
            }
        }

        foreach ($t in $tags) {
            if ($rtagarray -notcontains $t.guid) {
                write-host "UnPublished Labels are sorted here"
                $ruleHash = [ordered]@{}
                $ruleHash['LabelName'] = $t.name
                $ruleHash['PolicyName'] = "(Label not Published)"
                $ruleHash['RetentionComplianceAction'] = "(Label not Published)"
                $ruleHash['RetentionDuration'] = "(Label not Published)"
                $ruleHash['Priority'] = "(Label not Published)"
                $ruleHash['ContentQuery'] = "(Label not Published)"
                $ruleHash['Mode'] = "(Label not Published)"
                $ruleHash['Disabled'] = "(Label not Published)"   
                                                          
                $resultArray += [psCustomObject]$ruleHash
            }

        }

        foreach ($rule in $rules) { 
            if ((((($rule.name).split("-"))[0]) -ne 'ctaptr') -and (((($rule.name).split("-"))[0]) -ne 'ctptr') ) {
                write-host "Office 365 Retention Policies without KQL sorted here"
                $ruleHash = [ordered]@{}
                $ruleHash['LabelName'] = "(Non-KQL O365 Retention Policies)"
                $ruleHash['PolicyName'] = $policyHash[$rule.policy].name
                $ruleHash['RetentionComplianceAction'] = $rule.RetentionComplianceAction
                $ruleHash['RetentionDuration'] = $rule.RetentionDuration
                $ruleHash['Priority'] = $rule.Priority
                $ruleHash['ContentQuery'] = $rule.ContentMatchQuery
                $ruleHash['Mode'] = $rule.mode
                $ruleHash['Disabled'] = $rule.Disabled   
                                                          
                $resultArray += [psCustomObject]$ruleHash
            }

            if ((((($rule.name).split("-"))[0]) -eq 'ctaptr')) {
                write-host "Office 365 Retention Policies without KQL sorted here"
                $ruleHash = [ordered]@{}
                $ruleHash['LabelName'] = "(Auto-Apply Label Policy or KQL O365 Retention Policy)"
                $ruleHash['PolicyName'] = $policyHash[$rule.policy].name
                $ruleHash['RetentionComplianceAction'] = $rule.RetentionComplianceAction
                $ruleHash['RetentionDuration'] = $rule.RetentionDuration
                $ruleHash['Priority'] = $rule.Priority
                $ruleHash['ContentQuery'] = $rule.ContentMatchQuery
                $ruleHash['Mode'] = $rule.mode
                $ruleHash['Disabled'] = $rule.Disabled   
                                                          
                $resultArray += [psCustomObject]$ruleHash
            }
            
            if ((((($rule.name).split("-"))[0]) -eq 'ctptr')) {
                write-host "Standard Labels sorted here"
                $ruleHash = [ordered]@{}
                $ruleHash['LabelName'] = $rule.LabelName
                $ruleHash['PolicyName'] = $policyHash[$rule.policy].name
                $ruleHash['RetentionComplianceAction'] = $rule.RetentionComplianceAction
                $ruleHash['RetentionDuration'] = $rule.RetentionDuration
                $ruleHash['Priority'] = $rule.Priority
                $ruleHash['ContentQuery'] = $rule.ContentMatchQuery
                $ruleHash['Mode'] = $rule.mode
                $ruleHash['Disabled'] = $rule.Disabled   
                                                          
                $resultArray += [psCustomObject]$ruleHash  
            } 
        }
    }
    End {
        $resultArray | sort PolicyName
    }
}