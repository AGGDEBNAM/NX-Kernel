# 03 - Module Standard

**Document ID:** ENG-003  
**Version:** 1.0.0  
**Status:** Approved  
**Last Updated:** 2026-07-20

---

# Purpose

This document defines the official structure and lifecycle of every
module inside NX Platform.

Every module must follow this specification.

Modules that do not comply with this standard shall not be integrated
into the platform.

---

# Module Philosophy

A module represents one isolated responsibility.

A module must:

- own one responsibility
- expose a minimal public API
- hide its implementation
- avoid dependencies
- remain independently testable

A module is a reusable building block.

---

# Standard Module Structure

Every module shall follow the same directory layout.

```

ModuleName/
│
├── ModuleName.psm1
├── README.md
├── Tests/
│ ├── Unit/
│ └── Integration/
├── Docs/
└── Examples/

```

Example:

```

Bootstrap/
│
├── Bootstrap.psm1
├── README.md
├── Tests/
└── Docs/

```

---

# Naming Convention

Folder

```

Bootstrap/

```

Module

```

Bootstrap.psm1

```

Public Functions

```

Initialize-NXBootstrap

Get-NXBootstrap

Register-NXService

```

Private Functions

```

Get-VersionFile

Initialize-State

Load-Version

```

Private functions shall not be exported.

---

# Responsibilities

Every module owns exactly one responsibility.

Example

Bootstrap

Responsible for:

- lifecycle
- state
- version
- service registry

Not responsible for:

- logging
- configuration
- context
- dispatcher

---

# Public API

Every public function shall:

- begin with an approved PowerShell verb
- include the NX prefix
- be documented
- perform one task

Example

```

Get-NXBootstrap

Initialize-NXBootstrap

Register-NXService

```

---

# Private API

Internal helper functions shall never be exported.

Example

```

Load-Version

Get-VersionFile

Update-State

```

---

# State Management

Modules should avoid mutable state.

If state is required:

- use module scope
- keep it private
- expose read-only access when possible

Global variables are forbidden.

Bootstrap is the only exception.

---

# Dependencies

Modules shall not import other modules.

Forbidden

```

Bootstrap

↓

Logger

```

Forbidden

```

Context

↓

Configuration

```

Allowed

```

NX.psm1

├── Bootstrap
├── Logger
├── Context

```

Dependencies are resolved only by the Composition Root.

---

# Configuration

Modules never read configuration files directly.

Configuration is obtained through:

```

Configuration Service

```

---

# Version Access

Modules never read:

```

VERSION

```

Only Bootstrap may read the version file.

Other modules obtain version information through Bootstrap.

---

# Error Handling

Modules shall:

- throw meaningful exceptions
- validate parameters
- fail explicitly

Silent failures are prohibited.

---

# Logging

Modules never write directly to the console.

Avoid

```

Write-Host

```

Preferred

```

Logger Service

```

---

# Export Rules

Only public functions shall be exported.

Example

```

Export-ModuleMember -Function `
Initialize-NXBootstrap,
Get-NXBootstrap

```

Private helpers remain internal.

---

# Initialization

Modules shall never initialize themselves automatically.

Initialization occurs only from:

```

NX.psm1

```

Self-initialization is prohibited.

---

# Testing Requirements

Every module shall include:

Unit Tests

Integration Tests

Smoke Tests

Regression Tests (when applicable)

A module without tests is considered incomplete.

---

# Documentation Requirements

Each module shall include:

README

Responsibilities

Public API

Dependencies

Examples

Known limitations

---

# Performance

Modules should:

- avoid unnecessary allocations
- avoid duplicated work
- cache only when justified
- prefer readability over micro-optimizations

Premature optimization is discouraged.

---

# Security

Modules shall:

- validate all public parameters
- avoid executing arbitrary code
- avoid exposing internal state
- sanitize external inputs

---

# Lifecycle

Every module follows the same lifecycle.

```

Created

↓

Loaded

↓

Initialized

↓

Running

↓

Disposed (future)

```

---

# Review Checklist

Before approving a module verify:

✓ Single Responsibility

✓ Public API documented

✓ No forbidden dependencies

✓ No hidden initialization

✓ Tests exist

✓ README updated

✓ Exported functions reviewed

✓ No duplicated logic

✓ Compatible with ENG-002

---

# Template

Every new module begins from the following checklist.

```

Module Name:

Purpose:

Responsibilities:

Public API:

Private API:

Dependencies:

Initialization:

Configuration:

Tests:

Documentation:

Known Limitations:

Future Improvements:

```

---

# Final Principle

A module is successful when it can be understood,
tested,
maintained,
and replaced independently.

Independence is more valuable than convenience.