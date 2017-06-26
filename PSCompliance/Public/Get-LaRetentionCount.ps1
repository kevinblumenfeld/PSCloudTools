<#
.EXTERNALHELP PSCompliance-help.xml
#>
function Get-LaRetentionCount {

    $count = Get-Mailbox -ResultSize Unlimited| Select-Object RetentionPolicy, Count| 
        Group-Object -property RetentionPolicy| Sort-Object count -Descending| 
        Select-Object Name, Count 
    
    $count
}