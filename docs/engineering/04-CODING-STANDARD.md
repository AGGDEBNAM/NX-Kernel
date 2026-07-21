# 04 - Coding Standard

**Document ID:** ENG-004
**Version:** 1.0.0
**Status:** Approved
**Last Updated:** 2026-07-20

---

# Purpose

This document defines the official coding standards for NX Platform.

Every source file shall comply with this standard.

The objective is to maximize:

- Readability
- Maintainability
- Predictability
- Consistency
- Testability

Readable code is preferred over clever code.

---

# General Principles

Every implementation shall follow:

- SOLID
- DRY
- KISS
- YAGNI
- Clean Code

The project prioritizes long-term maintainability over short-term speed.

---

# File Header

Every module starts with a standard header.

Example:

```powershell
# ===================================================================
# NX Platform
# Bootstrap Service
# Version: 0.2.0
# ===================================================================
```

Headers should describe the module,
not implementation history.

---

# File Organization

Recommended order:

1. Header
2. Imports
3. Internal State
4. Private Functions
5. Public Functions
6. Export-ModuleMember

Never mix public and private functions.

---

# Function Layout

Preferred structure:

```powershell
function Get-NXVersion {

    [CmdletBinding()]
    param()

    # Implementation

}
```

The following order is mandatory:

Function

↓

CmdletBinding

↓

Parameters

↓

Validation

↓

Implementation

↓

Return

---

# Function Length

Preferred:

20–40 lines

Maximum:

80 lines

If a function exceeds 80 lines,
consider splitting it.

---

# Function Responsibility

One function

↓

One responsibility

Avoid functions that:

- load files
- validate data
- register services
- log information

at the same time.

---

# Naming

Public functions:

Verb-NXName

Examples

```powershell
Get-NXVersion

Initialize-NXBootstrap

Register-NXService
```

Private functions

CamelCase or PascalCase.

Example

```powershell
LoadVersion

InitializeState

GetVersionFile
```

---

# Variables

Use descriptive names.

Preferred

```powershell
$VersionFile

$Configuration

$Bootstrap
```

Avoid

```powershell
$v

$x

$tmp
```

Abbreviations should be avoided unless universally accepted.

---

# Constants

Hardcoded values are discouraged.

Preferred

```powershell
$script:DefaultEnvironment
```

Avoid

```powershell
"Development"
```

scattered throughout the code.

---

# Parameter Validation

Every public function validates input.

Example

```powershell
[Parameter(Mandatory)]

[ValidateNotNullOrEmpty()]

[string]$Name
```

Never trust external input.

---

# Return Values

Prefer PSCustomObject.

Example

```powershell
return [PSCustomObject]@{

    Name = $Name

    Version = $Version

}
```

Avoid returning anonymous hashtables.

---

# Error Handling

Throw meaningful exceptions.

Preferred

```powershell
throw "Service '$Name' is already registered."
```

Avoid

```powershell
Write-Host "Error"
```

Never suppress exceptions silently.

---

# Logging

Business modules never log directly.

Preferred

Logger Service

Avoid

```powershell
Write-Host

Write-Output
```

for diagnostics.

---

# Comments

Comment only:

- Why
- Architecture
- Decisions

Avoid commenting obvious code.

Bad

```powershell
$i++

# Increment i
```

Good

```powershell
# Increment the service counter after a successful registration.
```

---

# Objects

Prefer PSCustomObject.

Avoid nested hashtables when representing domain objects.

Example

```powershell
[PSCustomObject]@{

    Name = ""

    State = ""

    Version = ""

}
```

---

# Enumerations

If a set of values grows,
replace strings with enums.

Example

Instead of

```powershell
"Ready"

"Running"

"Stopped"
```

consider

```powershell
enum NXState {

    Created

    Initializing

    Ready

}
```

---

# Null Handling

Always check for null before access.

Example

```powershell
if ($null -eq $Configuration) {

    throw "Configuration not loaded."

}
```

---

# Module State

Mutable state shall exist only when necessary.

Module scope

```powershell
$script:
```

is preferred.

Global scope is forbidden.

---

# PowerShell Features

Preferred

CmdletBinding

ValidateSet

ValidatePattern

ValidateNotNull

ValidateNotNullOrEmpty

SupportsShouldProcess (when applicable)

Pipeline support when useful

---

### PowerShell Expression Rules

When passing complex expressions as parameter values:

Always wrap the expression in parentheses.

Preferred:

```powershell
-Instance ([PSCustomObject]@{
    ...
})
```

Never rely on implicit parsing of multiline expressions after a named parameter.

Avoid:

```powershell
-Instance [PSCustomObject]@{
    ...
}
```

Reason:

PowerShell expression parsing may interpret multiline typed literals as additional positional arguments.

---

# Formatting

Indentation

4 spaces

No tabs.

One blank line between logical sections.

Opening braces on same line.

Closing braces aligned.

---

# Line Length

Preferred

120 characters maximum.

Break long expressions.

---

# Imports

Only the Composition Root imports modules.

Individual modules shall not import other project modules.

---

# Export Rules

Export only the public API.

Example

```powershell
Export-ModuleMember `
    -Function `
        Get-NXVersion,
        Start-NX
```

Never export helper functions.

---

# Testing

Every public function should be testable independently.

Avoid hidden dependencies.

---

# Forbidden Practices

The following are prohibited:

- Global variables
- Circular dependencies
- Hardcoded paths
- Hardcoded versions
- Duplicate logic
- Write-Host for diagnostics
- Silent failures
- Functions with multiple responsibilities

---

# Code Review Checklist

Before approving code verify:

✓ Function names follow convention

✓ Parameters validated

✓ Errors handled

✓ No duplicate logic

✓ Public API documented

✓ No forbidden dependencies

✓ Compatible with Architecture Standard

✓ Tests updated

✓ Documentation updated

---

### PowerShell Formatting

When splitting PowerShell statements across multiple lines:

- Use the PowerShell line continuation character (`) only when necessary.
- Prefer arrays and hashtables over line continuations.
- Never use "\" as a line continuation character.
- Generated code shall be syntactically valid before review.

---

# Engineering Philosophy

Code is read far more often than it is written.

Every implementation should optimize for the next engineer,
not the current one.

Readable code is the highest form of optimization.