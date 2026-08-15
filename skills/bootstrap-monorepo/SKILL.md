---
name: bootstrap-monorepo
description: Úsala cuando haya que condicionar una carpeta que contiene varios repos Git autónomos (cada uno con su CDev propio) como workspace orquestador CDev Monorepo — crear el andamiaje global (CLAUDE.md, docs/develop/, workspace/, agentes, scripts, git propio del workspace) sin tocar los repos hijos, o cuando el usuario pida "bootstrap monorepo", "condicionar workspace multi-repo" o montar orquestación sobre repos existentes.
---

# Bootstrap Monorepo (CDev)

Condiciona un **workspace multi-repo** (coloquialmente "monorepo") como capa orquestadora CDev.
No fusiona los repos en un solo Git ni sustituye su CDev local. Principio rector:

> **El workspace gobierna la coordinación. Cada repositorio gobierna su implementación.**

La unidad de coordinación es el **repositorio**, no la tecnología ni el target. Un repo con
web+mobile dentro es UNA unidad; su paridad interna es asunto de su CDev local. El workspace
nunca crea agentes por tecnología ("backend agent", "Next runner"): las diferencias de rol las
absorbe el `/cdev` local de cada repo (dispatcher → `cdev-backend`/`cdev-frontend`).

## Fase A — Descubrimiento

1. Raíz del workspace = cwd. Detecta repos Git hijos (dirs con `.git/`), estén en raíz directa
   o bajo `repos/` — **el layout real manda, no se mueven repos**. Admite registrar paths
   externos que el usuario indique.
2. Por repo: branch actual, origin, SHA HEAD, sprint local activo (de su `SPRINTS.md`).

## Fase B — Auditoría CDev por repo

Comprueba: `CLAUDE.md` · `docs/develop/SPRINTS.md` · `AGENT_EXECUTION_PROTOCOL.md` ·
`AGENT_PROGRESS.md`. Clasifica:

- `CDEV_READY` — todo presente.
- `CDEV_PARTIAL` — falta algo no crítico (p.ej. CLAUDE.md raíz). Se registra el gap en el
  DECISIONS del workspace; no bloquea el bootstrap.
- `NOT_CONDITIONED` — sin `docs/develop/`. Blocker: recomienda `bootstrap-backend` /
  `bootstrap-frontend` / `cdev-bootstrap` según rol y reanuda cuando esté condicionado.
  **El bootstrap global jamás inventa el CDev de un hijo.**

## Fase C — Mapa del sistema

Deriva de los `CLAUDE.md`/`PRODUCT.md` hijos: responsabilidad de cada repo, dependencias entre
repos (quién consume a quién), dominios cruzados, contratos conocidos. Genera:

- `workspace/repos.yaml` — registro: id lógico → path, git, estado cdev, rol informativo.
  Los stacks son metadata, no reglas; la autoridad operativa sigue siendo el CLAUDE.md hijo.
- `workspace/repo-graph.yaml` — `depends_on` + `domains`. Informa la planificación; **no**
  define participación en batches (eso lo hacen las referencias explícitas de cada
  SYSTEM_BATCH).
- `docs/develop/SYSTEM_ARCHITECTURE.md` — nodos, flechas, contratos.

## Fase D — Andamiaje

Genera en la raíz del workspace:

```text
CLAUDE.md                            # pequeño: coordinación, no duplica docs hijos
docs/develop/
├── PRODUCT.md                       # sistema completo + mapa de claridad global
├── SYSTEM_ARCHITECTURE.md
├── SPRINTS.md                       # SYSTEM Sprints / SYSTEM_BATCHes (numeración propia)
├── AGENT_PROGRESS.md                # handoff de coordinación, no diffs de código
├── AGENT_EXECUTION_PROTOCOL.md      # deltas locales; el bucle genérico vive en cdev-monorepo
├── ROADMAP.md
├── DECISIONS.md
├── TESTING.md                       # niveles L0–L3; cada batch declara el suyo
└── AUTONOMOUS_RUNBOOK.md            # cómo lanzar y qué esperar
workspace/
├── repos.yaml
├── repo-graph.yaml
├── state.lock.json                  # snapshot reproducible del estado coordinado
├── contracts/                       # contratos cross-repo por SYSTEM_BATCH
└── snapshots/
.claude/agents/
├── monorepo-repo-runner.md          # puente workspace → /cdev del repo
└── monorepo-system-tester.md        # acceptance global L0–L3
scripts/verify-monorepo-bootstrap.ps1
```

La planificación NO es agente local: es la skill global `cdev-monorepo-planner`. Las skills
`cdev-monorepo` y `cdev-monorepo-planner` permanecen globales — no se vendorizan copias.

Contenido mínimo de cada doc: seguir el patrón de los repos hijos ya condicionados; ante duda,
usar un workspace ya montado (p.ej. `compiss/monorepo`) como referencia canónica.

## Fase E — Git del workspace

Si la raíz no es repo: `git init`. `.gitignore` excluye **cada path de repo registrado** (los
`.git` hijos jamás se anidan), más `worktrees/` y `logs/runs/`. Sin `origin` por defecto; el
git del workspace versiona solo planificación/contratos/estado. Rama de trabajo futura:
`cdev/system-sprint-<n>`. Commit inicial del andamiaje.

## Fase F — Estado inicial

`state.lock.json` con snapshot por repo: branch, SHA, sprint/batch local activo. Es fotografía
informativa; el gate de DONE de un batch solo mira sus referencias requeridas.

## Fase G — Gate humano (único)

Antes de escribir: presenta repos detectados (path, branch, SHA, clasificación CDev), grafo
derivado, archivos a generar y esquema del primer SYSTEM Sprint si se deriva uno. Una
confirmación y renderiza todo. Archivo existente → diff y preguntar, nunca sobrescribir en
silencio. Si el usuario ya aprobó el diseño explícitamente en la conversación, esa aprobación
cuenta como el gate.

## Al terminar

1. Ejecuta `scripts/verify-monorepo-bootstrap.ps1` (paths existen, sin placeholders, ≤1 SYSTEM
   Sprint ACTIVE, referencias apuntan a sprints/batches reales, state.lock parseable, repos no
   versionados por el git padre).
2. Primera entrada en `AGENT_PROGRESS.md` global: bootstrap hecho, siguiente acción =
   `/cdev-monorepo-planner` para derivar el primer SYSTEM Sprint real.
3. Resumen "condicionado — cómo lanzar" apuntando al RUNBOOK.
