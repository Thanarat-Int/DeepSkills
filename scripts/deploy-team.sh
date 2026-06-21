#!/usr/bin/env bash
set -euo pipefail

# Deploy the skill "team" into a target project's .claude/skills/ folder.
#
# Copies every shippable skill (each folder with a SKILL.md, excluding the
# personal / in-progress / deprecated draft buckets) from this repo into
# <target>/.claude/skills/<skill-name>/ as REAL files, so the whole team
# travels with the project repo. Re-running updates existing skills in place.
#
# Global install (link-skills.sh) already makes the team available in every
# project automatically — use this only to commit the team into one project.
#
# Usage: ./scripts/deploy-team.sh /path/to/project

REPO="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:?usage: deploy-team.sh <target-project-dir>}"

[ -d "$TARGET" ] || { echo "error: target not found: $TARGET" >&2; exit 1; }

DEST="$TARGET/.claude/skills"
mkdir -p "$DEST"

find "$REPO/skills" -name SKILL.md \
  -not -path '*/personal/*' \
  -not -path '*/in-progress/*' \
  -not -path '*/deprecated/*' \
  -not -path '*/node_modules/*' \
  -print0 |
while IFS= read -r -d '' skill_md; do
  src="$(dirname "$skill_md")"
  name="$(basename "$src")"
  rm -rf "$DEST/$name"
  cp -R "$src" "$DEST/$name"
  echo "deployed $name"
done

echo "Deployed team to $DEST"

# --- Team directive: make the AI follow the workflow proactively (no slash, no prompt) ---
# Pass --no-directive as the 2nd arg to skip editing the project's CLAUDE.md.
if [ "${2:-}" != "--no-directive" ]; then
  SNIPPET="$REPO/templates/CLAUDE-team-snippet.md"
  CLAUDE="$TARGET/CLAUDE.md"
  START='<!-- team-skills:start -->'
  END='<!-- team-skills:end -->'

  if [ ! -f "$CLAUDE" ]; then
    cp "$SNIPPET" "$CLAUDE"
    echo "created CLAUDE.md with team directive"
  elif grep -qF "$START" "$CLAUDE"; then
    awk -v s="$START" -v e="$END" '
      $0 ~ s {skip=1}
      skip==0 {print}
      $0 ~ e {skip=0}
    ' "$CLAUDE" > "$CLAUDE.tmp"
    printf '\n' >> "$CLAUDE.tmp"
    cat "$SNIPPET" >> "$CLAUDE.tmp"
    mv "$CLAUDE.tmp" "$CLAUDE"
    echo "updated team directive block in CLAUDE.md"
  else
    printf '\n' >> "$CLAUDE"
    cat "$SNIPPET" >> "$CLAUDE"
    echo "appended team directive to CLAUDE.md"
  fi
fi
