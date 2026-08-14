# Workflow: Update Agents (`/update-agents-workflow` ou `/update-agents`)

Comando de ativação: `/update-agents-workflow` ou `/update-agents`

## Objetivo
Orquestrar a calibração, diagnóstico e adaptação das regras (`.agents/rules/`), habilidades (`.agents/skills/`) e configurações dos agentes de IA ao importar o template para um novo projeto ou repositório.

O agente DEVE suportar dois modos de operação:
1. **Modo Projeto Existente (Análise Completa & Engenharia Reversa)**: Quando o projeto já possui código legado ou padrões estabelecidos, o agente analisa o projeto inteiro via RTK, extrai as convenções reais e adapta as regras para proteger o padrão existente sem causar quebras.
2. **Modo Entrevista Interativa (Estilo `/grill-me`)**: Quando o usuário deseja definir ativamente a arquitetura, o agente conduz uma entrevista estruturada por tópicos.

---

## Fases de Execução

### Fase 1: Reconhecimento Silencioso & Detecção de Projeto Existente
Antes de realizar qualquer pergunta, o agente DEVE inspecionar o repositório via RTK:
1. **Identificação de Stack**: `manage.py`, `pyproject.toml`, `requirements.txt`, `Pipfile`, `package.json`, `tsconfig.json`.
2. **Mapeamento de Diretórios**: Executar `rtk find "*"` para identificar se já existem apps, módulos ou código consolidado.
3. **Detecção de Maturidade**:
   - **Projeto Novo/Vazio**: Seguir diretamente para a entrevista de calibração.
   - **Projeto Existente**: Oferecer como opção primária a **Análise Total do Codebase** para extrair o padrão praticado.

---

### Fase 2: Escolha de Estratégia de Calibração

O agente DEVE perguntar ao usuário qual abordagem adotar:
- **Opção 1: (Recomendado para projetos consolidados) Seguir o Padrão do Projeto Existente**: O agente analisa todo o código-fonte existente e calibra as regras conforme as práticas já adotadas.
- **Opção 2: Entrevista Interativa Personalizada (Estilo `/grill-me`)**: O agente pergunta tópico por tópico (arquitetura, services, serializers, performance, testes).
- **Opção 3: Aplicar Padrão Oficial Recomendado**: Clean Modular Architecture, Service Layer desacoplada, GenericViewSet + Mixins, Serializers Read/Write, Test Mixins e Python limpo sem tipagem/docstrings verbosas.

---

### Fase 3A: Execução do Modo "Projeto Existente" (Análise Total)
Se a Opção 1 for selecionada, o agente DEVE executar uma varredura profunda no repositório:
1. **Varredura de Arquitetura**: Inspecionar múltiplos apps para identificar onde ficam views, viewsets, serializers e se existe camada de serviço (`services.py`, `use_cases/`, `handlers/`).
2. **Varredura de Models & ORM**: Analisar como os models são estruturados (se usam custom managers, querysets separados, `objects = Manager()`).
3. **Varredura de Serializers & Views**: Verificar se usam `ModelViewSet` ou `GenericViewSet`, se separam `ReadSerializer`/`WriteSerializer` ou se usam serializador único.
4. **Varredura de Estilo & Tipagem**: Detectar se o código utiliza type hints estritos (mypy), docstrings (Google/Sphinx) ou se é Python limpo/minimalista.
5. **Varredura de Testes**: Inspecionar `tests/` para verificar se usam `pytest` ou `unittest`, fixtures, `factory_boy` ou mixins de criação.
6. **Mapeamento de Padrões**: Consolidar as convenções reais detectadas e apresentá-las ao usuário para confirmação antes de gerar as regras.

---

### Fase 3B: Execução do Modo "Entrevista Interativa" (Bateria de Perguntas)
Se a Opção 2 for selecionada, o agente conduz a entrevista estruturada:
1. **Arquitetura & Pastas**: Clean Modular (`api/`), Django Monolítico, Hexagonal/DDD, ou Seguir Padrão Existente.
2. **Camada de Negócio**: Service Layer (`services.py`), Fat Models, Fat Serializers, ou Seguir Padrão Existente.
3. **ViewSets & Views**: `GenericViewSet` + Mixins, `ModelViewSet` padrão, `APIView` isoladas, ou Seguir Padrão Existente.
4. **Serializers**: Read/Write separados, Serializer único por modelo, ou Seguir Padrão Existente.
5. **Performance de ORM**: Prevenção de N+1, `Subquery`/`OuterRef`, Redis, Celery, ou Seguir Padrão Existente.
6. **Estratégia de Testes**: Mixins de criação de models (`mixins.py`), `SimpleTestCase`, `TestCase`, `APITestCase`, ou Pytest com fixtures.
7. **Estilo de Código**: Python limpo (sem docstrings/tipagem) vs Tipagem estrita com mypy/docstrings.

---

### Fase 4: Adaptação e Geração via `skill-creator`
Com base nas convenções identificadas (seja por análise do codebase ou pela entrevista), o agente invoca a **`skill-creator`** para atualizar ou gerar os arquivos em `.agents/rules/*.md`:
1. `architecture.md`: Formalizar a estrutura de diretórios e cascata de URLs.
2. `django-models.md`: Formalizar o padrão de models, managers e querysets.
3. `drf-viewsets.md` & `drf-views.md`: Formalizar o padrão de views e viewsets.
4. `drf-serializers.md`: Formalizar a política de serializadores.
5. `drf-exceptions.md` & `django-validators.md`: Formalizar o tratamento de erros e validações.
6. `drf-urls.md`: Formalizar o padrão de roteamento e Nested URLs.
7. `django-and-drf-performance.md`: Formalizar diretrizes de performance de banco.
8. `testing-standards.md`: Formalizar a hierarquia de testes e geradores de dados.
9. `style-guide.md`: Formalizar o padrão de tipagem, formatação e docstrings.

---

### Fase 5: Auditoria e Relatório de Fechamento
1. Validar a sintaxe dos arquivos gerados (Frontmatter YAML e gatilhos `trigger: glob`).
2. Apresentar um relatório resumido com todos os padrões formalizados para o projeto.
