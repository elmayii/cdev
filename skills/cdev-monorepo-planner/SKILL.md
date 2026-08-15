---
name: cdev-monorepo-planner
description: Úsala cuando haya que planificar trabajo cross-repo en un workspace CDev Monorepo — convertir un objetivo del sistema en SYSTEM_BATCHes con referencias locales reales, o analizar todos los repos para hallar gaps (features a medio integrar, contratos rotos, paridad pendiente) y proponer los siguientes SYSTEM Sprints. También cuando el usuario invoque /cdev-monorepo-planner o pida "planifica el monorepo", "qué falta por integrar".
---

# CDev Monorepo Planner

Cerebro de planificación del workspace. **No implementa código.** Dos modos según lo pedido;
sin argumento claro, ejecuta ambos: primero gap-analysis, luego materializa lo aprobado.

## Modo 1 — Materializar un objetivo (objetivo → SYSTEM_BATCH ejecutable)

1. **Define el batch**: `SYS-<sprint>-B<n>` en `SPRINTS.md` global con objetivo observable,
   repos afectados (y explícitamente no afectados si aclara alcance), acceptance global y
   nivel de verificación L0–L3. Nace `PLANNED`.
2. **Lee el CDev local de cada repo afectado** (`SPRINTS.md`, `AGENT_PROGRESS.md`, protocolo):
   sprint activo, batches existentes, bloqueos, orden. **Respeto absoluto al orden local**:
   - trabajo ya existente que coincide → **adoptar** la referencia, no duplicar;
   - cabe en el sprint activo → nuevo batch al final de ese sprint;
   - pertenece a fase posterior → batch en el siguiente sprint local `PENDING` (sin forzarlo
     a `ACTIVE` ni renumerar nada).
3. **Escribe referencias bidireccionales**:
   - workspace: repo / sprint local / batch local / required / depends_on;
   - repo: `System Reference: SYS-XX-BXX` en el batch local + nota en su `AGENT_PROGRESS.md`.
   El repo debe poder continuar solo, sin el workspace abierto.
4. **Contrato cross-repo** si el batch toca una interfaz entre repos:
   `workspace/contracts/SYS-XX-BXX.md` (objetivo, repos, contrato API/datos, compatibilidad,
   orden de implementación, acceptance por repo y global, orden de despliegue). Copia/extracto
   en `docs/develop/external-contracts/` del repo cuando la independencia local lo necesite.
5. **DAG**: `depends_on` entre referencias del batch (solo las del batch). Productor antes que
   consumidor (típico: backend expone → frontend consume).
6. **Sync points (obligatorio en toda dependencia productor→consumidor)**: fija el **artefacto
   concreto** que materializa el handoff — un reporte técnico que el batch productor publica
   como parte de su acceptance (usar la convención de reportes que el repo productor ya tenga;
   si no tiene, `docs/develop/reports/<sprint>-<batch>.md`). Escribe en la referencia
   consumidora la línea `Wait-for: <repo-productor>/<path-del-reporte>`: en ejecución, el
   agente consumidor **irá a buscar** ese archivo (pull, no aviso) y esperará/rotará si no
   existe — así se integra sin mockear el contrato del otro repo. Sin sync point declarado,
   una dependencia cross-repo no está planificada.
7. **Promueve a `READY`** solo cuando toda referencia requerida existe, respeta la secuencia
   local, tiene acceptance suficiente y sus sync points declarados.

Dos numeraciones independientes: SYSTEM Sprint/Batch ≠ sprint/batch local. Nunca igualarlas,
nunca obligar a todos los repos a participar, nunca crear sprints locales espejo.

## Modo 2 — Gap analysis (buscar qué hacer y qué falta por integrar)

Recorre workspace + repos registrados y produce un informe con candidatos accionables:

1. **Integración a medias**: features DONE en un repo cuyo consumidor no las consume aún
   (reportes de sprint del backend vs queries reales del frontend; endpoints expuestos sin UI;
   UI esperando contrato inexistente).
2. **Contratos**: divergencia entre schema/API del productor y tipos/queries de consumidores;
   contratos en `workspace/contracts/` sin reflejar en repos; breaking changes sin batch de
   adopción.
3. **Estado CDev**: repos `CDEV_PARTIAL`/`NOT_CONDITIONED`, repos sin sprint `ACTIVE` (plan
   agotado — candidato natural a siguiente SYSTEM Sprint), bloqueos locales antiguos,
   divergencias workspace↔repo sin reconciliar.
4. **Dominios del grafo**: por cada dominio de `repo-graph.yaml`, ¿los repos del dominio están
   al mismo nivel funcional? Asimetrías = candidatos.
5. **Deuda de coordinación**: batches globales `BLOCKED` con decisión humana pendiente,
   snapshots desactualizados, verificación global nunca corrida.

Salida: tabla candidato → repos → evidencia → propuesta (SYSTEM_BATCH borrador). Los aprobados
entran a `SPRINTS.md` global como `PROPOSAL`/`PLANNED` vía Modo 1. **Los no derivables de
evidencia documental no se inventan**: pregunta abierta en `DECISIONS.md`.

## Reglas

- Fuente de verdad local es el repo; el planner lee, referencia y propone — no marca estados
  locales ni ejecuta trabajo de implementación.
- Todo hallazgo con evidencia (fichero/línea/commit), no impresiones.
- El grafo de dominios sugiere impacto; la participación real la fija cada batch.
- Registrar decisiones de planificación en `DECISIONS.md` global con fecha.
