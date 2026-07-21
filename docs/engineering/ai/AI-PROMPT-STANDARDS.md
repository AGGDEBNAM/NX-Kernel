# AI Prompt Standards

> **Proyecto:** NX Platform Kernel  
> **Ubicación recomendada:** `docs/engineering/ai/AI-PROMPT-STANDARDS.md`

---

# Objetivo

Este documento define el estándar para redactar prompts dirigidos a asistentes de Inteligencia Artificial durante el desarrollo de NX Platform.

Su finalidad es obtener respuestas consistentes, reproducibles y alineadas con la arquitectura y los procesos de ingeniería del proyecto.

---

# Principios

Todo prompt debe cumplir los siguientes principios:

- Ser específico.
- Proporcionar contexto suficiente.
- Definir claramente el objetivo.
- Establecer restricciones.
- Definir el resultado esperado.
- Solicitar evidencia cuando corresponda.

Evitar prompts ambiguos o abiertos.

---

# Estructura Oficial

Todo prompt técnico deberá seguir esta estructura.

```text
Contexto

↓

Estado actual

↓

Objetivo

↓

Restricciones

↓

Tareas

↓

Validación

↓

Formato de salida esperado
```

---

# Plantilla General

```text
# Context

Describe el módulo y la arquitectura involucrada.

# Current State

Explica el estado actual del proyecto.

# Objective

Describe exactamente qué debe lograrse.

# Constraints

Indica qué NO debe hacerse.

# Tasks

Enumera las actividades.

# Validation

Define cómo verificar el resultado.

# Output

Especifica exactamente qué debe devolver la IA.
```

---

# Estándares por Tipo de Trabajo

## Implementación

Siempre indicar:

- módulo afectado;
- objetivo;
- dependencias involucradas;
- restricciones;
- pruebas a ejecutar.

---

## Investigación

Solicitar únicamente evidencia.

Ejemplo:

```text
Do not modify code.

Return only evidence.

Identify:

- implementation
- call stack
- imports
- exports
- runtime behavior
```

---

## Depuración

Solicitar:

- causa raíz;
- evidencia;
- MRE;
- solución mínima.

Nunca pedir una corrección antes del análisis.

---

## Refactorización

Incluir siempre:

- motivo;
- beneficios;
- impacto;
- compatibilidad;
- validación.

---

## Arquitectura

Solicitar:

- alternativas;
- ventajas;
- desventajas;
- recomendación;
- impacto.

No pedir implementación hasta aprobar la decisión.

---

# Restricciones Obligatorias

Cuando aplique, incluir restricciones explícitas.

Ejemplos:

```text
Do not modify architecture.

Do not redesign modules.

Do not introduce global state.

Do not expose internal services.

Do not create service locators.

Do not generate documentation.

Stop after validation.
```

---

# Solicitud de Evidencia

Cuando se investigue un problema, utilizar instrucciones similares a:

```text
Return only evidence.

Do not speculate.

Do not infer.

Do not modify code.

Show implementation.

Show runtime behavior.

Show stack trace.

Show module resolution.
```

---

# Solicitud de Validación

Toda implementación debe finalizar con validaciones explícitas.

Ejemplo:

```powershell
Import-Module .\NX.psm1 -Force

.\nx.ps1 version

.\nx.ps1 context

Start-NX -Command version

Start-NX -Command context
```

Solicitar que el resultado se reporte como:

```text
PASS / FAIL
```

---

# Formato de Salida Esperado

Siempre que sea posible, pedir un formato estructurado.

Ejemplo:

```text
1. Files modified

2. Architecture changes

3. Validation results

4. Remaining issues
```

---

# Uso de Roles

Asignar un rol claro a la IA mejora la calidad de la respuesta.

Ejemplos:

- Senior Software Engineer
- Software Architect
- PowerShell Expert
- Platform Engineer
- Technical Reviewer

---

# Prompt para Implementación

```text
Implement the approved solution.

Respect the existing architecture.

Apply the minimal change required.

Do not introduce unrelated modifications.

Validate the implementation.

Return only modified files, validation results and remaining issues.
```

---

# Prompt para Investigación

```text
Do not modify code.

Collect evidence only.

Identify:

- implementation
- imports
- exports
- runtime behavior
- stack trace

Separate facts from hypotheses.
```

---

# Prompt para Revisión Arquitectónica

```text
Review the current architecture.

Identify design issues.

Evaluate alternatives.

Recommend the best option.

Do not implement changes.
```

---

# Prompt para Documentación

```text
Generate professional Markdown documentation.

Use project standards.

Do not invent information.

Base the document on validated engineering decisions.
```

---

# Buenas Prácticas

- Un objetivo por prompt.
- Separar investigación de implementación.
- Separar implementación de documentación.
- Solicitar validaciones explícitas.
- Evitar múltiples cambios no relacionados en una sola petición.

---

# Errores Comunes

Evitar prompts que:

- mezclen análisis e implementación;
- pidan refactorizar sin evidencia;
- no definan restricciones;
- no indiquen cómo validar el resultado;
- no especifiquen el formato esperado.

---

# Flujo Recomendado con IA

```text
Investigación

↓

Evidencia

↓

Análisis

↓

Decisión

↓

Implementación

↓

Validación

↓

Documentación
```

---

# Relación con otros documentos

- `.github/copilot-instructions.md`
- `AI-COLLABORATION-GUIDE.md`
- `ENG-004 — PowerShell Engineering Guidelines`
- `ADR-*`
- `EN-*`

---

# Historial

| Versión | Fecha | Descripción |
|----------|--------|-------------|
| 1.0 | 2026-07-21 | Definición del estándar de elaboración de prompts para asistentes de IA en NX Platform. |

---

# Estado

**ACTIVE**

Este documento establece el estándar oficial para la creación de prompts utilizados por el equipo de ingeniería durante el desarrollo de NX Platform, buscando obtener respuestas consistentes, verificables y alineadas con la arquitectura del proyecto.