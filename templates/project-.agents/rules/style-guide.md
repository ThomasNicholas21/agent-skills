---
trigger:
  glob: "**/*.{py,ts,js,java,cs}"
---

# Regras de Estilo, Nomenclatura e Princípios de Engenharia de Software

Ao escrever, revisar ou refatorar qualquer código, você DEVE seguir estritamente os princípios de engenharia, nomenclatura e disciplina abaixo.

---

## 1. Princípios Fundamentais de Engenharia

### SOLID

- **S - Single Responsibility Principle (SRP)**: Cada classe, função ou módulo DEVE ter uma única razão para mudar. Se uma classe faz validação E envia e-mail E grava no banco, ela viola SRP.
- **O - Open/Closed Principle (OCP)**: Entidades de software devem estar abertas para extensão, mas fechadas para modificação. Prefira composição, Strategy, Decorator ou injeção de dependência.
- **L - Liskov Substitution Principle (LSP)**: Subclasses devem ser substituíveis por suas classes-base sem quebrar o comportamento esperado. Se uma subclasse precisa sobrescrever o método-base para lançar `NotImplementedError`, é uma violação.
- **I - Interface Segregation Principle (ISP)**: Interfaces devem ser específicas e enxutas. Nunca force um consumidor a depender de métodos que ele não utiliza.
- **D - Dependency Inversion Principle (DIP)**: Módulos de alto nível NÃO devem depender de módulos de baixo nível. Ambos devem depender de abstrações (interfaces, protocolos, classes base abstratas).

Para referência completa dos padrões de projeto que implementam esses princípios, consulte o Catálogo de Design Patterns em `$DOC_DIR/design-patterns/INDEX.md`.

### KISS (Keep It Simple, Stupid)

- Mantenha funções e métodos curtos, focados e legíveis.
- Prefira soluções diretas e explícitas. Se a implementação precisa de um parágrafo para ser explicada, ela é complexa demais.
- Evite abstrações prematuras. Abstraia somente quando houver pelo menos 2 casos concretos e distintos que compartilham o mesmo comportamento.

### YAGNI (You Aren't Gonna Need It)

- NÃO escreva código especulativo, funcionalidades "para o futuro" ou abstrações que não são necessárias agora.
- NÃO crie helpers, utils ou wrappers que não estão sendo consumidos por nenhum código ativo.
- Se uma funcionalidade não está no requisito atual, ela não deve existir no código.

### DRY (Don't Repeat Yourself)

- Elimine duplicação de lógica de negócio. Se a mesma regra aparece em mais de um lugar, extraia para uma função, classe ou módulo compartilhado.
- DRY aplica-se a **lógica**, não a **código textual**. Duas funções com código parecido mas semântica diferente NÃO são duplicação.
- Atenção: DRY excessivo gera acoplamento. Se a extração cria dependências artificiais entre módulos que não se relacionam, mantenha a duplicação.

---

## 2. Tratamento de Erros

- Capture exceções **específicas**. Registre o contexto da causa raiz antes de re-lançar ou tratar.
- NUNCA use `except: pass` vazio ou retorne `null`/`None` silenciosamente como fallback não tratado.
- Exceções de domínio customizadas (`DomainError`, `OutOfStockError`) devem ser criadas para erros de negócio, separadas das exceções de infraestrutura.

---

## 3. Idioma Obrigatório

- Todo identificador (variável, função, classe, constante, enum, parâmetro) DEVE ser escrito em **inglês**.
- Comentários e docstrings podem ser no idioma do time, mas nomes de código são sempre em inglês.

---

## 4. Variáveis

### Regras

- O nome DEVE descrever **o que a variável armazena**, nunca como ela é usada.
- Usar `snake_case` em Python, `camelCase` em TypeScript/JavaScript/Java/C#.
- Evitar abreviações genéricas (`tmp`, `aux`, `data`, `info`, `val`, `res`).
- Evitar nomes de uma letra exceto em iteradores curtos (`i`, `j`, `k`) ou lambdas.
- Booleanos DEVEM começar com prefixo interrogativo: `is_`, `has_`, `can_`, `should_`.
- Constantes DEVEM ser em `UPPER_SNAKE_CASE`.

### Exemplos

```python
# ERRADO
d = get_data()
tmp = user.age > 18
flag = True
lst = Order.objects.filter(active=True)

# CORRETO
active_orders = Order.objects.filter(active=True)
is_adult = user.age > 18
has_permission = user.can_access(resource)
MAX_RETRY_ATTEMPTS = 3
DEFAULT_PAGE_SIZE = 25
```

```typescript
// ERRADO
const d = getData();
const flag = true;
let res = await fetchOrders();

// CORRETO
const activeOrders = await fetchOrders();
const isAuthenticated = session.isValid();
const hasAdminRole = user.roles.includes('admin');
const MAX_RETRY_ATTEMPTS = 3;
```

---

## 5. Funções e Métodos

### Regras

- O nome DEVE iniciar com um **verbo de ação** que descreve o que a função faz.
- Verbos recomendados: `get`, `find`, `fetch`, `create`, `update`, `delete`, `remove`, `calculate`, `validate`, `check`, `build`, `parse`, `format`, `convert`, `send`, `notify`, `process`, `handle`, `resolve`.
- Funções que retornam booleano DEVEM usar prefixo `is_`, `has_`, `can_`, `should_`.
- Parâmetros DEVEM seguir as mesmas regras de nomenclatura de variáveis.
- Usar keyword-only arguments (`*`) em Python para funções com mais de 2 parâmetros.

### Assinatura Padrão

```python
# ERRADO
def proc(d, f, t): ...


def do_stuff(order, flag=True): ...


# CORRETO
def calculate_total_revenue(
    *, orders: list[Order], include_taxes: bool = False
) -> Decimal:
    """Calculate total revenue from a list of orders, optionally including taxes."""
    ...


def validate_payment_method(*, method: str, allowed_methods: list[str]) -> bool:
    """Check if the provided payment method is in the allowed list."""
    ...


def is_eligible_for_discount(*, customer: Customer, minimum_orders: int = 5) -> bool:
    """Determine if a customer qualifies for a discount based on order history."""
    ...
```

```typescript
// ERRADO
function proc(d: any, f: boolean): any { ... }

// CORRETO
function calculateTotalRevenue(orders: Order[], includeTaxes: boolean = false): Decimal {
  /** Calculate total revenue from a list of orders, optionally including taxes. */
}

function isEligibleForDiscount(customer: Customer, minimumOrders: number = 5): boolean {
  /** Determine if a customer qualifies for a discount based on order history. */
}
```

---

## 6. Classes

### Regras

- O nome DEVE ser um **substantivo** ou **substantivo composto** em `PascalCase`.
- O nome DEVE refletir a **responsabilidade única** da classe (Single Responsibility Principle).
- Sufixos aceitos para indicar o papel arquitetural: `Service`, `Repository`, `Manager`, `Handler`, `Factory`, `Validator`, `Serializer`, `Controller`, `Adapter`, `Builder`.
- Evitar prefixos ou sufixos genéricos como `Helper`, `Utils`, `Misc`, `Base` (exceto em classes abstratas explícitas).

### Exemplos

```python
# ERRADO
class OrderHelper: ...


class DataProcessor: ...


class Stuff: ...


# CORRETO
class OrderDomainService:
    """Orchestrates order creation, validation, and stock management."""

    ...


class CustomerRepository:
    """Encapsulates optimized database queries for Customer entities."""

    ...


class PaymentGatewayAdapter:
    """Adapts external payment gateway API to internal payment interface."""

    ...
```

```typescript
// ERRADO
class OrderHelper { ... }
class DataUtils { ... }

// CORRETO
class OrderDomainService {
  /** Orchestrates order creation, validation, and stock management. */
}

class CustomerRepository {
  /** Encapsulates optimized database queries for Customer entities. */
}
```

---

## 7. Checklist de Validação Rápida

Antes de aceitar qualquer código, o agente DEVE validar:

- [ ] Identificadores estão em inglês.
- [ ] Variáveis descrevem **o que armazenam**, funções descrevem **o que fazem**.
- [ ] Sem abreviações genéricas (`tmp`, `aux`, `data`, `res`, `val`).
- [ ] Booleanos usam prefixo interrogativo (`is_`, `has_`, `can_`, `should_`).
- [ ] Funções começam com verbo de ação.
- [ ] Classes usam `PascalCase` com substantivo descritivo.
- [ ] Constantes usam `UPPER_SNAKE_CASE`.
- [ ] Nenhum código especulativo ou funcionalidade não solicitada foi adicionado (YAGNI).
- [ ] Nenhuma duplicação de lógica de negócio sem justificativa (DRY).
- [ ] Cada classe/função tem uma única responsabilidade (SRP).
- [ ] Exceções são capturadas de forma específica, sem `except: pass`.
