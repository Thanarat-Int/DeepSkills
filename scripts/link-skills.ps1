#requires -Version 5
# Links every skill in this repo into ~/.claude/skills as JUNCTIONS, so the local
# Claude Code picks them up in every project. Junctions need no admin rights
# (unlike symlinks), so this works on Windows without Developer Mode.
#
# Usage:  powershell -ExecutionPolicy Bypass -File scripts/link-skills.ps1

$ErrorActionPreference = 'Stop'

$repo = Split-Path -Parent $PSScriptRoot
$dest = Join-Path $HOME '.claude\skills'

# Guard: don't run if ~/.claude/skills is itself a link into this repo.
$destItem = Get-Item -LiteralPath $dest -ErrorAction SilentlyContinue
if ($destItem -and $destItem.LinkType -and $destItem.Target -and ($destItem.Target -join '') -like "$repo*") {
  Write-Error "$dest is a link into this repo. Remove it and re-run."
  exit 1
}

New-Item -ItemType Directory -Force -Path $dest | Out-Null

$skills = Get-ChildItem -Path (Join-Path $repo 'skills') -Recurse -Filter 'SKILL.md' -File |
  Where-Object { $_.FullName -notmatch '\\(node_modules|deprecated|in-progress|personal)\\' }

$count = 0
foreach ($s in $skills) {
  $src    = $s.Directory.FullName
  $name   = $s.Directory.Name
  $target = Join-Path $dest $name

  if (Test-Path -LiteralPath $target) {
    # rmdir removes a junction without touching its target; fall back to Remove-Item.
    cmd /c rmdir "$target" 2>$null
    if (Test-Path -LiteralPath $target) { Remove-Item -LiteralPath $target -Recurse -Force }
  }

  New-Item -ItemType Junction -Path $target -Target $src | Out-Null
  Write-Host "linked $name -> $src"
  $count++
}

Write-Host ""
Write-Host "Done. $count skills linked into $dest"
