---
title: Coding Standard
version: 0.2.0-dev
status: Official
author: NX Intelligent
last-updated: 2026-07-20
related-adr:
  - ADR-001
  - ADR-003
  - ADR-006
---

# Coding Standard

## Introducción

Este documento define las reglas oficiales para el desarrollo de **NX Platform**.

Todo código incorporado al proyecto deberá cumplir estas convenciones.

El objetivo es garantizar:

- Consistencia
- Legibilidad
- Mantenibilidad
- Escalabilidad
- Calidad del código

Estas reglas aplican a:

- Kernel
- Services
- Modules
- Tests
- Herramientas internas

---

# Filosofía

El código debe ser:

- Simple
- Explícito
- Legible
- Reutilizable
- Predecible

Siempre debe privilegiarse la claridad sobre la complejidad.

---

# Principios

Todo desarrollo debe cumplir:

- SOLID (cuando aplique)
- DRY (Don't Repeat Yourself)
- KISS (Keep It Simple)
- YAGNI (You Aren't Gonna Need It)

---

# Organización del Código

Cada archivo debe tener una única responsabilidad.

Ejemplo:

```
Logger.psm1

↓

Solo Logger
```

Nunca:

```
Logger + Configuration + Runtime
```

---

# Nombres de Archivos

Los archivos utilizarán PascalCase.

Ejemplos:

```
Logger.psm1

Runtime.psm1

Configuration.psm1

ModuleLoader.psm1
```

No utilizar:

```
logger.psm1

runtime_module.psm1

config.psm1
```

---

# Convención de Funciones

Todas las funciones públicas utilizarán el patrón:

```
Verbo-NXNombre
```

Ejemplos:

```
Initialize-NXLogger

Get-NXLogger

Register-NXService

Invoke-NXModule
```

---

# Funciones Privadas

Las funciones internas utilizarán igualmente el prefijo NX, pero no serán exportadas.

Ejemplo:

```
Resolve-NXManifest

Validate-NXModule

Import-NXConfiguration
```

---

# Variables

Variables locales:

```powershell
$logger
$config
$runtime
```

Variables privadas del módulo:

```powershell
$script:NXLogger
```

Nunca utilizar:

```powershell
$Global:
```

o

```powershell
$Global:NXLogger
```

---

# Estado

Todo componente deberá encapsular su estado.

Ejemplo:

```powershell
$script:NXConfiguration

$script:NXRuntime

$script:NXContext
```

---

# Exportación

Todo módulo debe exportar únicamente su API pública.

Ejemplo:

```powershell
Export-ModuleMember `
    -Function `
        Initialize-NXLogger,
        Get-NXLogger
```

Nunca utilizar:

```powershell
Export-ModuleMember *
```

---

# CmdletBinding

Toda función pública deberá incluir:

```powershell
[CmdletBinding()]
param()
```

Como primera instrucción.

Ejemplo:

```powershell
function Get-NXLogger {

    [CmdletBinding()]

    param()

}
```

---

# Manejo de Errores

Nunca ocultar errores.

Correcto:

```powershell
throw "Logger service has not been initialized."
```

Incorrecto:

```powershell
return $null
```

cuando exista un error crítico.

---

# Comentarios

Comentar únicamente cuando el código no sea evidente.

Evitar comentarios redundantes.

Incorrecto:

```powershell
# Incrementa el contador

$counter++
```

Correcto:

Explicar únicamente decisiones de diseño o algoritmos complejos.

---

# Formato

Indentación:

```
4 espacios
```

No utilizar tabulaciones.

---

# Longitud de Funciones

Regla general:

Una función debe resolver una sola responsabilidad.

Cuando una función exceda aproximadamente 80–100 líneas, debe evaluarse su división.

No es una regla rígida, pero sí una señal para revisar el diseño.

---

# Dependencias

Nunca importar módulos innecesarios.

Cada dependencia debe estar justificada.

---

# Logging

Todo evento importante deberá registrarse mediante el Logger.

Ejemplos:

- Inicialización
- Error
- Advertencia
- Cambio de estado
- Finalización

---

# Configuración

No utilizar valores "hardcoded".

Incorrecto:

```powershell
$Port = 1883
```

Correcto:

```powershell
$Port = $Configuration.MQTT.Port
```

---

# Versiones

Nunca duplicar versiones.

La versión oficial del proyecto se obtiene desde:

```
VERSION
```

---

# Pruebas

Todo componente nuevo deberá incluir pruebas antes del commit.

Como mínimo deberán validarse:

- Inicialización
- Estado
- Casos válidos
- Casos inválidos
- Manejo de errores

---

# Documentación

Todo componente deberá actualizar la documentación correspondiente.

El código y la documentación deben evolucionar juntos.

---

# Commits

Los commits deberán seguir Conventional Commits.

Ejemplos:

```
feat(kernel): implement bootstrap

feat(logger): add logging service

fix(runtime): resolve initialization bug

docs(architecture): update bootstrap flow

test(configuration): add initialization tests

refactor(kernel): simplify bootstrap sequence
```

---

# Pull Requests

Todo Pull Request deberá incluir:

- Objetivo
- Cambios realizados
- Pruebas ejecutadas
- Impacto esperado
- Documentación actualizada

---

# Antipatrones

No permitido:

❌ Variables globales

❌ Código duplicado

❌ Dependencias circulares

❌ Funciones con múltiples responsabilidades

❌ Valores hardcoded

❌ Exportar funciones innecesarias

❌ Código sin documentación cuando modifica la arquitectura

---

# Checklist Antes del Commit

Antes de realizar un commit debe verificarse:

- Código compilando correctamente.
- Pruebas exitosas.
- Documentación actualizada.
- Sin advertencias críticas.
- Sin código comentado innecesario.
- Sin archivos temporales.
- Versiones consistentes.

---

# ADR Relacionados

ADR-001

El Kernel mantiene una única responsabilidad.

ADR-003

Toda comunicación ocurre mediante servicios.

ADR-006

Todo componente debe ser reutilizable.

---

# Documentos Relacionados

- ARCHITECTURE.md
- SERVICES.md
- MODULES.md
- DEVELOPMENT-WORKFLOW.md
- VERSIONING.md