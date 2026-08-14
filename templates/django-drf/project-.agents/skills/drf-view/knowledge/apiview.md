# Knowledge: Conceitos Fundamentais e Políticas do APIView no DRF

---

## 1. O que é o `APIView`

O `APIView` herda diretamente de `django.views.View` e representa a camada base de abstração de views no Django REST Framework (DRF).

Diferente de uma View tradicional do Django, o `APIView`:
- Encapsula a requisição recebida em uma instância de `rest_framework.request.Request`.
- Retorna instâncias de `rest_framework.response.Response`.
- Realiza **Content Negotiation** automático de formatos de entrada e saída.
- Captura exceções da API (`APIException`) via `handle_exception()`.
- Executa autenticação, verificação de permissões e controle de taxa (*throttling*) antes de despachar a requisição.
- Despacha a requisição para os manipuladores de verbo HTTP (`get()`, `post()`, `put()`, `patch()`, `delete()`).

---

## 2. Atributos de Política (`API Policy Attributes`)

O `APIView` expõe atributos declarativos para definir as políticas da API:

| Atributo de Política | Responsabilidade | Descrição |
| :--- | :--- | :--- |
| `authentication_classes` | Autenticação | Identifica quem é o usuário solicitante (`request.user`). |
| `permission_classes` | Permissão | Verifica se o usuário tem autorização para executar a ação. |
| `throttle_classes` | Throttling | Verifica se o limite de taxa de requisições foi excedido. |
| `parser_classes` | Parsing | Define como o corpo da requisição (`request.data`) será interpretado. |
| `renderer_classes` | Renderização | Define como o objeto `Response` será representado (ex: JSON). |
| `content_negotiation_class` | Negociação | Seleciona o par renderer/parser ideal para o cliente. |

---

## 3. Manipuladores de Verbo HTTP (`HTTP Handlers`)

No `APIView`, os métodos da classe correspondem diretamente aos verbos HTTP e representam a intenção da operação:

- `get(self, request, *args, **kwargs)` → Consultar dados.
- `post(self, request, *args, **kwargs)` → Criar recurso ou executar operação (RPC).
- `put(self, request, *args, **kwargs)` → Substituição / Atualização completa.
- `patch(self, request, *args, **kwargs)` → Atualização parcial.
- `delete(self, request, *args, **kwargs)` → Remover recurso.

---

## 4. Quando Utilizar `APIView`

Use `APIView` **apenas** quando o endpoint possuir um comportamento HTTP/API customizado que **não se encaixa** naturalmente no modelo CRUD fornecido pelas Generic Views ou ViewSets (ex: endpoints RPC de ação única como checkout de carrinho ou validação de OTP).
