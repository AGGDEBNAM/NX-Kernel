# 07 - Git & Versioning Standard

**Document ID:** ENG-007
**Version:** 1.0.0
**Status:** Approved
**Last Updated:** 2026-07-20

---

# Purpose

This document defines the official source control, branching,
versioning, and release workflow for NX Platform.

Every contributor shall follow these standards.

---

# Objectives

The Git workflow shall provide:

- Traceability
- Predictability
- Safe collaboration
- Reliable releases
- Reproducible history

Git history is considered part of the project documentation.

---

# Repository Structure

The repository contains a single source of truth.

```
main
```

Development work is performed through short-lived branches.

---

# Branch Strategy

## Main

Purpose

Production-ready code.

Rules

- Always stable
- Protected
- No direct commits
- Releases originate from this branch

---

## Develop

Purpose

Integration branch for the next release.

Rules

- Receives completed features
- Must remain buildable
- Protected

---

## Feature Branches

Naming

```
feature/<name>
```

Examples

```
feature/bootstrap

feature/service-registry

feature/context

feature/logger
```

Rules

- One objective
- Short-lived
- Deleted after merge

---

## Release Branches

Naming

```
release/x.y.z
```

Examples

```
release/1.0.0

release/0.3.0
```

Purpose

Release stabilization.

Allowed changes

- Bug fixes
- Documentation
- Version updates

No new features.

---

## Hotfix Branches

Naming

```
hotfix/<issue>
```

Examples

```
hotfix/bootstrap-version

hotfix/logger-null
```

Purpose

Emergency fixes for released versions.

---

# Merge Policy

Preferred

Pull Request

↓

Review

↓

Approval

↓

Merge

Direct pushes to protected branches are prohibited.

---

# Commit Standard

NX Platform adopts

Conventional Commits 1.0.0

Format

```
type(scope): description
```

Examples

```
feat(kernel): add dispatcher initialization

fix(bootstrap): load version from VERSION file

docs(handbook): add testing standard

refactor(context): simplify initialization

test(kernel): add bootstrap smoke tests

build(ci): update GitHub Actions

chore(repo): update dependencies
```

---

# Commit Types

Allowed types

```
feat

fix

docs

style

refactor

perf

test

build

ci

chore

revert
```

---

# Commit Rules

Commits shall be

- Atomic
- Descriptive
- Self-contained
- Buildable

Avoid

```
Update

Changes

Misc fixes

Testing
```

---

# Pull Requests

Every Pull Request shall include

- Objective
- Summary
- Affected Modules
- Testing Evidence
- Breaking Changes
- Documentation Updates

---

# Code Review

Every Pull Request shall be reviewed before merge.

Review verifies

✓ Architecture

✓ Coding Standard

✓ Tests

✓ Documentation

✓ Public API

✓ Regression Risk

---

# Semantic Versioning

NX Platform follows

Semantic Versioning 2.0.0

Format

```
MAJOR.MINOR.PATCH
```

Examples

```
1.0.0

1.2.0

1.2.3
```

---

## MAJOR

Increment when

- Breaking API changes
- Incompatible architecture
- Removed functionality

---

## MINOR

Increment when

- New features
- New modules
- Backward-compatible improvements

---

## PATCH

Increment when

- Bug fixes
- Documentation fixes
- Performance improvements
- Internal refactoring without API changes

---

# Pre-release Versions

Examples

```
1.0.0-alpha.1

1.0.0-beta.2

1.0.0-rc.1
```

Meaning

Alpha

Development

Beta

Feature complete

RC

Release candidate

---

# Version File

Single source of truth

```
VERSION
```

Only Bootstrap reads this file.

All other modules obtain the version through Bootstrap.

---

# Tags

Every release shall be tagged.

Examples

```
v0.1.0

v0.2.0

v1.0.0
```

Tags shall reference released commits only.

---

# Release Process

Feature Development

↓

Testing

↓

Documentation

↓

Release Branch

↓

Release Candidate

↓

Approval

↓

Merge into Main

↓

Tag

↓

Release Notes

---

# Release Notes

Each release shall document

- Features
- Fixes
- Improvements
- Breaking Changes
- Migration Notes
- Known Issues

Location

```
docs/releases/
```

---

# Rollback Strategy

Every release shall be reversible.

Rollback shall use

- Git Tag
- Previous Release
- Release Notes

---

# Repository Protection

Protected branches

```
main

develop
```

Rules

- No force push
- No direct commit
- Pull Request required
- Successful tests required

---

# Engineering Checklist

Before merge verify

✓ Tests passed

✓ Documentation updated

✓ Version correct

✓ No conflicts

✓ Review completed

✓ Architecture preserved

---

# Engineering Philosophy

A clean Git history is an engineering asset.

Every commit should tell a meaningful part of the project's story.

Version numbers communicate intent.

History communicates engineering decisions.