---
external help file: PSCompliance-help.xml
online version: 
schema: 2.0.0
---

# Get-LAInPlaceHold

## SYNOPSIS
Reports on in-place holds from the legacy, Exchange specific, "Compliance Management \> in-place eDiscovery & hold"

## SYNTAX

```
Get-LAInPlaceHold
```

## DESCRIPTION
Reports on in-place holds from the legacy, Exchange specific, "Compliance Management \> in-place eDiscovery & hold"
This does not report on each mailbox that is on hold - Use Get-LAMailboxInPlaceHold to report on that (however that command provides only the legacy holds).
To report on modern holds, use Get-LAComplianceCase to report on in-place holds from the new "Security and Compliance Center".

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-LAInPlaceHold | Export-Csv ./LegacyHolds.csv -NoTypeInformation
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-LAInPlaceHold | Out-GridView
```

## PARAMETERS

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

