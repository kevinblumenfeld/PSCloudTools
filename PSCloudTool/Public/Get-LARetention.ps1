function Get-LARetention {
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
        $findParameter = "RetentionPolicyTagLinks"
        $retPols = Get-RetentionPolicy | Select name, identity, IsDefault, RetentionPolicyTagLinks
        $retTags = Get-RetentionPolicyTag
        $retPolProps = $retPols | Get-Member -MemberType 'NoteProperty' | Select Name
        
        $tagHash = @{}
        foreach ($tag in $retTags) {
            foreach ($id in $tag.name) {
                $tagHash[$id] = $tag 
            }
        }
      
        foreach ($row in $retPols) {           
            ForEach ($link in $row.$findParameter) {
                $polHash = @{}
                $polHash['TagName'] = ($tagHash[$link]).name
                $polHash['TagType'] = ($tagHash[$link]).type
                $polHash['TagEnabled'] = ($tagHash[$link]).RetentionEnabled
                $polHash['TagAgeLimit'] = ($tagHash[$link]).AgeLimitForRetention  
                $polHash['TagAction'] = ($tagHash[$link]).RetentionAction
                $polHash['TagComment'] = ($tagHash[$link]).Comment                                             
                foreach ($field in $retPolProps.name) {
                    $polHash[$field] = ($row.$field) -join ","
                }  
                $resultArray += [psCustomObject]$polHash        
            }
        }
    }
    End {
        If ($SortbyTag) {
            $resultArray | Select "IsDefault", "Name", "TagName", "TagAgeLimit", "TagAction", "TagType", "TagEnabled", "TagComment", "RetentionPolicyTagLinks", "Identity" | Sort TagName
        }
        else {
            $resultArray | Select "IsDefault", "Name", "TagName", "TagAgeLimit", "TagAction", "TagType", "TagEnabled", "TagComment", "RetentionPolicyTagLinks", "Identity" | Sort Name        
        }
    }
}
