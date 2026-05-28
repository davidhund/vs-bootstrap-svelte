#!/bin/bash
set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Updating Svelte skills from sveltejs/ai-tools..."

# Create directories
mkdir -p ~/.claude/skills/svelte-code-writer
mkdir -p ~/.claude/skills/svelte-core-bestpractices

# Download svelte-code-writer
echo "Downloading svelte-code-writer..."
curl -s https://raw.githubusercontent.com/sveltejs/ai-tools/main/tools/skills/svelte-code-writer/SKILL.md \
  -o ~/.claude/skills/svelte-code-writer/SKILL.md

# Download svelte-core-bestpractices
echo "Downloading svelte-core-bestpractices..."
curl -s https://raw.githubusercontent.com/sveltejs/ai-tools/main/tools/skills/svelte-core-bestpractices/SKILL.md \
  -o ~/.claude/skills/svelte-core-bestpractices/SKILL.md

echo -e "${GREEN}✓ Svelte skills updated successfully${NC}"
echo "Skills are now available in Claude Code sessions."
