<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LAInPlaceHold {

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