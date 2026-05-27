#!/usr/bin/env bash
# bin/create.sh — Bootstrap a new project from vs-bootstrap-svelte
#
# Usage:
#   ./bin/create.sh <destination-path> [project-name]
#
# Examples:
#   ./bin/create.sh ~/projects/my-app
#   ./bin/create.sh ~/projects/my-app my-app
#
# If project-name is omitted, the basename of destination-path is used.

set -euo pipefail

# ---------------------------------------------------------------------------
# Config
# ---------------------------------------------------------------------------

TEMPLATE_REPO="https://github.com/davidhund/vs-bootstrap-svelte.git"
TEMPLATE_NAME="vs-bootstrap-svelte"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

red()   { printf '\033[0;31m%s\033[0m\n' "$*"; }
green() { printf '\033[0;32m%s\033[0m\n' "$*"; }
blue()  { printf '\033[0;34m%s\033[0m\n' "$*"; }
bold()  { printf '\033[1m%s\033[0m\n' "$*"; }

step() { printf '\n'; blue "▶ $*"; }
ok()   { green "  ✓ $*"; }
err()  { red   "  ✗ $*"; exit 1; }

# ---------------------------------------------------------------------------
# Arguments
# ---------------------------------------------------------------------------

if [[ $# -lt 1 ]]; then
  printf 'Usage: %s <destination-path> [project-name]\n' "$0"
  exit 1
fi

DEST="${1%/}"                                  # strip trailing slash
PROJECT_NAME="${2:-$(basename "$DEST")}"       # default to dirname
PROJECT_NAME="${PROJECT_NAME// /-}"            # replace spaces with hyphens

# ---------------------------------------------------------------------------
# Guards
# ---------------------------------------------------------------------------

if [[ -d "$DEST" && -n "$(ls -A "$DEST" 2>/dev/null)" ]]; then
  err "Destination '$DEST' already exists and is not empty. Aborting."
fi

command -v git  >/dev/null 2>&1 || err "'git' is required but not installed."
command -v pnpm >/dev/null 2>&1 || err "'pnpm' is required but not installed."

# ---------------------------------------------------------------------------
# Determine source: local copy or remote clone
# ---------------------------------------------------------------------------

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_DIR="$(dirname "$SCRIPT_DIR")"

if [[ -f "$TEMPLATE_DIR/package.json" ]] && \
   grep -q "\"$TEMPLATE_NAME\"" "$TEMPLATE_DIR/package.json" 2>/dev/null; then
  USE_LOCAL=true
else
  USE_LOCAL=false
fi

# ---------------------------------------------------------------------------
# Step 1: Copy / clone
# ---------------------------------------------------------------------------

step "Creating project '$PROJECT_NAME' in $DEST"

if [[ "$USE_LOCAL" == true ]]; then
  ok "Using local template copy"
  cp -r "$TEMPLATE_DIR" "$DEST"
else
  ok "Cloning from $TEMPLATE_REPO"
  git clone --depth 1 "$TEMPLATE_REPO" "$DEST"
fi

# ---------------------------------------------------------------------------
# Step 2: Strip template git history + re-init
# ---------------------------------------------------------------------------

step "Initialising fresh git repository"

rm -rf "$DEST/.git"
git -C "$DEST" init -q
git -C "$DEST" checkout -q -b main
ok "Fresh git repo on branch 'main'"

# ---------------------------------------------------------------------------
# Step 3: Rename project in package.json
# ---------------------------------------------------------------------------

step "Setting project name to '$PROJECT_NAME'"

PKG="$DEST/package.json"

if [[ "$(uname)" == "Darwin" ]]; then
  # macOS sed requires an empty extension argument for in-place edit
  sed -i '' "s/\"name\": \"$TEMPLATE_NAME\"/\"name\": \"$PROJECT_NAME\"/" "$PKG"
else
  sed -i "s/\"name\": \"$TEMPLATE_NAME\"/\"name\": \"$PROJECT_NAME\"/" "$PKG"
fi

ok "package.json updated"

# ---------------------------------------------------------------------------
# Step 4: Replace README with the project stub
# ---------------------------------------------------------------------------

step "Setting up README.md"

if [[ -f "$DEST/README.template.md" ]]; then
  # Replace project name placeholder and install as README.md
  if [[ "$(uname)" == "Darwin" ]]; then
    sed -i '' "s/PROJECT_NAME/$PROJECT_NAME/g" "$DEST/README.template.md"
  else
    sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" "$DEST/README.template.md"
  fi
  mv "$DEST/README.template.md" "$DEST/README.md"
  ok "README.md initialised from template stub"
fi

# ---------------------------------------------------------------------------
# Step 5: Install dependencies
# ---------------------------------------------------------------------------

step "Installing dependencies with pnpm"
pnpm install --dir "$DEST"
ok "Dependencies installed"

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

printf '\n'
bold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
green "  Project '$PROJECT_NAME' is ready!"
bold "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
printf '\n'
printf '  Next steps:\n\n'
printf '    cd %s\n' "$DEST"
printf '    pnpm dev\n\n'
printf '  Then open http://localhost:5173\n\n'
