---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LACompliancePolicy

## SYNOPSIS
Report on each Office 365 Retention Policies, Label Polices (including Auto-Applied Label Policies) and the Labels linked to each (policy).

## SYNTAX

```
Get-LACompliancePolicy [<CommonParameters>]
```

## DESCRIPTION
Report on each Office 365 Retention Policies, Label Polices (including Auto-Applied Label Policies) and the Labels linked to each (policy).

Make sure you are first connected to the Office 365 compliance service. 
Simply use Get-LAConnected,  e.g.
Get-LAConnected -Tenant Contoso -Compliance

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-LAConnected -Tenant Contoso -Compliance

Get-LACompliancePolicy | Out-GridView
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-LAConnected -Tenant Contoso -Compliance

Get-LACompliancePolicy | Export-Csv ./labelsandpols.csv -NoTypeInformation
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

