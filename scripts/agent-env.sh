#!/usr/bin/env bash
# Agent Skills Environment Configuration
# Source this file or load environment variables for Antigravity & Claude Code agents

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export GEMINI_DIR="${GEMINI_DIR:-$HOME/.gemini}"
export CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
export OBSIDIAN_VAULT_DIR="${OBSIDIAN_VAULT_DIR:-$HOME/obsidian/obsidian-second-brain}"
export SECOND_BRAIN_DIR="${SECOND_BRAIN_DIR:-$OBSIDIAN_VAULT_DIR}"
export AGENT_SKILLS_DIR="${AGENT_SKILLS_DIR:-$HOME/projects/agent-skills}"
export DOC_DIR="${DOC_DIR:-$AGENT_SKILLS_DIR/docs}"

# Run global environment loader script if invoked directly
if [ "${BASH_SOURCE[0]}" -eq "$0" ] 2>/dev/null || [ "$0" = "$BASH_SOURCE" ]; then
  bash "$SCRIPT_DIR/load-global-env.sh" "$SCRIPT_DIR/../.env"
fi

# Helper function to print agent environment paths
show_agent_env() {
  echo "=========================================="
  echo "       AGENT SKILLS ENVIRONMENT"
  echo "=========================================="
  echo "GEMINI_DIR:         $GEMINI_DIR"
  echo "CLAUDE_DIR:         $CLAUDE_DIR"
  echo "OBSIDIAN_VAULT_DIR: $OBSIDIAN_VAULT_DIR"
  echo "SECOND_BRAIN_DIR:   $SECOND_BRAIN_DIR"
  echo "AGENT_SKILLS_DIR:   $AGENT_SKILLS_DIR"
  echo "DOC_DIR:            $DOC_DIR"
  echo "=========================================="
}
