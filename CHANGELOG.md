# Changelog

Todos los cambios importantes de **NX Platform** serán documentados en este archivo.

Este proyecto sigue las recomendaciones de **Keep a Changelog** y utiliza **Semantic Versioning (SemVer)**.

---

# Tipos de cambios

Los cambios deberán clasificarse utilizando las siguientes categorías.

## Added

Nuevas funcionalidades.

---

## Changed

Cambios sobre funcionalidades existentes.

---

## Deprecated

Funcionalidades marcadas para eliminación futura.

---

## Removed

Funcionalidades eliminadas.

---

## Fixed

Correcciones de errores.

---

## Security

Correcciones relacionadas con seguridad.

---

# [Unreleased]

## Planned

- Logger Service
- Configuration Service
- Runtime Service
- Manifest Service
- Module Loader
- Command Dispatcher
- Event Bus
- Report Engine

---

# [0.2.0-dev] - 2026-07-20

## Added

### Kernel

- Creación del proyecto NX Platform.
- Inicialización del Kernel.
- Context Service.
- Bootstrap Service.
- Service Registry.
- Estado inicial del Kernel.

---

### Bootstrap

- Initialize-NXBootstrap
- Get-NXBootstrap
- Register-NXService
- Get-NXService
- Get-NXServices
- Test-NXService

---

### Arquitectura

- Separación entre Kernel, Services y Modules.
- Definición de la arquitectura desacoplada.
- Introducción del Service Registry.
- Diseño del ciclo de vida del Kernel.
- Definición del flujo de Bootstrap.

---

### Documentación

Se incorpora la documentación oficial del proyecto.

- README
- ARCHITECTURE
- BOOTSTRAP
- SERVICES
- MODULES
- CODING-STANDARD
- DEVELOPMENT-WORKFLOW
- VERSIONING

---

### Git

Se adopta oficialmente:

- Semantic Versioning
- Conventional Commits
- Documentation Sprint
- Definition of Done

---

## Changed

N/A

---

## Deprecated

N/A

---

## Removed

N/A

---

## Fixed

Se corrigieron problemas durante el desarrollo inicial del Bootstrap.

- Error de importación del módulo.
- Corrección del orden de CmdletBinding().
- Corrección del Bootstrap State.
- Corrección del Service Registry.

---

## Security

N/A

---

# Formato para futuras versiones

## [x.y.z] - YYYY-MM-DD

### Added

-

### Changed

-

### Deprecated

-

### Removed

-

### Fixed

-

### Security

-

---

# Convenciones

Todo cambio importante deberá registrarse antes de crear una Release.

No se permiten versiones estables sin actualizar este archivo.

---

# Relación con Git

Cada entrada del CHANGELOG debe corresponder con uno o varios commits.

Ejemplo:

feat(kernel): implement bootstrap

↓

CHANGELOG

↓

Release

↓

Tag

---

# Buenas Prácticas

✔ Registrar únicamente cambios relevantes.

✔ Mantener el orden cronológico inverso.

✔ Utilizar descripciones claras.

✔ No documentar cambios triviales.

✔ Actualizar antes de crear un Tag.

---

# Referencias

Semantic Versioning

VERSIONING.md

Development Workflow

DEVELOPMENT-WORKFLOW.md