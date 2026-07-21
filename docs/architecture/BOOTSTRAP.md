---
title: Bootstrap
version: 0.2.0-dev
status: Draft
author: NX Intelligent
last-updated: 2026-07-20
related-adr:
  - ADR-001
  - ADR-003
  - ADR-004
---

# Bootstrap

## Introducción

El Bootstrap constituye el punto único de inicialización del Kernel.

Es el primer componente ejecutado después de que el usuario invoque el framework mediante:

```powershell
.\nx.ps1
```

Su responsabilidad consiste en preparar el entorno de ejecución antes de que cualquier módulo pueda utilizar la plataforma.

Bootstrap nunca ejecuta lógica de negocio.

Bootstrap únicamente prepara el sistema.

---

# Objetivos

Bootstrap tiene cinco responsabilidades principales.

- Inicializar el Kernel.
- Crear el Service Registry.
- Registrar los servicios base.
- Preparar el Runtime.
- Dejar el Kernel en estado **Ready**.

Todo lo demás pertenece a otros componentes.

---

# Filosofía

Bootstrap debe ser:

- pequeño
- determinista
- repetible
- predecible

Cada ejecución debe producir exactamente el mismo resultado bajo las mismas condiciones.

No debe depender del estado dejado por una ejecución anterior.

---

# Flujo General

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

Kernel Ready
```

---

# Responsabilidades

Bootstrap únicamente puede realizar las siguientes tareas.

## Inicializar

Crear la estructura mínima necesaria para el funcionamiento del Kernel.

---

## Registrar

Registrar servicios dentro del Service Registry.

---

## Verificar

Confirmar que los servicios críticos existen.

---

## Preparar

Dejar el Kernel listo para aceptar comandos.

---

## Finalizar

Entregar el control al Dispatcher.

---

# Lo que Bootstrap NO debe hacer

Bootstrap nunca debe:

- ejecutar módulos
- leer comandos del usuario
- procesar archivos
- conectarse a servicios externos
- iniciar Docker
- abrir conexiones MQTT
- iniciar VPN
- ejecutar lógica de negocio

Todo ello pertenece a los módulos.

---

# Ciclo de Vida

```text
Start

↓

Create Bootstrap State

↓

Create Service Registry

↓

Initialize Services

↓

Register Services

↓

Validate Services

↓

Kernel Ready
```

---

# Estado Interno

Bootstrap mantiene únicamente información relacionada con su propia ejecución.

Ejemplo:

```powershell
$script:NXBootstrap = [PSCustomObject]@{

    Initialized = $false

    Version = "0.2.0"

    StartTime = $null

}
```

Bootstrap no almacena información de módulos.

---

# Service Registry

Bootstrap crea el registro oficial de servicios.

```powershell
$script:NXServices = @{}
```

A partir de este momento todos los componentes compartirán esta estructura.

---

# API Pública

Actualmente Bootstrap expone las siguientes funciones.

## Initialize-NXBootstrap

Inicializa completamente el entorno.

---

## Get-NXBootstrap

Obtiene el estado del Bootstrap.

---

## Register-NXService

Registra un servicio.

---

## Get-NXService

Obtiene un servicio.

---

## Get-NXServices

Obtiene todos los servicios registrados.

---

## Test-NXService

Verifica la existencia de un servicio.

---

# Flujo de Inicialización

```text
Initialize-NXBootstrap

↓

Create Registry

↓

Register Configuration

↓

Register Logger

↓

Register Context

↓

Register Runtime

↓

Register Manifest

↓

Register Module Loader

↓

Validate Registry

↓

Ready
```

---

# Registro de Servicios

Cada servicio debe registrarse exactamente una vez.

Ejemplo:

```powershell
Register-NXService `
    -Name Logger `
    -Instance $Logger
```

Intentar registrar un nombre ya existente debe producir un error.

---

# Recuperación

Todo componente debe obtener servicios mediante:

```powershell
Get-NXService Logger
```

Nunca debe acceder directamente al Registry.

---

# Validación

Bootstrap debe verificar que todos los servicios obligatorios existen antes de finalizar.

Servicios mínimos:

- Configuration
- Logger
- Context
- Runtime

Si alguno falta:

Bootstrap debe cancelar la inicialización.

---

# Manejo de Errores

Bootstrap debe detener inmediatamente la inicialización cuando ocurra un error crítico.

No debe intentar continuar con un estado inconsistente.

---

# Extensibilidad

Bootstrap no debe modificarse para agregar nuevos módulos.

Los nuevos componentes deberán descubrirse automáticamente mediante el Module Loader.

---

# Estados del Bootstrap

```text
Not Initialized

↓

Initializing

↓

Registering Services

↓

Validating

↓

Ready

↓

Failed
```

Todo Bootstrap debe encontrarse exactamente en uno de estos estados.

---

# Pruebas de Aceptación

El siguiente flujo debe ejecutarse correctamente.

```powershell
Import-Module .\kernel\Bootstrap\Bootstrap.psm1

Initialize-NXBootstrap

Register-NXService `
    -Name Logger `
    -Instance @{
        Name = "Logger"
    }

Register-NXService `
    -Name Context `
    -Instance @{
        Name = "Context"
    }

Get-NXServices

Test-NXService Logger
```

Resultado esperado:

```text
Initialized : True

Version : 0.2.0

Logger : Registered

Context : Registered
```

---

# Consideraciones de Rendimiento

Bootstrap debe ejecutarse únicamente una vez durante el ciclo de vida del proceso.

No debe reinicializarse salvo mediante una operación explícita de reinicio del Kernel.

---

# Decisiones Arquitectónicas

## ADR-001

Bootstrap constituye el único punto de inicialización.

---

## ADR-003

Todo servicio debe registrarse mediante el Service Registry.

---

## ADR-004

Bootstrap nunca ejecuta lógica de negocio.

---

# Evolución Futura

En versiones posteriores Bootstrap incorporará:

- Inicialización por fases.
- Validación de dependencias.
- Carga paralela de servicios.
- Diagnóstico de arranque.
- Métricas de inicialización.
- Perfil de rendimiento.
- Registro detallado del tiempo de carga.

---

# Documentos Relacionados

- ARCHITECTURE.md
- SERVICES.md
- MODULES.md
- DEVELOPMENT-WORKFLOW.md
- VERSIONING.md