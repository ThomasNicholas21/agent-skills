#!/usr/bin/env bash
# Script for cloning an agent template into any target project directory
# Usage: ./scripts/clone-agent-template.sh <template-name> [/caminho/do/projeto-destino]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HUB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -f "$HUB_DIR/scripts/agent-env.sh" ]; then
  source "$HUB_DIR/scripts/agent-env.sh"
elif [ -f "$HUB_DIR/agent-env.sh" ]; then
  source "$HUB_DIR/agent-env.sh"
fi

TEMPLATES_BASE="${AGENT_SKILLS_DIR:-$HUB_DIR}/templates"
TEMPLATE_NAME="$1"
TARGET_DIR="${2:-.}"

if [ -z "$TEMPLATE_NAME" ]; then
  echo "Error: Template name argument is required."
  echo ""
  echo "Available templates in $TEMPLATES_BASE:"
  if [ -d "$TEMPLATES_BASE" ]; then
    ls -1 "$TEMPLATES_BASE" | sed 's/^/  - /'
  fi
  echo ""
  echo "Usage: $0 <template-name> [/caminho/do/projeto-destino]"
  echo "Example: $0 django-drf ./meu-projeto"
  exit 1
fi

if [ -d "$TEMPLATES_BASE/$TEMPLATE_NAME/project-.agents" ]; then
  TEMPLATE_DIR="$TEMPLATES_BASE/$TEMPLATE_NAME/project-.agents"
elif [ -d "$TEMPLATES_BASE/$TEMPLATE_NAME" ]; then
  TEMPLATE_DIR="$TEMPLATES_BASE/$TEMPLATE_NAME"
else
  echo "Error: Template '$TEMPLATE_NAME' not found in '$TEMPLATES_BASE'."
  echo ""
  echo "Available templates:"
  if [ -d "$TEMPLATES_BASE" ]; then
    ls -1 "$TEMPLATES_BASE" | sed 's/^/  - /'
  fi
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
echo "   Template:    $TEMPLATE_NAME ($TEMPLATE_DIR)"
echo "   Target Path: $TARGET_DIR_ABS"
echo "=========================================================="

mkdir -p "$TARGET_AGENTS_DIR/rules"
mkdir -p "$TARGET_AGENTS_DIR/skills"
mkdir -p "$TARGET_AGENTS_DIR/workflows"

# Copy rules, skills, and workflows
if [ -d "$TEMPLATE_DIR/rules" ]; then
  cp -r "$TEMPLATE_DIR/rules/"* "$TARGET_AGENTS_DIR/rules/" 2>/dev/null || true
fi
if [ -d "$TEMPLATE_DIR/skills" ]; then
  cp -r "$TEMPLATE_DIR/skills/"* "$TARGET_AGENTS_DIR/skills/" 2>/dev/null || true
fi
if [ -d "$TEMPLATE_DIR/workflows" ]; then
  cp -r "$TEMPLATE_DIR/workflows/"* "$TARGET_AGENTS_DIR/workflows/" 2>/dev/null || true
fi

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
echo "✅ Successfully initialized .agents ($TEMPLATE_NAME) in: $TARGET_DIR_ABS"
echo "Created Structure:"
echo "  ├── .agents/"
echo "  │   ├── rules/"
echo "  │   ├── skills/"
echo "  │   └── workflows/"
echo "=========================================================="
