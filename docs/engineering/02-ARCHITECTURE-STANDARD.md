# 02 - Architecture Standard

**Document ID:** ENG-002  
**Version:** 1.0.0  
**Status:** Approved  
**Last Updated:** 2026-07-20

---

# Purpose

This document defines the official software architecture of NX Platform.

Every module, service, component and future implementation shall comply
with the rules defined in this document.

Any architectural deviation requires an Architecture Decision Record (ADR).

---

# Architecture Philosophy

NX Platform is built using a modular architecture.

The platform prioritizes:

1. Separation of Responsibilities
2. Modularity
3. Maintainability
4. Testability
5. Extensibility
6. Predictability

Architecture is always preferred over implementation speed.

---

# Architectural Principles

## Single Responsibility Principle

Every module owns exactly one responsibility.

Examples:

Bootstrap

- Platform lifecycle
- Service Registry
- Platform Version

Configuration

- Configuration management

Context

- Runtime context

Logger

- Logging

Kernel

- Orchestration

---

## Composition Root

The platform has exactly one Composition Root.

```
NX.psm1
```

No other module may compose the application.

Responsibilities:

- Load modules
- Resolve dependencies
- Initialize services
- Register services
- Expose the public API

Business logic inside NX.psm1 is forbidden.

---

## Dependency Direction

Dependencies always flow downward.

```
Application

↓

Composition Root

↓

Kernel

↓

Services

↓

Infrastructure
```

Reverse dependencies are forbidden.

---

## Module Independence

Modules must never import other modules.

Incorrect:

```
Kernel
    ↓
Bootstrap
```

Correct:

```
NX.psm1

├── Bootstrap
├── Context
├── Logger
├── Runtime
├── Kernel
└── ...
```

Only the Composition Root imports modules.

---

# Layered Architecture

```
+--------------------------------------------------+
|                 User / CLI                       |
+--------------------------------------------------+

                    │

                    ▼

+--------------------------------------------------+
|                   nx.ps1                         |
+--------------------------------------------------+

                    │

                    ▼

+--------------------------------------------------+
|                  NX.psm1                         |
|             Composition Root                     |
+--------------------------------------------------+

                    │

        ┌───────────┼────────────┐
        ▼           ▼            ▼

 Bootstrap     Configuration    Context

        ▼           ▼            ▼

      Logger      Runtime     Manifest

              ▼

         ModuleLoader

              ▼

            Kernel

              ▼

          Dispatcher

              ▼

          User Command
```

---

# Responsibilities

## nx.ps1

Purpose:

Entry point.

Responsibilities:

- Parse command line
- Load NX.psm1
- Invoke Start-NX

No business logic.

---

## NX.psm1

Purpose:

Composition Root.

Responsibilities:

- Import internal modules
- Initialize Bootstrap
- Register services
- Export public commands

---

## Bootstrap

Purpose:

Platform lifecycle.

Owns:

- Version
- State
- Service Registry
- Initialization

Bootstrap is the only module allowed to read:

```
VERSION
```

---

## Configuration

Responsible for:

- configuration loading
- validation
- environment settings

---

## Context

Responsible for:

Runtime execution context.

Never loads services.

---

## Logger

Responsible only for logging.

Must never implement business logic.

---

## Runtime

Responsible for:

- execution information
- timers
- host information
- runtime diagnostics

---

## Manifest

Responsible for module metadata.

---

## Module Loader

Responsible for discovering and loading platform modules.

---

## Kernel

Kernel orchestrates execution.

Kernel shall never:

- load modules
- read configuration
- read VERSION
- register services

Kernel delegates everything.

---

## Dispatcher

Responsible for command routing.

Example:

```
version

↓

Version Command

↓

Version Service
```

Dispatcher replaces switch statements.

---

# Service Registry

Bootstrap owns the Service Registry.

Every service registration contains:

- Name
- Version
- State
- Dependencies
- LoadedAt
- Instance

No module shall register itself.

Registration occurs only during platform startup.

---

# Version Management

Single Source of Truth:

```
VERSION
```

Only Bootstrap may access it.

Every other component must obtain the version through Bootstrap.

---

# Public API

Public commands are exported only by NX.psm1.

Examples:

```
Start-NX

Get-NXVersion

Get-NXContext

Get-NXConfiguration
```

Internal commands remain private.

---

# Error Handling

Errors propagate upward.

```
Service

↓

Kernel

↓

CLI
```

Silent failures are forbidden.

---

# Logging

All infrastructure logging passes through Logger.

Direct Write-Host usage inside services is discouraged.

---

# Extensibility

Future modules shall follow the same architecture.

Example:

```
Security/

Telemetry/

MQTT/

REST/

Database/

Scheduler/

Plugins/
```

No architectural changes are required to add new modules.

---

# Architectural Constraints

The following actions are prohibited:

- Circular dependencies
- Module-to-module imports
- Global mutable state outside Bootstrap
- Hardcoded versions
- Hidden side effects
- Cross-module initialization

---

# Architecture Decision Records

Every significant architectural modification requires an ADR.

Examples:

- New infrastructure layer
- Dependency inversion
- Composition changes
- Module lifecycle
- Service registration changes

---

# Architecture Review Checklist

Before approving a Sprint verify:

✓ Module responsibilities are respected

✓ No forbidden dependencies exist

✓ Public API remains stable

✓ Bootstrap owns lifecycle

✓ Kernel remains orchestration only

✓ Version source is unique

✓ Documentation updated

---

# Final Principle

Architecture defines implementation.

Implementation shall never define architecture.