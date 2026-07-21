# 01 - Development Assistant Standard

**Document ID:** ENG-001  
**Version:** 1.0.0  
**Status:** Approved  
**Last Updated:** 2026-07-20

---

# Purpose

This document defines the official rules that every development assistant
(human or AI) must follow while contributing to NX Platform.

Its objective is to guarantee consistency, maintainability,
architectural integrity and software quality throughout the project.

This standard applies equally to:

- Human developers
- GitHub Copilot
- ChatGPT
- Claude
- Cursor
- Future development assistants

The assistant is considered a contributor to the project and must follow
exactly the same engineering process as any software engineer.

---

# Core Principles

Every contribution must respect the following principles.

## 1. Architecture First

No implementation starts before the architecture has been defined
and approved.

If the architecture is unclear, the assistant must stop and ask for
clarification.

---

## 2. Single Responsibility

Every modification must solve one problem.

Large refactors are forbidden unless explicitly requested.

---

## 3. Respect Existing Architecture

The assistant shall never redesign the project without approval.

If a better architecture is discovered, the assistant must:

1. Explain the problem.
2. Explain the proposed improvement.
3. Describe the impact.
4. Wait for approval.

Only after approval may implementation begin.

---

## 4. Small Incremental Changes

Changes must be as small as possible.

Preferred workflow:

One objective

↓

One implementation

↓

One validation

↓

One commit

---

## 5. No Hidden Changes

The assistant must never modify files outside the requested scope.

Every modified file must be explicitly listed before implementation.

---

# Mandatory Development Workflow

Every task follows the same lifecycle.

Architecture

↓

Implementation

↓

Testing

↓

Documentation

↓

Definition of Done

↓

Commit

↓

Release (if applicable)

Skipping stages is prohibited.

---

# Responsibilities During Each Phase

## Architecture

The assistant shall:

- identify the problem
- analyse dependencies
- evaluate risks
- propose alternatives
- document architectural decisions

The assistant shall NOT generate production code during this phase.

---

## Implementation

Implementation must:

- solve only the approved task
- preserve backwards compatibility
- avoid unrelated refactoring
- follow project standards

---

## Testing

Every implementation must include validation.

Testing may include:

- Unit tests
- Integration tests
- Smoke tests
- Manual validation
- Regression tests

Implementation without validation is considered incomplete.

---

## Documentation

Documentation must be updated whenever:

- architecture changes
- APIs change
- modules change
- workflows change
- responsibilities change

Documentation is part of the implementation.

---

## Definition of Done

A task is finished only if:

✓ Implementation completed

✓ Tests passed

✓ Documentation updated

✓ Architecture respected

✓ No regressions detected

✓ Code reviewed

Otherwise the task remains open.

---

# Behaviour Rules

The assistant must:

✓ Explain reasoning before coding.

✓ Prefer maintainability over cleverness.

✓ Keep functions focused.

✓ Prefer explicit code over implicit behaviour.

✓ Produce deterministic implementations.

✓ Preserve compatibility whenever possible.

---

# Forbidden Actions

The assistant shall never:

- invent requirements
- implement speculative features
- silently change architecture
- rename files without approval
- introduce dependencies without approval
- remove functionality without approval
- perform project-wide refactors without approval

---

# Code Generation Rules

Generated code must:

- compile
- follow project conventions
- avoid duplication
- include meaningful error handling
- remain readable
- avoid unnecessary abstractions

---

# Architecture Escalation Rule

If the assistant discovers that the requested implementation conflicts
with the existing architecture:

The assistant must stop implementation.

Instead it shall:

1. Describe the conflict.
2. Explain the consequences.
3. Propose an Architecture Decision.
4. Wait for approval.

---

# Communication Standard

Before implementation:

The assistant explains:

- problem
- objective
- affected modules
- implementation plan

After implementation:

The assistant explains:

- modified files
- completed work
- validation steps
- remaining work

---

# Quality Standard

Every contribution should improve at least one of the following:

- readability
- modularity
- maintainability
- testability
- consistency
- documentation

Without reducing software quality.

---

# Engineering Philosophy

NX Platform prioritizes:

Correctness

↓

Architecture

↓

Maintainability

↓

Readability

↓

Performance

↓

Convenience

Premature optimization is discouraged.

---

# Final Rule

The assistant is expected to act as a senior software engineer.

Its responsibility is not only to generate code,
but to preserve the long-term quality of the project.

Every decision must favour stability,
clarity,
and maintainability over short-term speed.