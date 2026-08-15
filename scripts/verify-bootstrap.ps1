# verify-bootstrap.ps1 — acceptance check for a cdev bootstrap output.
# Usage: powershell -ExecutionPolicy Bypass -File verify-bootstrap.ps1 -Target <repoDir>
param([Parameter(Mandatory)][string]$Target)

$ErrorActionPreference = 'Stop'
$fail = $false

function Fail($m) { Write-Host "FAIL: $m" -ForegroundColor Red; $script:fail = $true }
function Ok($m)   { Write-Host "OK:   $m" -ForegroundColor Green }

# 1. Required files exist — the core artifact set (doc 07 §1.2). Everything else
#    (TESTING, RUNBOOK, night-runner, reviewer agents, per-repo skills) is optional.
$required = @(
  'CLAUDE.md',
  'docs/develop/RECOGNITION.md',
  'docs/develop/AGENT_EXECUTION_PROTOCOL.md',
  'docs/develop/SPRINTS.md',
  'docs/develop/AGENT_PROGRESS.md',
  'docs/develop/PRODUCT.md',
  'docs/develop/DECISIONS.md'
)
foreach ($r in $required) {
  if (Test-Path (Join-Path $Target $r)) { Ok "exists $r" } else { Fail "missing $r" }
}

# 2. No unresolved {{ placeholders }} anywhere in the rendered output.
$leftover = Get-ChildItem -Path $Target -Recurse -File -Include *.md,*.ps1,*.txt -ErrorAction SilentlyContinue |
  Where-Object { $_.FullName -notmatch '\\\.claude\\skills\\|cdev-bootstrap|node_modules' } |
  Select-String -Pattern '\{\{' -List
if ($leftover) { $leftover | ForEach-Object { Fail "unresolved placeholder in $($_.Path)" } }
else { Ok 'no unresolved {{ }} placeholders' }

# 3. Exactly one ACTIVE sprint, and a READY batch present.
$sprints = Join-Path $Target 'docs/develop/SPRINTS.md'
if (Test-Path $sprints) {
  $active = (Select-String -Path $sprints -Pattern '^Status:\s*ACTIVE' -AllMatches).Count
  if ($active -eq 1) { Ok 'exactly one Status: ACTIVE sprint' } else { Fail "expected 1 ACTIVE sprint, found $active" }
  if (Select-String -Path $sprints -Pattern '^Status:\s*READY' -Quiet) { Ok 'a READY batch exists' } else { Fail 'no READY batch' }
}

if ($fail) { Write-Host 'BOOTSTRAP VERIFY: FAIL' -ForegroundColor Red; exit 1 }
Write-Host 'BOOTSTRAP VERIFY: PASS' -ForegroundColor Green; exit 0
