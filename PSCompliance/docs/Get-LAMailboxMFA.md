---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LaMailboxMFA

## SYNOPSIS
Reports on several key indicators of the Managed Folder Assistant against one or more mailboxes or mailbox archives.
Also, it can start the Managed Folder Assistant for one more or more mailboxes.

## SYNTAX

```
Get-LaMailboxMFA [-userprincipalname] <String[]> [-Archive] [-StartMFA] [<CommonParameters>]
```

## DESCRIPTION
Reports on several key indicators of the Managed Folder Assistant against one or more mailboxes or mailbox archives.
Also, it can start the Managed Folder Assistant for one more or more mailboxes.

Mailbox UPNs should be passed from the pipeline as demonstrated in the examples below.

Individual mailboxes, all mailboxes, all mailboxes in a department are all possibilities.

Also demonstrated in an example below is importing mailboxes (UPNs) from a CSV

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxMFA | Out-GridView
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxMFA -Archive | Export-Csv .\MFAstatsForARCHIVEmailbox.csv -NoTypeInformation
```

* This command reports on the Managed Folder Assistant statistics for ARCHIVE mailboxes. Hence, the -Archive switch. *

### -------------------------- EXAMPLE 3 --------------------------
```
Get-Mailbox -identity "user01@contoso.com" | Select UserPrincipalName | Get-LAMailboxMFA -StartMFA
```

** This command starts the Managed Folder Assistant and could be subject to Microsoft throttling **

### -------------------------- EXAMPLE 4 --------------------------
```
Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LAMailboxMFA -StartMFA
```

** This command starts the Managed Folder Assistant and could be subject to Microsoft throttling **

### -------------------------- EXAMPLE 5 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAMailboxMFA | Export-Csv .\MFAstats.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 6 --------------------------
```
Import-Csv .\upns.csv | Get-LAMailboxMFA | Export-Csv .\MFAstats.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 7 --------------------------
```
Import-Csv .\upns.csv | Get-LAMailboxMFA | Out-GridView
```

### -------------------------- EXAMPLE 8 --------------------------
```
Get-MsolUser -All -Department 'Human Resources' | Select UserPrincipalName | Get-LAMailboxMFA | Export-Csv .\HRsMFAstats.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 9 --------------------------
```
A CSV could look like this

UserPrincipalName
user01@contoso.com
user02@contoso.com
```

## PARAMETERS

### -userprincipalname
{{UPNs passed from the pipeline}}

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Archive
{{Reports on Archive Mailbox}}

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

### -StartMFA
{{Actually Starts the MFA for Mailboxes passed at pipeline}}

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

