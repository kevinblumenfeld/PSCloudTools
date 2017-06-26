---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LaCompliancePolicy

## SYNOPSIS
Report on each Office 365 Retention Policies, Label Polices (including Auto-Applied Label Policies) and the Labels linked to each (policy).

## SYNTAX

```
Get-LaCompliancePolicy [<CommonParameters>]
```

## DESCRIPTION
Report on each Office 365 Retention Policies, Label Polices (including Auto-Applied Label Policies) and the Labels linked to each (policy).

Make sure you are first connected to the Office 365 compliance service. 
Simply use Get-LaConnected,  e.g.
Get-LaConnected -Tenant Contoso -Compliance

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-LaConnected -Tenant Contoso -Compliance

Get-LaCompliancePolicy | Out-GridView
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-LaConnected -Tenant Contoso -Compliance

Get-LaCompliancePolicy | Export-Csv ./labelsandpols.csv -NoTypeInformation
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

