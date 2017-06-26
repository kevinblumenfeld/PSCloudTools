---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LaRetentionCount

## SYNOPSIS
Retrieves the count of mailboxes with each retention policy

## SYNTAX

```
Get-LaRetentionCount [<CommonParameters>]
```

## DESCRIPTION
The report will display each retention policy and how many mailboxes are assigned that particular policy

## EXAMPLES

### Example 1
```
Get-LaRetentionCount | Out-GridView
```

### Example 2
```
Get-LaRetentionCount | Export-Csv .\countofpoliciesassigned.csv -NoTypeInformation
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

