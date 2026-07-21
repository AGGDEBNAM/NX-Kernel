---
title: Modules Specification
version: 0.2.0-dev
status: Draft
author: NX Intelligent
last-updated: 2026-07-20
related-adr:
  - ADR-002
  - ADR-003
  - ADR-006
  - ADR-007
---

# Modules

# Introducción

Los **Modules** representan las capacidades funcionales de NX Platform.

Mientras que el Kernel proporciona la infraestructura base y los Services ofrecen funcionalidades reutilizables, los Modules implementan las características que utiliza el usuario final.

Ejemplos:

- Docker
- MQTT
- Gateway
- DDNS
- Backup
- Monitor
- Web
- VPN
- Database

Un módulo puede instalarse, actualizarse o eliminarse sin modificar el Kernel.

---

# Objetivo

Los módulos permiten extender la plataforma sin alterar la arquitectura principal.

El Kernel únicamente debe:

- descubrir módulos
- cargarlos
- validarlos
- ejecutarlos
- descargarlos

Nunca deberá conocer su implementación interna.

---

# Filosofía

Los módulos son plugins.

El Kernel únicamente proporciona el entorno de ejecución.

Esta filosofía permite que NX Platform pueda evolucionar durante años sin convertirse en un sistema monolítico.

---

# Arquitectura

```text
                   Kernel

                      │

                      ▼

              Module Loader

                      │

        ┌─────────────┴─────────────┐

        ▼                           ▼

     Docker                     Gateway

        ▼                           ▼

     MQTT                       DDNS

        ▼                           ▼

     Backup                     Web
```

El Kernel nunca realiza llamadas directas a un módulo específico.

---

# Responsabilidades

Un módulo debe cumplir únicamente las siguientes responsabilidades.

- Resolver una capacidad específica.
- Consumir servicios del Kernel.
- Exponer comandos.
- Administrar su propio estado.
- Liberar recursos al finalizar.

---

# Lo que un módulo NO debe hacer

Un módulo nunca debe:

- modificar el Kernel
- modificar Bootstrap
- registrar servicios internos del Kernel
- acceder a variables privadas
- utilizar variables globales
- modificar otros módulos

---

# Estructura Oficial

Todo módulo deberá seguir exactamente la siguiente estructura.

```text
modules/

NombreDelModulo/

module.json

Module.psm1

README.md

resources/

tests/
```

---

# Manifest

Cada módulo debe contener un archivo:

```text
module.json
```

Ejemplo:

```json
{
    "name": "Docker",

    "version": "1.0.0",

    "author": "NX Intelligent",

    "description": "Docker Management Module",

    "entryPoint": "Module.psm1",

    "requires": [
        "Logger",
        "Configuration"
    ]
}
```

---

# Descubrimiento

El Module Loader buscará automáticamente todos los directorios dentro de:

```text
modules/
```

Cada carpeta será inspeccionada.

Si existe:

```
module.json
```

el módulo será considerado válido.

---

# Validación

Antes de cargar un módulo deberán verificarse:

- Manifest existente.
- EntryPoint existente.
- Dependencias.
- Versión mínima requerida.
- Compatibilidad con el Kernel.

Si alguna validación falla:

El módulo no será cargado.

---

# Carga

Una vez validado:

```text
Manifest

↓

Import Module

↓

Initialize

↓

Ready
```

---

# Ciclo de Vida

Todo módulo seguirá el siguiente flujo.

```text
Discovered

↓

Validated

↓

Loaded

↓

Initialized

↓

Running

↓

Stopped

↓

Unloaded
```

---

# API Recomendada

Todo módulo debería implementar como mínimo:

```powershell
Initialize-NXModule

Invoke-NXModule

Get-NXModule

Remove-NXModule
```

Cuando aplique:

```powershell
Test-NXModule

Update-NXModule

Export-NXModule
```

---

# Acceso a Servicios

Los módulos nunca crearán servicios.

Siempre deberán utilizar:

```powershell
Get-NXService Logger

Get-NXService Configuration
```

Nunca:

```powershell
$Global:Logger
```

---

# Dependencias

Las dependencias deberán declararse en el Manifest.

Ejemplo:

```json
{
    "requires": [

        "Logger",

        "Configuration",

        "Runtime"

    ]
}
```

El Module Loader verificará estas dependencias antes de inicializar el módulo.

---

# Comunicación

Los módulos nunca deberán comunicarse directamente.

Ejemplo incorrecto:

```text
Docker

↓

MQTT
```

Ejemplo correcto:

```text
Docker

↓

Event Bus

↓

MQTT
```

o

```text
Docker

↓

Service

↓

MQTT
```

---

# Estado Interno

Cada módulo administrará únicamente su propio estado.

Ejemplo:

```powershell
$script:NXDocker

$script:NXGateway

$script:NXBackup
```

Nunca deberá modificar estados de otros módulos.

---

# Versionado

Cada módulo tendrá su propio versionado.

Ejemplo:

Kernel

```
0.3.0
```

Docker

```
1.2.1
```

Gateway

```
2.0.0
```

Los módulos evolucionan independientemente del Kernel.

---

# Seguridad

Los módulos no deben:

- ejecutar código arbitrario
- modificar archivos del Kernel
- sobrescribir configuraciones internas
- acceder a recursos no autorizados

Todo acceso deberá realizarse mediante los servicios proporcionados por la plataforma.

---

# Buenas Prácticas

✔ Mantener una única responsabilidad.

✔ Documentar el Manifest.

✔ Validar dependencias.

✔ Liberar recursos correctamente.

✔ Registrar eventos mediante Logger.

✔ Utilizar Configuration para parámetros.

✔ Evitar estados globales.

---

# Antipatrones

No permitido:

❌ Modificar Bootstrap.

❌ Modificar Services.

❌ Modificar Registry.

❌ Acceder a módulos directamente.

❌ Crear dependencias circulares.

❌ Compartir variables.

---

# Roadmap

Los primeros módulos planificados son:

- Docker
- Gateway
- DDNS
- MQTT
- Backup
- Monitor
- Web
- Database
- VPN

---

# ADR Relacionados

ADR-002

Los módulos nunca deben conocerse entre sí.

ADR-003

Toda interacción ocurre mediante servicios.

ADR-006

Los componentes deben ser reutilizables.

ADR-007

Los módulos constituyen extensiones desacopladas del Kernel.

---

# Documentos Relacionados

- ARCHITECTURE.md
- SERVICES.md
- BOOTSTRAP.md
- CODING-STANDARD.md
- DEVELOPMENT-WORKFLOW.md