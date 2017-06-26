---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LaMailboxInPlaceHold

## SYNOPSIS
Reports on the legacy In-Place Holds for each mailbox

## SYNTAX

```
Get-LaMailboxInPlaceHold [-WithoutInPlaceHold] [-list] <Object[]> [<CommonParameters>]
```

## DESCRIPTION
Reports on the legacy In-Place Holds for each mailbox.
For easy sorting and readability, if a mailbox has more than one In-Place Hold, the mailbox and the corresponding hold is listed, one per row.
In other words, if a mailbox has 3 legacy holds, that mailbox will appear on three rows.

Mailbox UPNs should be passed from the pipeline as demonstrated in the examples below.

Individual mailboxes, all mailboxes, all mailboxes in a department are all possibilities.

Also demonstrated in an example below is importing mailboxes (UPNs) from a CSV

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LaMailboxInPlaceHold | Out-GridView
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LaMailboxInPlaceHold | Export-Csv .\legacyholds.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 3 --------------------------
```
Import-Csv .\upns.csv | Get-LaMailboxInPlaceHold | Export-Csv .\legacyHoldsbyMailbox.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 4 --------------------------
```
Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LaMailboxInPlaceHold | Export-Csv .\HRsHolds.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 4 --------------------------
```
A CSV could look like this

UserPrincipalName
user01@contoso.com
user02@contoso.com
```

## PARAMETERS

### -WithoutInPlaceHold
{{Gather users that have no in-place holds}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -list
{{UPNs passed from the pipeline}}

```yaml
Type: Object[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

