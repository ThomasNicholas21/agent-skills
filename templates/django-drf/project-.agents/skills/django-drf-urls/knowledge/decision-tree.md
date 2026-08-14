# Knowledge: Árvore de Decisão de URLs e Regras Estritas de Roteamento

---

## 1. Árvore de Decisão para Organização de URLs

```text
AO DEFINIR E ORGANIZAR ROTAS NO PROJETO:

1. Trata-se de um recurso de domínio próprio do app?
   └── SIM ──> O app DEVE definir suas próprias rotas em urls.py.

2. O recurso é filho e depende de um recurso pai na URL (/parents/{parent_pk}/children/)?
   ├── SIM ──> O app do recurso filho DEVE expor suas rotas aninhadas em nested_urls.py.
   └── NÃO ──> O app expõe rotas diretas em urls.py.

3. Como compor as rotas aninhadas?
   ├── Poucas rotas aninhadas / Projeto modular ──> Usar Django path() + include() + nested_urls.py (Padrão Nativo).
   └── Dezenas de ViewSets aninhadas e encadeadas ─> Usar biblioteca drf-nested-routers.

4. O ViewSet recebe parent_pk na URL?
   ├── SIM ──> get_queryset() DEVE filtrar por parent_id=self.kwargs["parent_pk"].
   └── SIM ──> perform_create() DEVE salvar parent_id=self.kwargs["parent_pk"].
```

---

## 2. Regras Estritas de Proibição

1. **NUNCA** importe ViewSets ou Views de apps filhos dentro do `urls.py` de um app pai apenas para construir a rota aninhada. Respeite a regra de posse do recurso (**Resource Ownership**).
2. **NUNCA** confie no identificador do pai enviado pelo cliente no corpo da requisição (`request.data`) quando o identificador do pai fizer parte da URL.
3. **NUNCA** busque um recurso filho apenas pelo seu `pk` individual sem filtrar pelo `parent_pk` quando a URL for aninhada.
4. **NUNCA** declare `DefaultRouter` por padrão quando `SimpleRouter` for suficiente.
