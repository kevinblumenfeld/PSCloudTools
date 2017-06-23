---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LAMailboxFolderSize

## SYNOPSIS
Retrieves each mailbox's:
1. entire TotalItemSize 
2. and more specifically, TotalItemSize for just the RecoverableItems folder

## SYNTAX

```
Get-LAMailboxFolderSize [-userprincipalname] <String>
```

## DESCRIPTION
Requires mandatory value(s) from the pipeline. 
Specifically, objects that contain the mailbox's UserPrincipalName.
A CSV is not mandatory as a command could pass the necessary information from the pipeline.
However, a CSV could certainly be used to break up large data sets.

Note: This function executes two commands per mailbox and could be subject to Office 365 throttling.
      Therefor, for large tenants it is best to break up mailboxes into CSV's of 5,000 or less UPNs.
      For best results, no more than 2 concurrent sessions of this function should be run.
      It may be necessary to contact Office 365 support to have some throttling reduced.


A CSV could look like this
```
UserPrincipalName
user01@contoso.com
user02@contoso.com
user03@contoso.com
user04@contoso.com
```
## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Mailbox -identity user01@contoso.com | Select UserPrincipalName | Get-LAFolderSize
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAFolderSize | Out-GridView
```

### -------------------------- EXAMPLE 3 --------------------------
```
Get-Mailbox -ResultSize unlimited | Select UserPrincipalName | Get-LAFolderSize | Export-Csv ./FolderSizes.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 4 --------------------------
```
Import-Csv ./upns.csv | Get-LAFolderSize | Export-Csv ./FolderSizes.csv -NoTypeInformation
```

## PARAMETERS

### -userprincipalname
{{UPNs passed from the pipeline}}

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

