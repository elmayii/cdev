<#
.SYNOPSIS
  Install the skills from this repository into ~/.claude/skills, replacing what is there.

.DESCRIPTION
  This is the "installable package" step: a plain copy, on purpose. Once installed, the skills
  you run are a snapshot — editing this repository afterwards changes nothing until you install
  again. That is the point: you develop against the sandbox and use a fixed version for real work.

  Only the skills this repository ships are replaced. Anything else already in ~/.claude/skills
  is left alone. Whatever is replaced is backed up first, and the restore command is printed.

.EXAMPLE
  ./scripts/install.ps1 -DryRun    # show what would change
  ./scripts/install.ps1            # install, backing up what it replaces
#>
[CmdletBinding()]
param(
  [switch]$DryRun,
  [string]$Destination = (Join-Path $HOME '.claude\skills')
)

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$source = Join-Path $repoRoot 'skills'

if (-not (Test-Path $source)) { throw "No skills/ directory in $repoRoot" }
$packages = Get-ChildItem $source -Directory
if (-not $packages) { throw "skills/ is empty" }

Write-Output "source      : $source"
Write-Output "destination : $Destination"
Write-Output ""

$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
$backup = Join-Path $repoRoot ".backups\skills-$stamp"
$replacing = @()

foreach ($p in $packages) {
  $target = Join-Path $Destination $p.Name
  if (Test-Path $target) {
    # A junction from an earlier setup would make "replace" mean "write into the repo".
    $item = Get-Item $target -Force
    if ($item.LinkType) { throw "$target is a $($item.LinkType) -> $($item.Target). Remove it before installing." }
    $replacing += $p.Name
    Write-Output "  replace  $($p.Name)"
  } else {
    Write-Output "  add      $($p.Name)"
  }
}

if ($DryRun) {
  Write-Output ""
  Write-Output "Dry run: nothing written."
  if ($replacing) { Write-Output "$($replacing.Count) existing skill(s) would be backed up to .backups/" }
  return
}

if (-not (Test-Path $Destination)) { New-Item -ItemType Directory -Path $Destination -Force | Out-Null }

if ($replacing) {
  New-Item -ItemType Directory -Path $backup -Force | Out-Null
  foreach ($name in $replacing) {
    Copy-Item (Join-Path $Destination $name) -Destination $backup -Recurse -Force
  }
  Write-Output ""
  Write-Output "backed up   : $backup"
}

foreach ($p in $packages) {
  $target = Join-Path $Destination $p.Name
  if (Test-Path $target) { Remove-Item $target -Recurse -Force }
  Copy-Item $p.FullName -Destination $Destination -Recurse -Force
}

$installed = (Get-ChildItem $source -Directory).Count
Write-Output ""
Write-Output "Installed $installed skill(s). Restart Claude Code to pick them up."
if ($replacing) {
  Write-Output "Undo: Copy-Item '$backup\*' -Destination '$Destination' -Recurse -Force"
}
