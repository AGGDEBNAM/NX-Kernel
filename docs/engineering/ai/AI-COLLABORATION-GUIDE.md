# AI Collaboration Guide

> **Proyecto:** NX Platform Kernel  
> **Ubicación recomendada:** `docs/engineering/AI-COLLABORATION-GUIDE.md`

---

# Objetivo

Este documento define la metodología oficial para colaborar con asistentes de Inteligencia Artificial durante el desarrollo de NX Platform.

Su propósito es garantizar que cualquier IA (GitHub Copilot, ChatGPT, Claude Code, Cursor, Gemini u otra) produzca resultados consistentes, verificables y alineados con los estándares de ingeniería del proyecto.

Este documento complementa:

- `.github/copilot-instructions.md`
- Engineering Handbook
- ADRs
- Engineering Notes

---

# Filosofía

La Inteligencia Artificial es una herramienta de ingeniería.

No reemplaza el criterio técnico del equipo.

Toda respuesta generada por una IA deberá ser considerada una propuesta hasta que exista evidencia suficiente para aceptarla.

La IA asiste.

La ingeniería decide.

---

# Principios Fundamentales

Toda colaboración con IA deberá respetar los siguientes principios.

## 1. Evidencia antes que opinión

Nunca aceptar una recomendación únicamente porque la IA la propone.

Toda afirmación técnica deberá estar respaldada por evidencia.

Ejemplos:

- código fuente
- pruebas
- ejecución
- logs
- documentación
- comportamiento reproducible

---

## 2. Separar hechos de hipótesis

Toda investigación debe distinguir claramente entre:

### Hechos

Información demostrada.

Ejemplo:

```
Get-Command New-NXContext devuelve vacío.
```

---

### Hipótesis

Explicaciones posibles.

Ejemplo:

```
Podría tratarse de un problema de Module Scope.
```

---

### Conclusiones

Solo podrán emitirse cuando exista evidencia suficiente.

---

# Flujo Oficial de Investigación

Toda investigación seguirá el siguiente proceso.

```text
Problema

↓

Recopilar Evidencia

↓

Formular Hipótesis

↓

Validar Hipótesis

↓

Encontrar Causa Raíz

↓

Diseñar Solución

↓

Aplicar Corrección Mínima

↓

Validar

↓

Documentar

↓

Cerrar Incidente
```

Nunca alterar este orden.

---

# Regla de Oro

No modificar código hasta conocer la causa raíz.

---

# Ingeniería Basada en Evidencia

La IA deberá responder utilizando evidencia concreta.

Se deberá solicitar siempre:

- archivos
- funciones
- llamadas
- stack trace
- logs
- resultados de pruebas
- comportamiento reproducible

Nunca aceptar respuestas basadas únicamente en deducciones.

---

# Minimal Reproducible Example (MRE)

Antes de aceptar una corrección importante deberá existir un MRE.

El MRE debe:

- reproducir el problema
- ser pequeño
- ser independiente
- demostrar la causa

---

# Corrección Mínima

La primera solución siempre deberá ser la de menor impacto.

Orden recomendado:

```
Minimal Fix

↓

Validación

↓

Refactor

↓

Optimización
```

Nunca realizar el proceso inverso.

---

# Cuándo Refactorizar

Un refactor solo deberá proponerse cuando:

- el problema esté completamente entendido;
- la causa raíz haya sido demostrada;
- exista una mejora arquitectónica clara;
- el cambio reduzca deuda técnica.

---

# Cambios Arquitectónicos

Cuando una investigación revele una mejora de arquitectura:

No aplicar inmediatamente.

Primero:

1. analizar alternativas;
2. evaluar ventajas y desventajas;
3. justificar la decisión;
4. documentar mediante un ADR;
5. implementar.

---

# Uso de Copilot

GitHub Copilot deberá utilizarse para:

- generación de código;
- navegación del proyecto;
- búsqueda rápida;
- implementación controlada;
- refactorizaciones pequeñas.

No deberá utilizarse como única fuente para decisiones arquitectónicas.

---

# Uso de ChatGPT

ChatGPT deberá utilizarse para:

- análisis profundo;
- revisión de arquitectura;
- diseño de soluciones;
- documentación;
- generación de ADR;
- Engineering Notes;
- definición de estándares;
- planificación de Sprints;
- revisión técnica.

---

# División de Responsabilidades

## Copilot

Especializado en:

- implementación;
- edición;
- navegación;
- generación inmediata.

---

## ChatGPT

Especializado en:

- arquitectura;
- ingeniería;
- documentación;
- revisión crítica;
- planeación.

---

# Validación Cruzada

Para cambios importantes se recomienda:

```
Copilot

↓

Implementa

↓

ChatGPT

↓

Revisa

↓

Copilot

↓

Corrige

↓

ChatGPT

↓

Aprueba
```

---

# Criterios para Aceptar una Respuesta de IA

Una respuesta podrá aceptarse cuando:

- exista evidencia;
- la solución sea consistente;
- respete la arquitectura;
- pase las validaciones;
- no introduzca deuda técnica.

---

# Criterios para Rechazar una Respuesta

Rechazar inmediatamente respuestas que:

- asuman información;
- modifiquen arquitectura sin justificación;
- mezclen varias soluciones;
- oculten errores;
- no puedan demostrarse.

---

# Preguntas Recomendadas Durante una Investigación

Antes de modificar código, preguntar:

- ¿Qué evidencia existe?
- ¿Cuál es la causa raíz?
- ¿Existe un MRE?
- ¿Hay otras alternativas?
- ¿Qué impacto tiene el cambio?
- ¿Rompe la arquitectura?
- ¿Se puede validar?
- ¿Debe documentarse?

---

# Definición de Evidencia

Se considera evidencia válida:

- pruebas exitosas;
- stack traces;
- logs;
- ejecución reproducible;
- código fuente;
- documentación oficial;
- comportamiento observado.

No se considera evidencia:

- opiniones;
- intuiciones;
- respuestas no verificadas.

---

# Gestión de Documentación

Después de resolver un incidente evaluar si requiere:

## ADR

Cuando cambia la arquitectura.

---

## Engineering Note

Cuando se descubre una lección técnica reutilizable.

---

## Handbook

Cuando cambia una práctica permanente.

---

## Sprint Closure

Cuando finaliza un Sprint.

---

# Calidad del Código

Toda IA deberá priorizar:

- claridad;
- mantenibilidad;
- simplicidad;
- modularidad;
- legibilidad.

El código debe poder entenderse sin necesidad de la conversación que lo originó.

---

# Comunicación

Las respuestas técnicas deberán seguir este formato:

## 1.

Resumen.

---

## 2.

Evidencia.

---

## 3.

Análisis.

---

## 4.

Opciones.

---

## 5.

Recomendación.

---

## 6.

Plan de implementación.

---

## 7.

Validación.

---

# Definition of Done

Una tarea solo podrá considerarse terminada cuando:

- el problema tenga causa raíz identificada;
- exista evidencia suficiente;
- el código compile;
- todas las pruebas sean satisfactorias;
- la arquitectura permanezca consistente;
- la documentación requerida haya sido actualizada.

---

# Mejora Continua

Después de cada Sprint se deberá evaluar:

- nuevas reglas aprendidas;
- errores recurrentes;
- mejoras al proceso;
- ajustes al handbook;
- actualizaciones a `copilot-instructions.md`;
- nuevas Engineering Notes.

La experiencia obtenida deberá convertirse en conocimiento permanente del proyecto.

---

# Relación con otros documentos

- `.github/copilot-instructions.md`
- `ENG-004 — PowerShell Engineering Guidelines`
- `ADR-*`
- `EN-*`
- `Sprint Closure Reports`

---

# Historial

| Versión | Fecha | Descripción |
|----------|--------|-------------|
| 1.0 | 2026-07-21 | Creación del estándar de colaboración con IA para NX Platform. Basado en las prácticas consolidadas durante el Sprint K1.2. |

---

# Estado

**ACTIVE**

Este documento establece la metodología oficial de colaboración entre el equipo de ingeniería y los asistentes de Inteligencia Artificial utilizados durante el desarrollo de NX Platform.

Todo nuevo Sprint deberá seguir estas directrices y actualizar este documento cuando se incorporen nuevas prácticas o lecciones de ingeniería.