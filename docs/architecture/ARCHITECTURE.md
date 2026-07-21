---
title: NX Platform Architecture
version: 0.2.0-dev
status: Draft
author: NX Intelligent
last-updated: 2026-07-20
---

# NX Platform Architecture

## Introducción

Este documento define la arquitectura oficial de **NX Platform** y constituye la referencia técnica para el desarrollo del Kernel y todos los módulos del ecosistema.

Toda implementación deberá respetar las decisiones descritas en este documento.

---

# Filosofía de la Arquitectura

NX Platform no es una colección de scripts de PowerShell.

NX Platform es un **Framework Modular** cuyo objetivo es proporcionar una infraestructura común para la administración de servicios tecnológicos.

El Kernel debe ser completamente independiente de los módulos que ejecuta.

Esto significa que el Kernel nunca conocerá la implementación específica de:

- Docker
- Gateway
- DDNS
- MQTT
- WEB-NXIntelligent
- Backup
- Monitor
- cualquier módulo futuro

Su única responsabilidad consiste en administrar el ciclo de vida de la plataforma.

---

# Principios Arquitectónicos

Toda decisión técnica deberá respetar los siguientes principios.

## 1. Single Responsibility Principle

Cada componente posee una única responsabilidad.

Ejemplos:

Bootstrap
→ Inicializar el sistema.

Logger
→ Registrar eventos.

Configuration
→ Administrar configuración.

Runtime
→ Mantener el estado de ejecución.

---

## 2. Low Coupling

Los módulos nunca deben conocerse entre sí.

Toda interacción ocurre mediante servicios registrados.

---

## 3. High Cohesion

Toda la lógica relacionada debe permanecer dentro del mismo componente.

---

## 4. Extensibility

Agregar un nuevo módulo no debe requerir modificar el Kernel.

---

## 5. Dependency Inversion

Los componentes dependen de contratos y servicios.

Nunca de implementaciones concretas.

---

# Arquitectura General

```text
                           NX Platform

                                │

                                ▼

                            nx.ps1

                                │

                                ▼

                           NX Kernel

                                │

                                ▼

                           Bootstrap

                                │

                ┌───────────────┴───────────────┐

                ▼                               ▼

         Service Registry                 Configuration

                │                               │

                └───────────────┬───────────────┘

                                ▼

                            Services

                                │

                                ▼

                       Command Dispatcher

                                │

                                ▼

                            Modules
```

---

# Componentes Principales

La plataforma está dividida en tres grandes capas.

```text
Framework

│

├── Kernel

├── Services

└── Modules
```

---

## Kernel

El Kernel controla el ciclo de vida completo del Framework.

Responsabilidades:

- Inicialización
- Bootstrap
- Registro de servicios
- Descubrimiento de módulos
- Despacho de comandos
- Finalización

El Kernel nunca implementa lógica de negocio.

---

## Services

Los servicios proporcionan funcionalidades reutilizables para todo el Framework.

Ejemplos:

Logger

Configuration

Context

Runtime

Manifest

ModuleLoader

EventBus

Report

---

## Modules

Los módulos contienen funcionalidades específicas.

Ejemplos futuros:

Docker

Gateway

MQTT

DDNS

Web

Backup

Monitor

Los módulos pueden depender de servicios.

Nunca de otros módulos.

---

# Ciclo de Vida del Kernel

```text
Usuario

↓

nx.ps1

↓

Kernel

↓

Bootstrap

↓

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

↓

Dispatcher

↓

Módulo

↓

Resultado
```

Todo comando deberá seguir exactamente este flujo.

---

# Bootstrap

Bootstrap constituye el punto único de inicialización.

Responsabilidades:

- Crear el Service Registry.
- Inicializar servicios.
- Registrar servicios.
- Preparar el Runtime.
- Finalizar la inicialización.

Bootstrap no ejecuta comandos.

---

# Service Registry

El Service Registry es el mecanismo oficial para compartir servicios.

No existen variables globales.

Todos los servicios se registran mediante:

```powershell
Register-NXService
```

Y se obtienen mediante:

```powershell
Get-NXService
```

Esto desacopla completamente la plataforma.

---

# Services

Todo servicio debe implementar una API consistente.

Como mínimo:

```powershell
Initialize-NX<Service>

Get-NX<Service>
```

Opcionalmente:

```powershell
Reset-NX<Service>

Invoke-NX<Service>
```

---

# Command Dispatcher

El Dispatcher es responsable de localizar el módulo adecuado para ejecutar un comando.

Ejemplo:

```text
version

↓

Dispatcher

↓

Version Module
```

El Dispatcher reemplazará completamente cualquier uso de:

```powershell
switch($Command)
```

---

# Module Loader

El Module Loader descubrirá automáticamente todos los módulos instalados.

Cada módulo deberá contener:

```text
module.json

Module.psm1
```

El Kernel nunca conocerá módulos específicos.

---

# Dependencias

Las dependencias deberán declararse explícitamente.

Ejemplo:

```json
{
  "requires": [
    "Logger",
    "Configuration"
  ]
}
```

El Module Loader verificará dichas dependencias antes de cargar el módulo.

---

# Estructura Oficial

```text
NX-Kernel

config/

docs/

kernel/

Bootstrap/

Services/

Contracts/

Models/

Internal/

modules/

tests/
```

Esta estructura constituye el estándar oficial.

---

# Flujo de Inicialización

```text
Kernel

↓

Bootstrap

↓

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

↓

Dispatcher

↓

Ready
```

Una vez alcanzado el estado **Ready**, el Kernel podrá ejecutar comandos.

---

# Roadmap Arquitectónico

## v0.2

Bootstrap

Registry

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

Providers

Docker

Gateway

DDNS

---

## v1.0

Kernel estable

API pública congelada

---

# Decisiones Arquitectónicas (ADR)

## ADR-001

El Kernel no contiene lógica de negocio.

---

## ADR-002

Los módulos nunca se comunican directamente.

---

## ADR-003

Toda comunicación ocurre mediante servicios registrados.

---

## ADR-004

Bootstrap constituye el único punto de inicialización.

---

## ADR-005

No existen variables globales.

---

## ADR-006

Todo componente debe ser desacoplado y reutilizable.

---

# Documentos Relacionados

- BOOTSTRAP.md
- SERVICES.md
- MODULES.md
- CODING-STANDARD.md
- DEVELOPMENT-WORKFLOW.md
- VERSIONING.md