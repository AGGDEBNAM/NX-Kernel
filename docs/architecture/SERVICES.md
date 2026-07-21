---
title: Services Specification
version: 0.2.0-dev
status: Draft
author: NX Intelligent
last-updated: 2026-07-20
related-adr:
  - ADR-001
  - ADR-002
  - ADR-003
  - ADR-006
---

# Services

# Introducción

Los **Services** constituyen la capa de infraestructura compartida del Kernel.

Proporcionan funcionalidades reutilizables para cualquier componente del framework.

Un servicio representa una capacidad técnica del sistema, no una funcionalidad de negocio.

Ejemplos:

- Logger
- Configuration
- Context
- Runtime
- Manifest
- Module Loader
- Event Bus
- Report Engine

---

# Objetivos

La capa de servicios tiene los siguientes objetivos.

- Centralizar funcionalidades comunes.
- Reducir duplicidad de código.
- Desacoplar módulos.
- Facilitar pruebas.
- Estandarizar el acceso a recursos.

---

# Principios

Todo servicio debe cumplir los siguientes principios.

## Single Responsibility

Un servicio realiza únicamente una función.

Ejemplo:

Logger

→ Registrar eventos.

Nunca:

Registrar eventos + leer configuración.

---

## Stateless cuando sea posible

Siempre que sea viable, un servicio no debe depender de estados internos complejos.

Cuando deba mantener estado, éste deberá ser claramente documentado.

---

## Reutilizable

Todo servicio debe poder utilizarse desde cualquier módulo.

---

## Independiente

Los servicios no deben depender entre sí de manera circular.

---

## Descubrible

Todo servicio debe registrarse en el Service Registry.

---

# Arquitectura

```text
Modules

│

├──────────────┐

│              │

▼              ▼

Get-NXService()

│

▼

Service Registry

│

├──────────────┐

│              │

▼              ▼

Logger     Configuration

Context    Runtime

Manifest   Module Loader
```

Los módulos nunca crean instancias directamente.

Siempre utilizan el Registry.

---

# Ciclo de Vida

Todo servicio sigue el siguiente ciclo.

```text
Create

↓

Initialize

↓

Register

↓

Ready

↓

Use

↓

Dispose (Future)
```

---

# Contrato Mínimo

Todo servicio deberá exponer como mínimo:

```powershell
Initialize-NX<Service>

Get-NX<Service>
```

Ejemplo:

```powershell
Initialize-NXLogger

Get-NXLogger
```

---

# API Recomendada

Cuando aplique, un servicio podrá implementar:

```powershell
Initialize-NX<Service>

Get-NX<Service>

Reset-NX<Service>

Test-NX<Service>

Invoke-NX<Service>

Remove-NX<Service>
```

No todos los servicios necesitarán todas las funciones.

---

# Registro

Todos los servicios deberán registrarse utilizando exclusivamente:

```powershell
Register-NXService
```

Ejemplo:

```powershell
Register-NXService `
    -Name Logger `
    -Instance $Logger
```

Nunca deberán agregarse manualmente al Registry.

---

# Recuperación

Todo componente obtiene un servicio mediante:

```powershell
$Logger = Get-NXService Logger
```

Nunca mediante:

```powershell
$script:Logger
```

Ni:

```powershell
$Global:Logger
```

---

# Dependencias

Si un servicio depende de otro servicio, deberá declararlo explícitamente.

Ejemplo:

```text
Report

↓

Logger

↓

Configuration
```

Nunca deberán existir dependencias circulares.

Ejemplo inválido:

```text
Logger

↓

Configuration

↓

Logger
```

---

# Manejo de Estado

Cuando un servicio mantenga información interna, ésta deberá encapsularse.

Ejemplo:

```powershell
$script:NXLogger

$script:NXConfiguration

$script:NXRuntime
```

Nunca deberán utilizarse variables globales.

---

# Manejo de Errores

Los servicios deben generar errores claros y consistentes.

Ejemplo:

```powershell
throw "Logger service has not been initialized."
```

No deberán retornar estados ambiguos.

---

# Convenciones

Todos los servicios siguen el mismo patrón.

Estado interno:

```powershell
$script:NX<Service>
```

Inicialización:

```powershell
Initialize-NX<Service>
```

Consulta:

```powershell
Get-NX<Service>
```

Validación:

```powershell
Test-NX<Service>
```

---

# Ejemplo de Servicio

```powershell
$script:NXExample = [PSCustomObject]@{

    Initialized = $false

    Version = "1.0"

}
```

API:

```powershell
Initialize-NXExample

Get-NXExample

Test-NXExample
```

Registro:

```powershell
Register-NXService `
    -Name Example `
    -Instance $script:NXExample
```

---

# Servicios Oficiales del Kernel

Actualmente el Kernel contempla los siguientes servicios.

| Servicio | Estado |
|----------|--------|
| Bootstrap | ✅ |
| Context | ✅ |
| Logger | 🚧 |
| Configuration | 🚧 |
| Runtime | 🚧 |
| Manifest | 🚧 |
| Module Loader | 🚧 |
| Event Bus | 📋 |
| Report | 📋 |

---

# Orden de Inicialización

```text
Configuration

↓

Logger

↓

Context

↓

Runtime

↓

Manifest

↓

Module Loader
```

Este orden garantiza que las dependencias estén disponibles.

---

# Buenas Prácticas

✔ Mantener un único propósito.

✔ Evitar dependencias innecesarias.

✔ Utilizar siempre el Service Registry.

✔ Mantener nombres consistentes.

✔ Documentar cambios de estado.

✔ Validar antes de utilizar.

✔ Lanzar excepciones claras.

---

# Antipatrones

No se permite:

❌ Variables Globales

❌ Dependencias circulares

❌ Servicios que ejecuten lógica de negocio

❌ Acceso directo entre módulos

❌ Duplicación de servicios

❌ Registro manual fuera del Bootstrap

---

# Futuras Extensiones

En versiones posteriores se incorporará soporte para:

- Inyección de dependencias.
- Lazy Loading.
- Servicios opcionales.
- Prioridades de inicialización.
- Servicios remotos.
- Servicios distribuidos.

---

# ADR Relacionados

ADR-001

Bootstrap controla la inicialización.

ADR-002

Los módulos no se comunican directamente.

ADR-003

Todo acceso ocurre mediante el Service Registry.

ADR-006

Todos los componentes deben ser reutilizables.

---

# Documentos Relacionados

- ARCHITECTURE.md
- BOOTSTRAP.md
- MODULES.md
- CODING-STANDARD.md
- DEVELOPMENT-WORKFLOW.md