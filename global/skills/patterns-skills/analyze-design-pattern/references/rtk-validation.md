# Diretrizes de Inspeção e Validação RTK: analyze-design-pattern

Para economizar tokens e garantir acurácia técnica, utilize os comandos RTK abaixo durante o fluxo de orquestração:

## 1. Mapeamento do Repositório
```bash
# Inspecionar estrutura de diretórios de forma compacta
rtk find "*.py" .

# Procurar por views gerdas ou controllers existentes
rtk grep "class.*ViewSet" src/
rtk grep "def create" apps/
```

## 2. Inspeção de Arquivos de Configuração
```bash
# Ler arquivos de configuração sem comentários ou linhas em branco redundantes
rtk read .env
rtk read pyproject.toml
```

## 3. Validação de Testes
```bash
# Executar suíte de testes com relatório resumido de tokens
rtk pytest
```
