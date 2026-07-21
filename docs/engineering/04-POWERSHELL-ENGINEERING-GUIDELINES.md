# ENG-004 — PowerShell Engineering Guidelines

| Campo | Valor |
|-------|--------|
| **Documento** | ENG-004 |
| **Título** | PowerShell Engineering Guidelines |
| **Versión** | 2.0 |
| **Estado** | Active |
| **Última actualización** | 2026-07-21 |
| **Proyecto** | NX Platform Kernel |

---

# Objetivo

Definir los estándares oficiales de desarrollo para todos los componentes PowerShell de **NX Platform**, asegurando consistencia, mantenibilidad y una arquitectura escalable.

Estas directrices son obligatorias para cualquier contribución al proyecto.

---

# 1. Entorno de Desarrollo

## Versión de PowerShell

Todo el desarrollo deberá realizarse utilizando:

```text
PowerShell 7.x (pwsh)
```

No se admite el uso de:

- Windows PowerShell 5.1
- powershell.exe

Todas las pruebas deberán ejecutarse mediante:

```powershell
pwsh -NoProfile
```

---

# 2. Arquitectura

NX Platform adopta una arquitectura basada en:

- Composition Root
- Dependency Injection
- Modularización
- Service Registry
- Bootstrap Lifecycle

Todo nuevo desarrollo deberá respetar estos principios.

---

# 3. Composition Root

Existe un único Composition Root.

```text
NX.psm1
```

Responsabilidades:

- Construir el grafo de dependencias.
- Crear servicios.
- Registrar servicios.
- Resolver dependencias.
- Iniciar el Kernel.

Ningún otro módulo deberá asumir estas responsabilidades.

---

# 4. Dependency Injection

Las dependencias deberán recibirse explícitamente.

Ejemplo correcto:

```powershell
Start-NXKernel `
    -Context $Context `
    -Command $Command
```

Ejemplo incorrecto:

```powershell
New-NXContext
```

dentro del Kernel.

---

# 5. Responsabilidad de los Módulos

## NX.psm1

Debe:

- Crear servicios.
- Registrar servicios.
- Configurar Bootstrap.
- Construir el Runtime.

No debe:

- Implementar lógica de negocio.

---

## Kernel.psm1

Debe:

- Ejecutar comandos.
- Coordinar la ejecución.

No debe:

- Crear servicios.
- Importar dependencias internas.
- Resolver dependencias.

---

## Servicios

Cada servicio debe encargarse únicamente de su dominio.

Ejemplos:

- Context
- Logger
- Configuration
- Runtime

Los servicios no deben conocer entre sí su proceso de construcción.

---

# 6. Registro de Servicios

Todo servicio compartido deberá registrarse durante Bootstrap.

Ejemplo:

```powershell
Register-NXService `
    -Name "Logger" `
    -Instance $loggerService
```

Nunca deberá registrarse desde Kernel.

---

# 7. Convenciones de Código

## Variables

Utilizar nombres descriptivos.

Correcto:

```powershell
$runtimeContext

$configurationService

$loggerService
```

Incorrecto:

```powershell
$obj

$temp

$x
```

---

## Funciones

Las funciones deberán realizar una única tarea.

Evitar funciones excesivamente largas.

Si una función supera aproximadamente 80–100 líneas, evaluar dividir responsabilidades.

---

## Comentarios

Documentar únicamente decisiones de diseño.

No comentar código evidente.

---

# 8. Objetos Complejos

No utilizar expresiones complejas directamente como parámetros.

Incorrecto:

```powershell
Register-NXService `
    -Instance [PSCustomObject]@{}
```

Correcto:

```powershell
$service = [PSCustomObject]@{}

Register-NXService `
    -Instance $service
```

---

# 9. Módulos

Cada módulo deberá:

- Tener una responsabilidad clara.
- Exportar únicamente la API pública.
- Ocultar implementación interna.
- Evitar dependencias circulares.

---

# 10. Flujo de Ingeniería

Todo cambio deberá seguir obligatoriamente este proceso.

## Paso 1

Recopilar evidencia.

Nunca asumir.

---

## Paso 2

Formular hipótesis.

Las hipótesis deberán ser verificables.

---

## Paso 3

Validar mediante pruebas.

Preferentemente utilizando un MRE
(Minimal Reproducible Example).

---

## Paso 4

Aplicar la corrección mínima necesaria.

No introducir refactorizaciones innecesarias.

---

## Paso 5

Validar nuevamente.

Toda corrección deberá reproducir el escenario original.

---

## Paso 6

Documentar.

Registrar únicamente cuando la causa raíz haya sido confirmada.

---

# 11. Validaciones Obligatorias

Antes de cerrar cualquier Sprint deberán ejecutarse, como mínimo:

```powershell
Import-Module .\NX.psm1 -Force

.\nx.ps1 version

.\nx.ps1 context

Start-NX -Command version

Start-NX -Command context
```

Todos los resultados deberán ser:

```text
PASS
```

---

# 12. Definition of Done

Una tarea sólo podrá considerarse finalizada cuando:

- El código compile correctamente.
- No existan errores de ejecución.
- Las validaciones sean satisfactorias.
- No existan dependencias implícitas.
- Se respete la arquitectura.
- La documentación requerida haya sido actualizada.

---

# 13. Gestión de Incidentes

Todo incidente relevante deberá seguir el flujo:

```text
Incidente

↓

Investigación

↓

Evidencia

↓

Hipótesis

↓

Validación

↓

Corrección

↓

Revalidación

↓

Documentación

↓

Cierre
```

Nunca invertir este orden.

---

# 14. Gestión de Decisiones Arquitectónicas

Toda decisión que modifique la arquitectura deberá registrarse mediante un ADR.

Ejemplos:

- Cambios en Composition Root.
- Cambios en Dependency Injection.
- Ciclo de vida de servicios.
- Arquitectura modular.

---

# 15. Engineering Notes

Toda lección técnica reutilizable deberá documentarse mediante una Engineering Note.

Ejemplos:

- Comportamientos específicos de PowerShell.
- Limitaciones del lenguaje.
- Problemas recurrentes.
- Buenas prácticas derivadas de incidentes reales.

---

# 16. Principios Rectores

Todo desarrollo de NX Platform deberá cumplir los siguientes principios:

- Simplicidad.
- Bajo acoplamiento.
- Alta cohesión.
- Dependencias explícitas.
- Código legible.
- Arquitectura consistente.
- Correcciones mínimas.
- Evidencia antes de modificar.
- Documentación como parte del desarrollo.

---

# Referencias

- ADR-0002 — Context Lifecycle Owned by Composition Root
- EN-0001 — PowerShell Parameter Binding con PSCustomObject
- Sprint K1.2 Closure
- `.github/copilot-instructions.md`

---

# Historial de Cambios

| Versión | Fecha | Descripción |
|----------|--------|-------------|
| 1.0 | Inicio del proyecto | Definición inicial del estándar |
| 2.0 | 2026-07-21 | Incorporación de reglas derivadas del Sprint K1.2, Dependency Injection, Composition Root, flujo de ingeniería y validaciones obligatorias |

---

# Estado

**ACTIVE**

Este documento constituye el estándar oficial de ingeniería para todos los desarrollos PowerShell dentro de NX Platform y deberá revisarse al cierre de cada Sprint cuando se incorporen nuevas prácticas o decisiones arquitectónicas relevantes.