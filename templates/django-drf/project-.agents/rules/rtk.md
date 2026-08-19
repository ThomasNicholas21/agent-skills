---
trigger: always_on
---

# RTK — Eficiência no Terminal
O RTK é a interface padrão de terminal quando existir comando equivalente.
Seu objetivo é reduzir a saída no terminal e o consumo de contexto mantendo a corretude.

## Regra Central
```text
RTK primeiro → inspecione a saída → escale apenas quando necessário
```

Prefira RTK para:
```text
read / ls / tree / find / grep / rg
git / diff / log
tests / lint / typecheck
docker / compose
python / pip / uv
npm / pnpm / npx
database / cloud CLIs
```

Mapeamentos comuns:
```text
cat FILE          → rtk read FILE
ls DIR            → rtk ls DIR
tree DIR          → rtk tree DIR
find ...          → rtk find ...
grep ...          → rtk grep ...
rg ...            → rtk rg ...
git ...           → rtk git ...
git diff          → rtk diff
cat LOG           → rtk log LOG
cat JSON          → rtk json FILE
pytest            → rtk pytest
ruff              → rtk ruff
mypy              → rtk mypy
docker ...        → rtk docker ...
docker compose... → rtk docker compose ...
```
Se existir um wrapper RTK exato, prefira-o.

## Escalação
Nunca deduza informações porque a saída foi comprimida.
Use:
```text
1. RTK padrão
2. RTK verboso (-v / -vv)
3. rtk proxy <command>
4. comando nativo
```

Escale quando:
- Informações necessárias estiverem ausentes;
- Erros estiverem incompletos;
- A saída exata for necessária;
- O RTK não suportar o comando;
- A depuração exigir saída bruta.

## Integridade
- Preserve e respeite códigos de saída.
- Nunca ignore erros.
- Nunca trate saídas comprimidas como evidência completa se faltarem detalhes.
- A corretude sempre tem prioridade sobre a compressão.

## Descoberta
Quando tiver dúvida se o RTK suporta um comando:
```text
rtk --help
rtk <command> --help
```
Não invente sintaxe do RTK.

## Eficiência
Prefira comandos direcionados em vez de saídas amplas.
Bom:
```text
rtk grep "pattern" src/
rtk read specific/file.py
rtk git diff -- path/to/file
rtk log specific.log
```
Evite despejar desnecessariamente repositórios inteiros, logs gigantes, JSONs extensos ou histórico completo do Git.
Leia apenas o necessário para a tarefa atual.

## Diagnósticos
Comandos úteis do RTK (use apenas quando relevante):
```text
rtk gain
rtk gain --history
rtk discover
rtk session
rtk verify
```