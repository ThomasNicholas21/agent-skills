#!/usr/bin/env bash
set -euo pipefail

# ==============================================================================
# Synchronize .env variables into the user's shell configuration.
#
# Only the managed block is modified. Everything else in ~/.bashrc is preserved.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_FILE="${1:-$ROOT_DIR/.env}"

case "${SHELL:-}" in
    */zsh)
        TARGET_RC="$HOME/.zshrc"
        ;;
    *)
        TARGET_RC="$HOME/.bashrc"
        ;;
esac

BLOCK_START="# >>> agent-skills env >>>"
BLOCK_END="# <<< agent-skills env <<<"

if [[ ! -f "$ENV_FILE" ]]; then
    echo "Erro: arquivo .env não encontrado: $ENV_FILE"
    exit 1
fi

touch "$TARGET_RC"

TMP_FILE="$(mktemp)"
trap 'rm -f "$TMP_FILE"' EXIT

{
    echo "$BLOCK_START"

    while IFS= read -r line || [[ -n "$line" ]]; do
        # Remove espaços externos.
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"

        # Ignora linhas vazias e comentários.
        [[ -z "$line" || "$line" == \#* ]] && continue

        # Aceita apenas KEY=value.
        if [[ "$line" =~ ^([A-Za-z_][A-Za-z0-9_]*)=(.*)$ ]]; then
            key="${BASH_REMATCH[1]}"
            value="${BASH_REMATCH[2]}"

            # Remove aspas externas.
            if [[ "$value" =~ ^\".*\"$ ]]; then
                value="${value:1:-1}"
            elif [[ "$value" =~ ^\'.*\'$ ]]; then
                value="${value:1:-1}"
            fi

            printf 'export %s=%q\n' "$key" "$value"
        fi
    done < "$ENV_FILE"

    echo "$BLOCK_END"
} > "$TMP_FILE"

# Remove o bloco antigo e insere o novo.
awk -v start="$BLOCK_START" -v end="$BLOCK_END" '
    $0 == start {
        inside = 1
        next
    }

    $0 == end {
        inside = 0
        next
    }

    !inside {
        print
    }
' "$TARGET_RC" > "${TMP_FILE}.rc"

cat "$TMP_FILE" >> "${TMP_FILE}.rc"

mv "${TMP_FILE}.rc" "$TARGET_RC"

echo "Variáveis sincronizadas com sucesso."
echo "Fonte:   $ENV_FILE"
echo "Destino: $TARGET_RC"
echo
echo "Para aplicar no terminal atual:"
echo "  source $TARGET_RC"