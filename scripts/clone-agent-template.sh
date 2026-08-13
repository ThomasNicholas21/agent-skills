#!/usr/bin/env bash
# Script for cloning the master .agents template into any target project directory
# Usage: ./scripts/clone-agent-template.sh [/caminho/do/projeto-destino]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HUB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -f "$HUB_DIR/scripts/agent-env.sh" ]; then
  source "$HUB_DIR/scripts/agent-env.sh"
elif [ -f "$HUB_DIR/agent-env.sh" ]; then
  source "$HUB_DIR/agent-env.sh"
fi

TEMPLATE_DIR="${AGENT_SKILLS_DIR:-$HUB_DIR}/templates/project-.agents"
TARGET_DIR="${1:-.}"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Error: Template directory '$TEMPLATE_DIR' does not exist."
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Target directory '$TARGET_DIR' does not exist."
  exit 1
fi

TARGET_DIR_ABS="$(cd "$TARGET_DIR" && pwd)"
TARGET_AGENTS_DIR="$TARGET_DIR_ABS/.agents"

echo "=========================================================="
echo "🚀 Cloning Agent Template into Target Project:"
echo "   Target Path: $TARGET_DIR_ABS"
echo "   Template:    $TEMPLATE_DIR"
echo "=========================================================="

mkdir -p "$TARGET_AGENTS_DIR/rules"
mkdir -p "$TARGET_AGENTS_DIR/skills"
mkdir -p "$TARGET_AGENTS_DIR/workflows"

# Copy rules, skills, and workflows
cp -r "$TEMPLATE_DIR/rules/"* "$TARGET_AGENTS_DIR/rules/" 2>/dev/null || true
cp -r "$TEMPLATE_DIR/skills/"* "$TARGET_AGENTS_DIR/skills/" 2>/dev/null || true
cp -r "$TEMPLATE_DIR/workflows/"* "$TARGET_AGENTS_DIR/workflows/" 2>/dev/null || true

# Copy root GEMINI.md and CLAUDE.md if present in template
if [ -f "$TEMPLATE_DIR/GEMINI.md" ]; then
  cp "$TEMPLATE_DIR/GEMINI.md" "$TARGET_DIR_ABS/GEMINI.md"
fi
if [ -f "$TEMPLATE_DIR/CLAUDE.md" ]; then
  cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR_ABS/CLAUDE.md"
fi

# Ensure executable permissions for any scripts inside local skills
find "$TARGET_AGENTS_DIR/skills" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo "=========================================================="
echo "✅ Successfully initialized .agents in: $TARGET_DIR_ABS"
echo "Created Structure:"
echo "  ├── .agents/"
echo "  │   ├── rules/"
echo "  │   ├── skills/"
echo "  │   └── workflows/"
echo "=========================================================="
