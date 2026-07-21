# GitHub Copilot Instructions — NX Platform Engineering Standards

> **Proyecto:** NX Platform Kernel  
> **Ubicación:** `.github/copilot-instructions.md`

---

# Objetivo

Este documento define las reglas permanentes que GitHub Copilot deberá seguir al generar código, proponer cambios o asistir durante el desarrollo de NX Platform.

Estas instrucciones representan los estándares oficiales de ingeniería del proyecto.

---

# 1. Arquitectura del Proyecto

NX Platform está construido utilizando una arquitectura basada en:

- Composition Root
- Dependency Injection
- Service Registry
- Bootstrap Lifecycle
- Arquitectura Modular
- Bajo Acoplamiento
- Alta Cohesión

Toda propuesta deberá respetar esta arquitectura.

Nunca proponer soluciones que la contradigan.

---

# 2. Composition Root

Existe un único Composition Root:

```
NX.psm1
```

Es responsable de:

- Construir el grafo de dependencias.
- Crear servicios.
- Registrar servicios.
- Resolver dependencias.
- Inicializar la plataforma.
- Iniciar Kernel.

Ningún otro módulo debe asumir estas responsabilidades.

---

# 3. Dependency Injection

Toda dependencia deberá ser inyectada.

No crear dependencias dentro de un módulo consumidor.

Correcto

```
Composition Root

↓

Create Service

↓

Register Service

↓

Inject Dependency

↓

Consumer
```

Incorrecto

```
Consumer

↓

Create Service
```

---

# 4. Kernel

Kernel es únicamente un orquestador.

Debe:

- Ejecutar comandos.
- Coordinar flujo de ejecución.
- Consumir dependencias.

Nunca debe:

- Crear servicios.
- Registrar servicios.
- Resolver dependencias.
- Importar módulos internos únicamente para obtener objetos compartidos.

---

# 5. Servicios

Cada servicio debe poseer una única responsabilidad.

Ejemplos:

- Context
- Configuration
- Logger
- Runtime
- Manifest

Los servicios no deben conocerse entre sí durante su construcción.

---

# 6. Bootstrap

Bootstrap administra el ciclo de vida de la plataforma.

Debe:

- Registrar servicios.
- Inicializar Runtime.
- Validar inicialización.

No debe contener lógica de negocio.

---

# 7. Principios SOLID

Todo código generado deberá respetar:

- Single Responsibility Principle
- Open / Closed Principle
- Liskov Substitution Principle
- Interface Segregation Principle (cuando aplique)
- Dependency Inversion Principle

---

# 8. PowerShell

Todo desarrollo deberá utilizar:

```
PowerShell 7 (pwsh)
```

No utilizar:

- Windows PowerShell 5.1
- powershell.exe

Todas las pruebas deberán ejecutarse utilizando:

```powershell
pwsh -NoProfile
```

---

# 9. Expresiones Complejas

No utilizar expresiones complejas directamente como parámetros.

Evitar:

```powershell
Register-NXService `
    -Instance [PSCustomObject]@{}
```

Preferir:

```powershell
$service = [PSCustomObject]@{}

Register-NXService `
    -Instance $service
```

---

# 10. Variables

Utilizar nombres descriptivos.

Correcto

```
$runtimeContext

$loggerService

$configurationService
```

Incorrecto

```
$temp

$obj

$x
```

---

# 11. Módulos

Cada módulo debe tener una única responsabilidad.

No introducir dependencias circulares.

Exportar únicamente la API pública.

Ocultar la implementación interna.

---

# 12. Flujo de Ingeniería

Antes de modificar código seguir siempre el proceso:

```
Evidence

↓

Hypothesis

↓

Analysis

↓

Minimal Fix

↓

Validation

↓

Documentation
```

Nunca invertir este orden.

Nunca corregir primero y analizar después.

---

# 13. Correcciones

Aplicar siempre:

**Minimal Fix First**

Antes de realizar un refactor mayor demostrar que:

- existe el problema
- existe evidencia
- la solución propuesta resuelve el problema

---

# 14. Refactorización

No realizar refactorizaciones innecesarias.

Todo refactor debe:

- mejorar arquitectura
- reducir acoplamiento
- mejorar mantenibilidad

Nunca modificar múltiples responsabilidades en un mismo cambio sin justificación.

---

# 15. Arquitectura

Si existe una duda arquitectónica:

NO implementar inmediatamente.

Primero:

- recopilar evidencia
- analizar alternativas
- justificar decisión

Si modifica la arquitectura:

Generar un ADR.

---

# 16. Validación

Después de cualquier cambio ejecutar como mínimo:

```powershell
Import-Module .\NX.psm1 -Force

.\nx.ps1 version

.\nx.ps1 context

Start-NX -Command version

Start-NX -Command context
```

Todos deben finalizar en:

```
PASS
```

---

# 17. Documentación

Cuando corresponda:

Generar:

- ADR
- Engineering Note
- Actualización del Handbook
- Sprint Closure

No generar documentación hasta confirmar la causa raíz del problema.

---

# 18. Commits

Los mensajes deben seguir Conventional Commits.

Ejemplos:

```
feat(kernel): add runtime pipeline

fix(bootstrap): resolve service registration

refactor(composition-root): inject Context into Kernel

docs(adr): add ADR-0002 context lifecycle
```

---

# 19. Definition of Done

Una tarea solo podrá marcarse como terminada cuando:

- Arquitectura validada.
- Código funcional.
- Validaciones PASS.
- Sin deuda técnica conocida.
- Documentación actualizada (si aplica).
- Commit preparado.
- ADR generado (si aplica).

---

# 20. Estilo de Respuesta Esperado

Cuando se solicite una solución técnica:

1. Analizar.
2. Explicar la causa.
3. Proponer la solución mínima.
4. Validar.
5. Resumir los cambios.

Evitar cambios especulativos.

No asumir.

Basar las decisiones en evidencia.

---

# 21. Filosofía del Proyecto

NX Platform prioriza:

- Arquitectura sobre rapidez.
- Evidencia sobre suposición.
- Simplicidad sobre complejidad.
- Mantenibilidad sobre soluciones temporales.
- Calidad sobre cantidad de código.

Cada cambio debe dejar el proyecto en un estado igual o mejor al recibido.

---

# Historial

| Versión | Fecha | Descripción |
|----------|--------|-------------|
| 1.0 | 2026-07-21 | Consolidación de las reglas permanentes derivadas del Sprint K1.2 |

---

# Estado

**ACTIVE**

Estas instrucciones constituyen la guía permanente para GitHub Copilot durante el desarrollo de NX Platform y deberán evolucionar conforme madure la arquitectura del proyecto.