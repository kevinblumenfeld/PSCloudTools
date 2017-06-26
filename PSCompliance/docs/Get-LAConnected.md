---
external help file: PSLicense-help.xml
online version: 
schema: 2.0.0
---

# Get-LAConnected

## SYNOPSIS
Connects to Office 365 services and/or Azure

## SYNTAX

```
Get-LAConnected [-Tenant] <String> [-ExchangeAndMSOL] [-All365] [-Azure] [-AzureOnly] [-Skype] [-SharePoint]
 [-Compliance] [-ComplianceLegacy] [-AzureADver2] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Connects to Office 365 services and/or Azure.

Connects to some or all of the Office 365/Azure services based on switches provided at runtime.

Office 365 tenant name, for example, either contoso or contoso.onmicrosoft.com must be provided with -Tenant parameter
For AzureOnly, provide a unique name for the -Tenant parameter

Locally saves and encrypts to a file the username and password.
The encrypted file...
   
1.  can only be used on the computer and within the user's profile from which it was created.
2.  is the same .txt for all the Office 365 Services.
3.  for Azure is separate and is a .json file.

If Azure or AzureOnly switch is used for first time:

1.  User will login as normal when prompted by Azure
2.  User will be prompted to select which Azure Subscription
3.  Select the subscription and click "OK"

If Azure or AzureOnly switch is used:

1.  User will be prompted to pick username used previously
2.  If a new username is to be used (e.g. username not found when prompted), click Cancel to be prompted to login.
3.  User will be prompted to select which Azure Subscription
4.  Select the subscription and click "OK"

Directories used/created during the execution of this script 

1.  $env:USERPROFILE\ps\
2.  $env:USERPROFILE\ps\creds\

All saved credentials are saved in $env:USERPROFILE\ps\creds\
Transcipt is started and kept in $env:USERPROFILE\ps\<tenantspecified\>

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-LAConnected -Tenant Contoso -AzureOnly
```

Connects to Azure Only
For the mandatory parameter, Tenant, simply provide something that uniquely identifies the Azure Tenant

### -------------------------- EXAMPLE 2 --------------------------
```
Get-LAConnected -Tenant Contoso
```

Connects by default to MS Online Service (MSOL) and Exchange Online (unless AzureOnly switch is used)
Office 365 tenant name, for example, either contoso or contoso.onmicrosoft.com must be provided with -Tenant parameter

### -------------------------- EXAMPLE 3 --------------------------
```
Get-LAConnected -Tenant Contoso -Skype
```

Connects by default to MS Online Service (MSOL) and Exchange Online
Connects to Skype Online

### -------------------------- EXAMPLE 4 --------------------------
```
Get-LAConnected -Tenant Contoso -SharePoint
```

Connects by default to MS Online Service (MSOL) and Exchange Online
Connects to SharePoint Online

### -------------------------- EXAMPLE 5 --------------------------
```
Get-LAConnected -Tenant Contoso -Compliance
```

Connects by default to MS Online Service (MSOL) and Exchange Online
Connects to Compliance & Security Center

### -------------------------- EXAMPLE 6 --------------------------
```
Get-LAConnected -Tenant Contoso -All365
```

Connects to MS Online Service (MSOL), Exchange Online, Skype, SharePoint & Compliance

### -------------------------- EXAMPLE 7 --------------------------
```
Get-LAConnected -Tenant Contoso -All365 -Azure
```

Connects to Azure, MS Online Service (MSOL), Exchange Online, Skype, SharePoint & Compliance

### -------------------------- EXAMPLE 8 --------------------------
```
Get-LAConnected -Tenant Contoso -Skype -Azure
```

Connects to Azure, MS Online Service (MSOL), Exchange Online & Skype
This is to illustrate that any number of individual services can be used to connect.

## PARAMETERS

### -Tenant
{{The Tenant Name}}

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExchangeAndMSOL
{{Exchange and MSOnline}}

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

### -All365
{{All Office 365 Services}}

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

### -Azure
{{Microsoft Azure}}

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

### -AzureOnly
{{Connect to Azure by itself}}

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
{{Microsoft Skype}}

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
{{Microsoft SharePoint}}

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

### -Compliance
{{Office 365 Security and Compliance Center}}

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

### -ComplianceLegacy
{{Legacy Compliance Cmdlets}}

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

### -AzureADver2
{{Azure Active Directory Version 2}}

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

