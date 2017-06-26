---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LaComplianceCase

## SYNOPSIS
Retrieve Office 365 Compliance Cases, holds and hold queries

## SYNTAX

```
Get-LaComplianceCase [<CommonParameters>]
```

## DESCRIPTION
All Office 365 Compliance Cases are returned from the Office 365 Security & Compliance Center.
Additionally, each case's hold (Exchange and/or SharePoint) are returned.

Make sure you are first connected to the Office 365 compliance service. 
Simply use Get-LAConnected,  e.g.
Get-LAConnected -Tenant Contoso -Compliance

Credit: https://support.office.com/en-us/article/Create-a-report-on-holds-in-eDiscovery-cases-in-Office-365-cca08d26-6fbf-4b2c-b102-b226e4cd7381

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-LAComplianceCase
```

User is prompted for path for output. 
Simply enter a path and not the file name:

This is what the user will see:
Enter a file path to save the report to a .csv file:

Enter the following, for example: c:\scripts\test

This is what the user will see:
Enter a file path to save the report to a .csv file:

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

