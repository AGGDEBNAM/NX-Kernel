---
title: Versioning Strategy
version: 0.2.0-dev
status: Official
author: NX Intelligent
last-updated: 2026-07-20
---

# Versioning Strategy

## Introducción

Este documento define la estrategia oficial de versionado para NX Platform.

El objetivo es proporcionar un sistema consistente para identificar el estado del proyecto, garantizar compatibilidad entre componentes y facilitar el mantenimiento a largo plazo.

Toda versión publicada deberá seguir las reglas descritas en este documento.

---

# Objetivos

El sistema de versionado busca:

- Identificar claramente el estado del proyecto.
- Facilitar la trazabilidad.
- Mantener compatibilidad entre versiones.
- Permitir releases predecibles.
- Coordinar la evolución del Kernel y sus módulos.

---

# Semantic Versioning

NX Platform utiliza Semantic Versioning (SemVer).

Formato:

MAJOR.MINOR.PATCH

Ejemplo:

```
1.4.2
```

---

# Significado

## MAJOR

Se incrementa cuando existen cambios incompatibles con versiones anteriores.

Ejemplos:

- Eliminación de API pública.
- Cambios en contratos.
- Cambios de arquitectura incompatibles.

---

## MINOR

Se incrementa cuando se agregan nuevas funcionalidades compatibles.

Ejemplos:

- Nuevo servicio.
- Nuevo módulo.
- Nueva API.

---

## PATCH

Se incrementa cuando únicamente existen correcciones.

Ejemplos:

- Corrección de errores.
- Optimizaciones.
- Mejoras internas.

---

# Versiones de Desarrollo

Durante el desarrollo se utilizarán sufijos.

Ejemplos:

```
0.2.0-dev

0.2.0-alpha

0.2.0-beta

0.2.0-rc1

0.2.0
```

---

# Ciclo de Release

El flujo recomendado es:

```
Development

↓

Alpha

↓

Beta

↓

Release Candidate

↓

Stable
```

No todas las versiones deberán pasar por todas las etapas.

---

# Archivo VERSION

La versión oficial del proyecto se almacena en:

```
VERSION
```

Ejemplo:

```
0.2.0-dev
```

Todos los componentes deberán obtener la versión desde este archivo.

Nunca deberá duplicarse en el código.

---

# Versionado del Kernel

El Kernel posee una única versión oficial.

Ejemplo:

```
Kernel

0.2.0
```

Todos los servicios internos forman parte de esa versión.

---

# Versionado de Módulos

Los módulos evolucionan independientemente del Kernel.

Ejemplo:

```
Kernel

0.2.0

Docker Module

1.3.1

MQTT Module

2.0.0

Gateway Module

0.8.0
```

---

# Compatibilidad

Todo módulo deberá declarar la versión mínima del Kernel requerida.

Ejemplo:

```json
{
    "kernel": ">=0.2.0"
}
```

El Module Loader verificará esta compatibilidad antes de cargar el módulo.

---

# Conventional Commits

Todos los commits deberán seguir Conventional Commits.

Ejemplos:

```
feat(kernel): implement bootstrap

feat(configuration): add configuration service

fix(logger): resolve file locking issue

docs(architecture): update module flow

test(runtime): add runtime initialization tests

refactor(module-loader): simplify discovery
```

---

# Tags

Cada versión estable deberá tener un Tag.

Ejemplos:

```
v0.2.0

v0.3.0

v1.0.0
```

Los Tags representan hitos del proyecto.

No deben utilizarse para versiones intermedias.

---

# Releases

Toda Release deberá incluir:

- Código estable.
- CHANGELOG actualizado.
- Documentación completa.
- VERSION actualizado.
- Pruebas exitosas.

---

# Changelog

Cada Release deberá documentarse en:

```
CHANGELOG.md
```

Como mínimo deberá incluir:

- Nuevas funcionalidades.
- Cambios.
- Correcciones.
- Eliminaciones.

---

# Política de Compatibilidad

Mientras el proyecto permanezca en versión:

```
0.x.x
```

La API podrá cambiar.

A partir de:

```
1.0.0
```

Toda modificación incompatible requerirá incrementar la versión MAJOR.

---

# Política de Hotfix

Los Hotfix deberán:

- Corregir un único problema.
- No introducir nuevas funcionalidades.
- Incrementar únicamente PATCH.

Ejemplo:

```
0.2.1

↓

0.2.2
```

---

# Política de Deprecación

Cuando una funcionalidad vaya a eliminarse deberá seguir el siguiente proceso:

1. Marcar como Deprecated.
2. Documentar la alternativa.
3. Mantener compatibilidad durante una versión MINOR.
4. Eliminar en la siguiente versión MAJOR.

---

# Versiones Objetivo

## v0.2

Bootstrap

Service Registry

Logger

Configuration

---

## v0.3

Runtime

Manifest

Module Loader

---

## v0.4

Dispatcher

Event Bus

Reports

---

## v0.5

Infrastructure Modules

---

## v1.0

Primera versión estable.

API pública congelada.

---

# Buenas Prácticas

✔ Mantener CHANGELOG actualizado.

✔ Crear Tags únicamente en versiones estables.

✔ Utilizar Conventional Commits.

✔ Versionar módulos independientemente.

✔ Evitar cambios incompatibles innecesarios.

---

# Documentos Relacionados

- CHANGELOG.md
- DEVELOPMENT-WORKFLOW.md
- CODING-STANDARD.md
- ROADMAP.md