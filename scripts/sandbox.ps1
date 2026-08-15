<#
.SYNOPSIS
  Create a throwaway repository to exercise the skills without touching anything real.

.DESCRIPTION
  Builds sandbox/<Name>/ : a tiny fake repo (git, manifest, one source file) plus a product
  doc written so the clarity map has one DEFINED area, one PARTIAL and one ABSENT — the case
  worth debugging.

  The fixture's .claude/skills is a junction to this repo's skills/, so a Claude Code session
  opened inside the fixture loads the skills you are editing, live. No copy, no drift, and the
  global ~/.claude/skills is never touched.

  sandbox/ is gitignored: fixtures are disposable, recreate them instead of repairing them.

.EXAMPLE
  ./scripts/sandbox.ps1                          # backend fixture named "demo"
  ./scripts/sandbox.ps1 -Name web -Role frontend
  ./scripts/sandbox.ps1 -Name demo -Force        # wipe and recreate
#>
[CmdletBinding()]
param(
  [string]$Name = 'demo',
  [ValidateSet('backend', 'frontend')][string]$Role = 'backend',
  [switch]$Force
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$skills = Join-Path $repoRoot 'skills'
$box = Join-Path $repoRoot "sandbox\$Name"

if (Test-Path $box) {
  if (-not $Force) { throw "$box already exists. Re-run with -Force to wipe and recreate." }
  # The junction goes first: removing it as a plain directory would walk into skills/.
  $link = Join-Path $box '.claude\skills'
  if (Test-Path $link) { (Get-Item $link -Force).Delete() }
  Remove-Item $box -Recurse -Force
}

New-Item -ItemType Directory -Path $box -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $box 'docs') -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $box '.claude') -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $box 'src') -Force | Out-Null

# --- fake product doc: deliberately uneven, so conditioning has something real to score ---
@"
# Bookmarks — product notes

A service where a person saves links and tags them. Nothing else.

## Saving a link
A link is a URL plus an optional title. Saving the same URL twice updates the existing entry
instead of creating a second one. A link always belongs to exactly one person, and a person
only ever sees their own. Deleting a link is permanent and needs no confirmation.

## Tags
Tags are free text, lowercase, no spaces. A link can carry several. Listing links filtered by
tag must be possible. Whether tags are shared between people, renamed, or merged: undecided.

## Sharing
Eventually people should be able to share a collection. Not specified yet.
"@ | Set-Content -Path (Join-Path $box 'docs\product.md') -Encoding utf8

if ($Role -eq 'backend') {
  @"
{
  "name": "sandbox-bookmarks-api",
  "private": true,
  "scripts": {
    "lint": "echo lint ok",
    "build": "echo build ok",
    "test": "echo no tests yet && exit 1"
  }
}
"@ | Set-Content -Path (Join-Path $box 'package.json') -Encoding utf8
  # `test` fails on purpose: a backend with no real test gate is not conditioned, and the
  # conditioning skill is supposed to notice.
  'export function saveLink(url) { return { url } }' |
    Set-Content -Path (Join-Path $box 'src\links.js') -Encoding utf8
} else {
  @"
{
  "name": "sandbox-bookmarks-web",
  "private": true,
  "scripts": {
    "dev": "echo dev server on :4000",
    "build": "echo build ok",
    "typecheck": "echo typecheck ok"
  }
}
"@ | Set-Content -Path (Join-Path $box 'package.json') -Encoding utf8
  'export function LinkList() { return null }' |
    Set-Content -Path (Join-Path $box 'src\link-list.js') -Encoding utf8
}

@"
node_modules/
.claude/skills
"@ | Set-Content -Path (Join-Path $box '.gitignore') -Encoding utf8

New-Item -ItemType Junction -Path (Join-Path $box '.claude\skills') -Target $skills | Out-Null

Push-Location $box
git init -q
git add -A
git -c user.name=sandbox -c user.email=sandbox@local commit -qm 'sandbox fixture'
git branch -q -M main
git checkout -q -b develop
Pop-Location

Write-Output ""
Write-Output "Sandbox ready: $box  (role: $Role)"
Write-Output "  skills   -> junction to $skills (edit there, it is live here)"
Write-Output "  fixture  -> package.json, src/, docs/product.md, git with main + develop"
Write-Output ""
Write-Output "Open a Claude Code session with that folder as its working directory, then try"
Write-Output "the instruction you want to debug. Recreate anytime with -Force; never repair it."
