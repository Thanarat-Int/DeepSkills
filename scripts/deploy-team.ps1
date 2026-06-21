<#
.SYNOPSIS
  Deploy the skill "team" into a target project's .claude\skills\ folder.

.DESCRIPTION
  Copies every shippable skill (each folder containing a SKILL.md, excluding
  the personal / in-progress / deprecated draft buckets) from this repo into
  <TargetProject>\.claude\skills\<skill-name>\ as REAL files, so the whole team
  travels with the project repo. Re-running updates existing skills in place.

  Global install (junctions in ~\.claude\skills) already makes the team available
  in every project automatically — use this script only when you want the team
  committed into a specific project (sharing, another machine, version-locking).

.EXAMPLE
  .\scripts\deploy-team.ps1 -TargetProject 'E:\Projects\my-new-game'
#>
param(
  [Parameter(Mandatory = $true)]
  [string]$TargetProject,
  # Skip writing the team working-agreement block into the project's CLAUDE.md.
  [switch]$SkipDirective
)
$ErrorActionPreference = 'Stop'

$repo       = Split-Path -Parent $PSScriptRoot      # scripts\ -> repo root
$skillsRoot = Join-Path $repo 'skills'
$exclude    = @('personal', 'in-progress', 'deprecated')

if (-not (Test-Path -LiteralPath $TargetProject)) {
  throw "Target project not found: $TargetProject"
}

$dest = Join-Path $TargetProject '.claude\skills'
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$count = 0
Get-ChildItem -LiteralPath $skillsRoot -Recurse -Filter 'SKILL.md' -File | ForEach-Object {
  $skillDir = $_.Directory
  $relative = $skillDir.FullName.Substring($skillsRoot.Length)
  foreach ($e in $exclude) {
    if ($relative -match "[\\/]$e([\\/]|$)") { return }   # skip draft buckets
  }

  $name   = $skillDir.Name
  $target = Join-Path $dest $name
  if (Test-Path -LiteralPath $target) { Remove-Item -LiteralPath $target -Recurse -Force }
  Copy-Item -LiteralPath $skillDir.FullName -Destination $target -Recurse
  Write-Host "deployed $name"
  $count++
}

Write-Host ""
Write-Host "Deployed $count skills to $dest"

# --- Team directive: make the AI follow the workflow proactively (no slash, no prompt) ---
if (-not $SkipDirective) {
  $snippetPath = Join-Path $repo 'templates\CLAUDE-team-snippet.md'
  $snippet = (Get-Content -LiteralPath $snippetPath -Raw).TrimEnd()
  $claude  = Join-Path $TargetProject 'CLAUDE.md'
  $startM  = '<!-- team-skills:start -->'
  $endM    = '<!-- team-skills:end -->'

  if (-not (Test-Path -LiteralPath $claude)) {
    Set-Content -LiteralPath $claude -Value ($snippet + "`n") -Encoding utf8
    Write-Host "created CLAUDE.md with team directive"
  }
  else {
    $content = Get-Content -LiteralPath $claude -Raw
    if ($content -match [regex]::Escape($startM)) {
      $pattern = '(?s)' + [regex]::Escape($startM) + '.*?' + [regex]::Escape($endM)
      $new = [regex]::Replace($content, $pattern, { param($m) $snippet })
      Set-Content -LiteralPath $claude -Value $new -Encoding utf8
      Write-Host "updated team directive block in CLAUDE.md"
    }
    else {
      Add-Content -LiteralPath $claude -Value ("`n" + $snippet + "`n") -Encoding utf8
      Write-Host "appended team directive to CLAUDE.md"
    }
  }
}
