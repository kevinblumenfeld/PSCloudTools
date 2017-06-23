---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LACompliancePolicyLocation

## SYNOPSIS
Reports on all Label Policies and Office 365 Retention Policies located in the Security and Compliance Center

## SYNTAX

```
Get-LACompliancePolicyLocation [-All] [-Exchange] [-SharePoint] [-OneDrive] [-Skype] [-Groups]
 [-WithExceptions] [-OnlyExceptions]
```

## DESCRIPTION
Reports on all Label Policies and Office 365 Retention Policies located in the Security and Compliance Center
Label Policies contain labels that are applied by end-users or with Auto-Apply (E5 license required).
Note: Auto-Apply is by keyword or by Sensitive Data Types (Sensitive Data Types is only for OneDrive and SharePoint)
Office 365 Retention Policies are applied by administrators.
For Label Policies, this reports which users are presented with which labels.
For Office 365 Retention Policies, this reports on where administrators have chosen to apply this policy.

The Label or Retention Policies are set to (either include OR exclude) 4 different workflows.
 
1.
Exchange Email
2.
SharePoint Sites
3.
OneDrive Accounts
4.
Office 365 Groups

A Label or Retention Policy can contain either a set of inclusions or exclusions to one thru four of the above workflows.
It is worth noting, a Label or Retention Policy cannot exclude the mailbox of USER01 and include the mailbox of USER02.
 
So, when excluding certain mailboxes or sites for example, all other mailboxes or sites are included.
In contrast, When including certain mailbox or sites, all other mailboxes or site are excluded.

This function will display each policy and the included locations or the excluded locations of all 4 workflows.

If the Location column displays, "ALL", then all locations of that workflow are included.
For example, all mailboxes or all sharePoint sites.
The location column will otherwise display a specific location, for example, a specific mailbox or specific SharePoint site.

The ContentLocation column can have one of 8 possibilities (all of which are fairly self-explanatory):

1.
Exchange
2.
SharePoint
3.
OneDrive
4.
Groups
5.
Exchange_Exception
6.
SharePoint_Exception
7.
OneDrive_Exception
8.
Groups_Exception

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-LACompliancePolicyLocation -All -WithExceptions | Out-GridView
```

* This will display everything, so this is a good command to start with *

### -------------------------- EXAMPLE 2 --------------------------
```
Get-LACompliancePolicyLocation -Exchange -OnlyExceptions | Out-GridView
```

### -------------------------- EXAMPLE 3 --------------------------
```
Get-LACompliancePolicyLocation -SharePoint -WithExceptions | Out-GridView
```

### -------------------------- EXAMPLE 4 --------------------------
```
Get-LACompliancePolicyLocation -SharePoint -OnlyExceptions | Export-Csv ./sharepointexceptions.csv -NoTypeInformation
```

## PARAMETERS

### -All
{{Fill All Description}}

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

### -Exchange
{{Fill Exchange Description}}

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

### -SharePoint
{{Fill SharePoint Description}}

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

### -OneDrive
{{Fill OneDrive Description}}

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

### -Skype
{{Fill Skype Description}}

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

### -Groups
{{Fill Groups Description}}

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

### -WithExceptions
{{Fill WithExceptions Description}}

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

### -OnlyExceptions
{{Fill OnlyExceptions Description}}

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

