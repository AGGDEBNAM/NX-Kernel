---
title: NX Platform
subtitle: Kernel Framework
version: 0.2.0-dev
status: In Development
author: NX Intelligent
last-updated: 2026-07-20
---

# NX Platform

> **NX Platform** es un framework modular desarrollado en PowerShell cuyo propósito es proporcionar una infraestructura unificada para la automatización, administración y operación de servicios tecnológicos.

El proyecto nace con el objetivo de construir un ecosistema capaz de administrar infraestructura, aplicaciones y servicios mediante una arquitectura modular, desacoplada y altamente extensible.

---

# Objetivos

NX Platform busca convertirse en una plataforma única desde donde puedan administrarse distintos componentes tecnológicos sin depender de herramientas independientes.

Entre sus principales objetivos se encuentran:

- Administración de infraestructura.
- Automatización de servidores.
- Gestión de Docker.
- Administración de VPN.
- DDNS.
- Gateways.
- Brokers MQTT.
- Servicios Web.
- Respaldos.
- Monitoreo.
- Integraciones futuras.

El Kernel será la base sobre la que funcionarán todos estos módulos.

---

# Filosofía del Proyecto

NX Platform está construido siguiendo cinco principios fundamentales.

## 1. Modularidad

Cada funcionalidad vive en un módulo independiente.

Ningún módulo conoce la implementación interna de otro módulo.

---

## 2. Bajo Acoplamiento

Los módulos nunca interactúan directamente.

Toda comunicación ocurre mediante servicios registrados dentro del Kernel.

---

## 3. Extensibilidad

Agregar un nuevo módulo no debe requerir modificar el Kernel.

El Kernel únicamente descubre, registra y ejecuta módulos.

---

## 4. Consistencia

Todos los componentes siguen exactamente las mismas convenciones.

- Inicialización
- Configuración
- Logging
- Runtime
- Registro
- Documentación

---

## 5. Escalabilidad

La arquitectura está diseñada para crecer durante años sin requerir una reestructuración completa.

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
          ┌───────────────┼───────────────┐
          ▼               ▼               ▼

   Service Registry   Configuration   Runtime

          │               │               │
          └───────────────┼───────────────┘
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

# Componentes

Actualmente el Kernel está dividido en las siguientes áreas.

```text
kernel/

Bootstrap/

Services/

Contracts/

Models/

Internal/
```

Cada una posee responsabilidades claramente definidas.

---

# Estado Actual

Versión:

```
0.2.0-dev
```

Estado del desarrollo:

- ✅ Kernel inicial
- ✅ Context
- ✅ Bootstrap
- ✅ Service Registry

Pendiente:

- Logger
- Configuration
- Runtime
- Manifest
- Module Loader
- Dispatcher

---

# Estructura del Proyecto

```text
NX-Kernel

config/
docs/
kernel/
logs/
modules/
output/
templates/
tests/

README.md
CHANGELOG.md
VERSION
LICENSE
nx.ps1
```

---

# Flujo de Ejecución

Cuando un usuario ejecuta:

```powershell
.\nx.ps1 version
```

el flujo esperado es:

```text
Usuario

↓

nx.ps1

↓

Kernel

↓

Bootstrap

↓

Service Registry

↓

Command Dispatcher

↓

Version Module

↓

Resultado
```

---

# Roadmap

## v0.2

- Bootstrap
- Registry
- Logger
- Configuration

---

## v0.3

- Runtime
- Manifest
- Module Loader

---

## v0.4

- Dispatcher
- Events
- Reports

---

## v0.5

- Providers
- Docker
- Gateway
- DDNS

---

## v1.0

Primer Kernel estable.

---

# Metodología de Desarrollo

Todo el desarrollo sigue el siguiente ciclo:

```text
Arquitectura

↓

Diseño

↓

Implementación

↓

Pruebas

↓

Documentación

↓

Definition of Done

↓

Commit

↓

Tag
```

No se realizan commits sobre código incompleto.

Cada commit representa un estado estable del proyecto.

---

# Convención de Versiones

El proyecto utiliza Semantic Versioning.

Ejemplo:

```
0.2.0-dev
```

Más información en:

```
docs/VERSIONING.md
```

---

# Documentación

La documentación oficial del proyecto se encuentra en:

```
docs/

ARCHITECTURE.md

BOOTSTRAP.md

SERVICES.md

MODULES.md

CODING-STANDARD.md

DEVELOPMENT-WORKFLOW.md

VERSIONING.md

ROADMAP.md
```

---

# Estado del Sprint Actual

Sprint:

```
v0.2.0
```

Objetivo:

- Bootstrap
- Service Registry
- Logger
- Configuration
- Context Integration

---

# Licencia

Consulte el archivo:

```
LICENSE
```

---

# Autor

NX Intelligent

2026