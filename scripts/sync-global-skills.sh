#!/usr/bin/env bash
# Script for synchronization of global skills and rule files (GEMINI.md / CLAUDE.md)
# Usage: ./scripts/sync-global-skills.sh [--prune|-p] [--no-pull] [specific-skill-name]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HUB_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

if [ -f "$HUB_DIR/scripts/agent-env.sh" ]; then
  source "$HUB_DIR/scripts/agent-env.sh"
elif [ -f "$HUB_DIR/agent-env.sh" ]; then
  source "$HUB_DIR/agent-env.sh"
fi

GEMINI_SKILLS_TARGET="${GEMINI_DIR}/config/skills"
CLAUDE_SKILLS_TARGET="${CLAUDE_DIR}/skills"
GLOBAL_SKILLS_SRC="${HUB_DIR}/global/skills"

DO_PRUNE=0
DO_PULL=1
SPECIFIC_SKILL=""

# Parse command line flags and parameters
for arg in "$@"; do
  case "$arg" in
    --prune|-p|--clean|--sync-only)
      DO_PRUNE=1
      DO_PULL=0
      ;;
    --no-pull)
      DO_PULL=0
      ;;
    -h|--help)
      echo "Usage: $0 [--prune|-p] [--no-pull] [specific-skill-name]"
      echo "  --prune, -p : Removes orphan skills in agent targets that do not exist in repo."
      echo "  --no-pull   : Disables pulling untracked skills from Gemini to repo."
      exit 0
      ;;
    *)
      if [[ "$arg" != -* ]]; then
        SPECIFIC_SKILL="$arg"
      fi
      ;;
  esac
done

if [ ! -d "$GLOBAL_SKILLS_SRC" ]; then
  echo "Error: Global skills source directory '$GLOBAL_SKILLS_SRC' not found."
  exit 1
fi

echo "=========================================================="
if [ "$DO_PRUNE" -eq 1 ]; then
  echo "🌐 Strict Global Skills & Rules Sync (Push & Prune Orphans):"
else
  echo "🌐 Bi-directional Global Skills & Rules Synchronization:"
fi
echo "   Source Repo:   $GLOBAL_SKILLS_SRC"
echo "   Gemini Target: $GEMINI_SKILLS_TARGET"
if [ -d "$CLAUDE_DIR" ]; then
  echo "   Claude Target: $CLAUDE_SKILLS_TARGET"
fi
if [ -n "$SPECIFIC_SKILL" ]; then
  echo "   Filter Skill:  $SPECIFIC_SKILL"
fi
echo "=========================================================="

mkdir -p "$GEMINI_SKILLS_TARGET"
if [ -d "$CLAUDE_DIR" ]; then
  mkdir -p "$CLAUDE_SKILLS_TARGET"
fi

# Function to find all skill directories in repo (unpacking submodules)
# A skill directory is any directory containing a SKILL.md file.
find_repo_skills() {
  find "$GLOBAL_SKILLS_SRC" -type f -name "SKILL.md" | while read -r skill_file; do
    dirname "$skill_file"
  done
}

# Clean up old module container directories in targets if they don't contain a SKILL.md directly
cleanup_target_containers() {
  local target_dir="$1"
  [ -d "$target_dir" ] || return 0
  for item in "$target_dir"/*; do
    if [ -d "$item" ] && [ ! -f "$item/SKILL.md" ]; then
      rm -rf "$item"
    fi
  done
}

cleanup_target_containers "$GEMINI_SKILLS_TARGET"
if [ -d "$CLAUDE_DIR" ]; then
  cleanup_target_containers "$CLAUDE_SKILLS_TARGET"
fi

# --- STEP 1: PUSH SKILLS (Repo -> Agent Directories, Unpacked/Flattened) ---
echo "📤 Step 1: Updating Agent targets from repository (unpacking submodules)..."
SYNCED_COUNT=0

if [ -n "$SPECIFIC_SKILL" ]; then
  # Sync specific skill
  SKILL_DIR=""
  while read -r dir; do
    if [ "$(basename "$dir")" = "$SPECIFIC_SKILL" ]; then
      SKILL_DIR="$dir"
      break
    fi
  done < <(find_repo_skills)

  if [ -n "$SKILL_DIR" ]; then
    echo "  → Copying $SPECIFIC_SKILL -> $GEMINI_SKILLS_TARGET/$SPECIFIC_SKILL"
    mkdir -p "$GEMINI_SKILLS_TARGET/$SPECIFIC_SKILL"
    cp -r "$SKILL_DIR/"* "$GEMINI_SKILLS_TARGET/$SPECIFIC_SKILL/"
    if [ -d "$CLAUDE_DIR" ]; then
      mkdir -p "$CLAUDE_SKILLS_TARGET/$SPECIFIC_SKILL"
      cp -r "$SKILL_DIR/"* "$CLAUDE_SKILLS_TARGET/$SPECIFIC_SKILL/"
    fi
    SYNCED_COUNT=1
  else
    echo "  ⚠️ Skill '$SPECIFIC_SKILL' not found in repository modules."
  fi
else
  # Sync all skills unpacked
  while read -r skill_dir; do
    skill_name="$(basename "$skill_dir")"
    mkdir -p "$GEMINI_SKILLS_TARGET/$skill_name"
    cp -r "$skill_dir/"* "$GEMINI_SKILLS_TARGET/$skill_name/"
    if [ -d "$CLAUDE_DIR" ]; then
      mkdir -p "$CLAUDE_SKILLS_TARGET/$skill_name"
      cp -r "$skill_dir/"* "$CLAUDE_SKILLS_TARGET/$skill_name/"
    fi
    SYNCED_COUNT=$((SYNCED_COUNT + 1))
  done < <(find_repo_skills)
  echo "  ✅ Pushed $SYNCED_COUNT skills (unpacked) to agent targets."
fi

# --- STEP 1.5: PRUNE ORPHANS (Delete skills in target that no longer exist in repo) ---
if [ "$DO_PRUNE" -eq 1 ]; then
  echo ""
  echo "✂️  Step 1.5: Pruning orphan skills from agent targets..."
  
  prune_target_skills() {
    local target_dir="$1"
    local target_label="$2"
    [ -d "$target_dir" ] || return 0
    local pruned_count=0

    for item in "$target_dir"/*; do
      [ -d "$item" ] || continue
      local skill_name
      skill_name="$(basename "$item")"

      # Skip if specific skill filter is set and doesn't match
      if [ -n "$SPECIFIC_SKILL" ] && [ "$skill_name" != "$SPECIFIC_SKILL" ]; then
        continue
      fi

      # Check if skill exists anywhere in repo (by directory name with SKILL.md)
      local found_in_repo=0
      while read -r repo_skill_dir; do
        if [ "$(basename "$repo_skill_dir")" = "$skill_name" ]; then
          found_in_repo=1
          break
        fi
      done < <(find_repo_skills)

      if [ "$found_in_repo" -eq 0 ]; then
        echo "  🗑️ Pruning orphan skill '$skill_name' from $target_label"
        rm -rf "$item"
        pruned_count=$((pruned_count + 1))
      fi
    done
    if [ "$pruned_count" -gt 0 ]; then
      echo "  ✅ Pruned $pruned_count orphan skill(s) from $target_label."
    else
      echo "  ✅ No orphan skills found in $target_label."
    fi
  }

  prune_target_skills "$GEMINI_SKILLS_TARGET" "Gemini"
  if [ -d "$CLAUDE_DIR" ]; then
    prune_target_skills "$CLAUDE_SKILLS_TARGET" "Claude"
  fi
fi

# --- STEP 2: PULL SKILLS (Gemini -> Repo for new/untracked skills) ---
echo ""
if [ "$DO_PULL" -eq 1 ]; then
  echo "📥 Step 2: Checking for new skills in Gemini ($GEMINI_SKILLS_TARGET)..."
  PULLED_COUNT=0

  if [ -d "$GEMINI_SKILLS_TARGET" ]; then
    for target_skill_dir in "$GEMINI_SKILLS_TARGET"/*; do
      [ -d "$target_skill_dir" ] || continue
      # Only pull if it is a valid skill directory containing SKILL.md directly
      [ -f "$target_skill_dir/SKILL.md" ] || continue

      skill_name="$(basename "$target_skill_dir")"

      # Skip if specific skill filter is set and doesn't match
      if [ -n "$SPECIFIC_SKILL" ] && [ "$skill_name" != "$SPECIFIC_SKILL" ]; then
        continue
      fi

      # Check if skill exists anywhere in repo (by directory name with SKILL.md)
      FOUND_IN_REPO=0
      while read -r repo_skill_dir; do
        if [ "$(basename "$repo_skill_dir")" = "$skill_name" ]; then
          FOUND_IN_REPO=1
          break
        fi
      done < <(find_repo_skills)

      if [ "$FOUND_IN_REPO" -eq 0 ]; then
        # Pull new skill directly to root of global/skills/
        DEST_DIR="$GLOBAL_SKILLS_SRC/$skill_name"
        echo "  📥 New skill detected in Gemini! Pulling '$skill_name' -> global/skills/$skill_name"
        mkdir -p "$DEST_DIR"
        cp -r "$target_skill_dir/"* "$DEST_DIR/"
        PULLED_COUNT=$((PULLED_COUNT + 1))
      fi
    done
  fi

  if [ "$PULLED_COUNT" -gt 0 ]; then
    echo "⚠️  NOTIFICATION: $PULLED_COUNT new skill(s) were pulled from .gemini to 'global/skills/' root."
    echo "    Please review and organize them into appropriate modules if needed."
  else
    echo "  ✅ No new untracked skills found in Gemini targets."
  fi
else
  echo "⏭️  Step 2: Skipped Pull from Gemini (One-way Push/Prune mode active)."
fi

# --- STEP 3: SYNC GLOBAL RULE FILES (GEMINI.md / CLAUDE.md) ---
echo ""
echo "📄 Step 3: Synchronizing Global Rule Files (GEMINI.md / CLAUDE.md)..."

# Gemini: GEMINI.md
if [ -f "$HUB_DIR/global/GEMINI.md" ]; then
  echo "  📤 Pushing global/GEMINI.md -> $GEMINI_DIR/GEMINI.md"
  cp "$HUB_DIR/global/GEMINI.md" "$GEMINI_DIR/GEMINI.md"
elif [ -f "$GEMINI_DIR/GEMINI.md" ]; then
  echo "  📥 Pulling new global GEMINI.md -> global/GEMINI.md"
  cp "$GEMINI_DIR/GEMINI.md" "$HUB_DIR/global/GEMINI.md"
fi

# Claude: CLAUDE.md
if [ -d "$CLAUDE_DIR" ]; then
  if [ -f "$HUB_DIR/global/CLAUDE.md" ]; then
    echo "  📤 Pushing global/CLAUDE.md -> $CLAUDE_DIR/CLAUDE.md"
    cp "$HUB_DIR/global/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
  elif [ -f "$HUB_DIR/global/GEMINI.md" ]; then
    echo "  📤 Pushing global/GEMINI.md -> $CLAUDE_DIR/CLAUDE.md"
    cp "$HUB_DIR/global/GEMINI.md" "$CLAUDE_DIR/CLAUDE.md"
  elif [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo "  📥 Pulling new global CLAUDE.md -> global/CLAUDE.md"
    cp "$CLAUDE_DIR/CLAUDE.md" "$HUB_DIR/global/CLAUDE.md"
  fi
fi

# Ensure executable permissions for shell scripts inside global skills
find "$GEMINI_SKILLS_TARGET" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
if [ -d "$CLAUDE_DIR" ]; then
  find "$CLAUDE_SKILLS_TARGET" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
fi
find "$GLOBAL_SKILLS_SRC" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

echo "=========================================================="
echo "🎉 Synchronization Complete!"
echo "=========================================================="
