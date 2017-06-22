function Get-LAInPlaceHold {
    <#
.SYNOPSIS
   Reports on in-place holds from the legacy, Exchange specific, "Compliance Management > in-place eDiscovery & hold"

.DESCRIPTION
   Reports on in-place holds from the legacy, Exchange specific, "Compliance Management > in-place eDiscovery & hold"
   This does not report on each mailbox that is on hold - Use Get-LAMailboxInPlaceHold to report on that (however that command provides only the legacy holds).
   To report on modern holds, use Get-LAComplianceCase to report on in-place holds from the new "Security and Compliance Center".

.EXAMPLE
   Get-LAInPlaceHold | Export-Csv ./LegacyHolds.csv -NoTypeInformation

.EXAMPLE
   Get-LAInPlaceHold | Out-GridView

#>
    [CmdletBinding()]
    Param
    (

    )
    Begin {
 
    }
    Process {
        $resultArray = @()
        $mailboxProperties = @("Name", "CreatedBy", "SearchQuery", "AllPublicFolderSources", "Version", "TargetMailbox", "Target", "Senders", "Recipients", "StartDate", "EndDate", "MessageTypes", "IncludeUnsearchableItems", "EstimateOnly", "ExcludeDuplicateMessages", "Resume", "IncludeKeywordStatistics", "TotalKeywords", "LogLevel", "StatusMailRecipients", "Status", "LastRunBy", "LastStartTime", "LastEndTime", "NumberMailboxesToSearch", "PercentComplete", "ResultNumber", "ResultNumberEstimate", "ResultSize", "ResultSizeEstimate", "ResultSizeCopied", "InPlaceHoldEnabled", "InPlaceHoldIdentity", "Description", "LastModifiedTime", "KeywordHits")
        $holds = Get-MailboxSearch | Select Name, @{n="SearchQuery";e={(Get-MailboxSearch $_.identity).searchquery}}, CreatedBy, AllPublicFolderSources, Version, TargetMailbox, Target, Senders, Recipients, StartDate, EndDate, MessageTypes, IncludeUnsearchableItems, EstimateOnly, ExcludeDuplicateMessages, Resume, IncludeKeywordStatistics, TotalKeywords, LogLevel, StatusMailRecipients, Status, LastRunBy, LastStartTime, LastEndTime, NumberMailboxesToSearch, PercentComplete, ResultNumber, ResultNumberEstimate, ResultSize, ResultSizeEstimate, ResultSizeCopied, InPlaceHoldEnabled, InPlaceHoldIdentity, Description, LastModifiedTime, KeywordHits
        foreach ($hold in $holds) {   
            $holdHash = [ordered]@{}
            foreach ($field in $mailboxProperties) {
                $holdHash[$field] = ($hold.$field) -join ","
            }                                            
            $resultArray += [psCustomObject]$holdHash        
        }
    }
    End {
        $resultArray
    }
}