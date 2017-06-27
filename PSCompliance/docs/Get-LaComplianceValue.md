---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LaComplianceValue

## SYNOPSIS
Reports on all mailboxes that have the values specified
Specifically reports on either those mailboxes with these 
parameters (and those without, depending on what you specify):

1. LitigationHoldEnabled
2. ArchiveEnabled
3. RetainDeletedItemsFor30Days
4. UseDatabaseRetentionDefaults
5. SingleItemRecoveryEnabled
6. InactiveMailboxes

## SYNTAX

```
Get-LaComplianceValue [-Filter] <String> [-Value] <String> [<CommonParameters>]
```

## DESCRIPTION
Reports on all mailboxes that have the values specified at runtime.
Either choose to Included or Exclude the value specified in the results that are returned.

## EXAMPLES

### Example 1
```
Get-LaComplianceValue -Filter Exclude -Value LitigationHoldEnabled | Export-Csv ./onlythoseWITHOUTLitHold.csv -NoTypeInformation
```

Reports on only those mailboxes that do not have Litigation Hold enabled

### Example 2
```
Get-LaComplianceValue -Filter Include -Value LitigationHoldEnabled | Export-Csv ./onlythoseWITHLitHold.csv -NoTypeInformation
```

Reports on only those mailboxes that do have Litigation Hold enabled

### Example 3
```
Get-LaComplianceValue -Filter Exclude -Value ArchiveEnabled | Export-Csv ./onlythoseWITHOUTArchiveEnabled.csv -NoTypeInformation
```

Reports on only those mailboxes that do not have an archive mailbox

### Example 4
```
Get-LaComplianceValue -Filter Exclude -Value RetainDeletedItemsFor30Days | Export-Csv ./onlythosewithRetDelItemsLessthan30days.csv -NoTypeInformation
```

Reports on only those mailboxes that have RetainDeletedItemsFor set at less than 30 days

### Example 5
```
Get-LaComplianceValue -Filter Exclude -Value UseDatabaseRetentionDefaults | Export-Csv ./onlythosewithUseDatabaseRetentionDefaultsSettoTrue.csv -NoTypeInformation
```

Reports on only those mailboxes that have UseDatabaseRetentionDefaults set to true

### Example 6
```
Get-LaComplianceValue -Filter Exclude -Value SingleItemRecoveryEnabled | Export-Csv ./onlythoseWITHOUTSingleItemRecoveryEnabled.csv -NoTypeInformation
```

Reports on only those mailboxes that do not have SingleItemRecovery set to Enabled

### Example 7
```
Get-LaComplianceValue -Filter Include -Value InactiveMailboxes | Export-Csv ./onlyInactiveMailboxes.csv -NoTypeInformation
```

Reports on all Inactive Mailboxes.  Provides a more comprehensive report of many important parameters on each inactive mailbox

### Example 8
```
Get-LaComplianceValue -Filter Exclude -Value InactiveMailboxes | Export-Csv ./onlyActiveMailboxes.csv -NoTypeInformation
```

Reports on all Mailboxes except Inactive Mailboxes.  Provides a more comprehensive report of many important parameters on each mailbox

## PARAMETERS

### -Filter
{{Set on whether to Include or Exclude the Value}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: Include, Exclude

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Value
{{Choose the value that is to be included or excluded from the results}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 
Accepted values: LitigationHoldEnabled, ArchiveEnabled, RetainDeletedItemsFor30Days, UseDatabaseRetentionDefaults, SingleItemRecoveryEnabled, InactiveMailboxes

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

