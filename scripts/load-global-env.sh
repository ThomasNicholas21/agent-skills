#!/usr/bin/env bash
# ==============================================================================
# Script para carregar variáveis do .env como variáveis globais do terminal (~/.bashrc)
# Regra: NÃO sobrescreve variáveis existentes. Informa ao usuário como proceder.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
ENV_FILE="${1:-$ROOT_DIR/.env}"

TARGET_RC="$HOME/.bashrc"
if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
  TARGET_RC="$HOME/.zshrc"
fi

if [ ! -f "$ENV_FILE" ]; then
  echo "Erro: Arquivo .env não encontrado em: $ENV_FILE"
  exit 1
fi

echo "=========================================="
echo "Carregando Variáveis Globais de Ambiente"
echo "Arquivo de origem: $ENV_FILE"
echo "Arquivo de destino: $TARGET_RC"
echo "=========================================="

created_count=0
existing_count=0

while IFS= read -r line || [ -n "$line" ]; do
  trimmed_line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

  if [[ -z "$trimmed_line" || "$trimmed_line" =~ ^# ]]; then
    continue
  fi

  if [[ "$trimmed_line" =~ ^([A-Za-z_][A-Za-z0-9_]*)=(.*)$ ]]; then
    key="${BASH_REMATCH[1]}"
    value="${BASH_REMATCH[2]}"

    value=$(echo "$value" | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")

    current_env_val="${!key}"
    grep_rc=$(grep -E "^export ${key}=" "$TARGET_RC" 2>/dev/null)

    if [ -n "$current_env_val" ] || [ -n "$grep_rc" ]; then
      echo "[AVISO] A variável '$key' já existe e NÃO foi sobrescrita."
      echo "        Valor atual no ambiente: ${current_env_val:-$grep_rc}"
      echo "        Para atualizar esta variável, remova-a (ex: unset $key e edite $TARGET_RC) e rode o script novamente."
      echo "------------------------------------------"
      existing_count=$((existing_count + 1))
    else
      export "$key=$value"
      echo "export $key=\"$value\"" >> "$TARGET_RC"
      echo "[SUCESSO] Variável '$key' criada com sucesso!"
      echo "          Adicionada a: $TARGET_RC"
      echo "          Valor: $value"
      echo "------------------------------------------"
      created_count=$((created_count + 1))
    fi
  fi
done < "$ENV_FILE"

echo "=========================================="
echo "Resumo: $created_count criadas | $existing_count já existentes"
echo "Para carregar no terminal ativo agora, rode: source $TARGET_RC"
echo "=========================================="
