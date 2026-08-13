#!/usr/bin/env bash
# Script for initializing local agent structure (.agents/, CLAUDE.md, GEMINI.md) in a target project
# Usage: ./scripts/init-project-agents.sh <path-to-target-project>

set -e

# Load environment variables if available
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HUB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -f "$HUB_DIR/agent-env.sh" ]; then
  source "$HUB_DIR/agent-env.sh"
fi

TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
  echo "Error: Target project path must be provided as a terminal parameter."
  echo "Usage: $0 <path-to-target-project>"
  echo "Example: $0 /home/thomas/projects/my-app"
  exit 1
fi

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: Target directory '$TARGET_DIR' does not exist."
  exit 1
fi

TARGET_DIR_ABS="$(cd "$TARGET_DIR" && pwd)"
TEMPLATE_DIR="$HUB_DIR/templates/project-.agents"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "Error: Master template directory '$TEMPLATE_DIR' not found."
  exit 1
fi

echo "=========================================================="
echo "🚀 Initializing Agent Infrastructure for Target Project:"
echo "   Path: $TARGET_DIR_ABS"
echo "=========================================================="

# Create .agents structure
TARGET_AGENTS_DIR="$TARGET_DIR_ABS/.agents"
mkdir -p "$TARGET_AGENTS_DIR/rules"
mkdir -p "$TARGET_AGENTS_DIR/skills"
mkdir -p "$TARGET_AGENTS_DIR/workflows"

# Copy template .agents contents
echo "📂 Copying rules, skills, and workflows templates..."
cp -r "$TEMPLATE_DIR/rules/"* "$TARGET_AGENTS_DIR/rules/" 2>/dev/null || true
cp -r "$TEMPLATE_DIR/skills/"* "$TARGET_AGENTS_DIR/skills/" 2>/dev/null || true
cp -r "$TEMPLATE_DIR/workflows/"* "$TARGET_AGENTS_DIR/workflows/" 2>/dev/null || true

# Copy CLAUDE.md and GEMINI.md templates if present
if [ -f "$TEMPLATE_DIR/CLAUDE.md" ]; then
  cp "$TEMPLATE_DIR/CLAUDE.md" "$TARGET_DIR_ABS/CLAUDE.md"
fi

if [ -f "$TEMPLATE_DIR/GEMINI.md" ]; then
  cp "$TEMPLATE_DIR/GEMINI.md" "$TARGET_DIR_ABS/GEMINI.md"
fi

# Ensure executable permissions for any scripts inside local skills
find "$TARGET_AGENTS_DIR/skills" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo "=========================================================="
echo "✅ Agent Infrastructure initialized successfully in:"
echo "   $TARGET_AGENTS_DIR"
echo ""
echo "Created Structure:"
echo "  ├── CLAUDE.md"
echo "  ├── GEMINI.md"
echo "  └── .agents/"
echo "      ├── rules/      (DRF, RTK, Testing standards)"
echo "      ├── skills/     (Local skills, Service skills, Meta-skills)"
echo "      └── workflows/  (Functional tests, Plan, Clean refactor)"
echo "=========================================================="
