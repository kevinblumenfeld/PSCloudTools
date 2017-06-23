---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LAMailboxLitigationHold

## SYNOPSIS
Reports on all mailboxes and whether or not they are on Litigation Hold.
 
Additionally, can report on all mailboxes that do not have litigation hold enabled.

## SYNTAX

```
Get-LAMailboxLitigationHold [-LitigationHoldDisabledOnly] [-list] <Object[]>
```

## DESCRIPTION
Reports on all mailboxes and whether or not they are on Litigation Hold.
 
Additionally, can report on all mailboxes that do not have litigation hold enabled.

Mailbox UPNs should be passed from the pipeline as demonstrated in the examples below.

Individual mailboxes, all mailboxes, all mailboxes in a department are all possibilities.

Also demonstrated in an example below is importing mailboxes (UPNs) from a CSV

A CSV could look like this

UserPrincipalName
user01@contoso.com
user02@contoso.com
user03@contoso.com
user04@contoso.com

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxLitigationHold | Out-GridView
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxLitigationHold | Export-Csv .\litigationholds.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 3 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxLitigationHold -LitigationHoldDisabledOnly | Export-Csv .\litigationholds.csv -NoTypeInformation
```

** This example only reports on those that do NOT have Litigation Hold Enabled (notice the switch -LitigationHoldDisabledOnly) **

### -------------------------- EXAMPLE 4 --------------------------
```
Import-Csv .\upns.csv | Get-LAMailboxLitigationHold | Export-Csv .\litholds.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 5 --------------------------
```
Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LAMailboxLitigationHold | Export-Csv .\HRlitigationholds.csv -NoTypeInformation
```

## PARAMETERS

### -LitigationHoldDisabledOnly
{{Fill LitigationHoldDisabledOnly Description}}

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
{{Fill list Description}}

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

