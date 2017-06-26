---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LaMailboxOldestItem

## SYNOPSIS
Reports on the oldest item in a mailbox(es)

## SYNTAX

```
Get-LaMailboxOldestItem [-userprincipalname] <String> [-IncludeRecoverableItems] [-RecoverableItemsOnly]
 [<CommonParameters>]
```

## DESCRIPTION
Users 
Additionally, each case's hold (Exchange and/or SharePoint) are returned.

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Import-Csv .\upns.csv | Get-LaMailboxOldestItem | Out-GridView
```

Reports on the oldest item in the mailbox not including the recoverable items folders

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Mailbox -ResultSize unlimited | Get-LaMailboxOldestItem -IncludeRecoverableItems
```

Reports on the oldest item in the mailbox including the recoverable items folders

### -------------------------- EXAMPLE 3 --------------------------
```
Get-Recipient -Filter "Department -eq 'Human Resources'" -RecipientType mailuser | Get-LaMailboxOldestItem -RecoverableItemsOnly
```

Reports on the oldest item in the mailbox - only searches in the recoverable items folders

## PARAMETERS


### -userprincipalname
{{UPNs are passed from the pipeline}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -IncludeRecoverableItems
{{Include Recoverable Items Folder in the search for the oldest item}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecoverableItemsOnly
{{Recoverable Items Folders are the only folders searched while looking for the oldest item in the mailbox}}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
