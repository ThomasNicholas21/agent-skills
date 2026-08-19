# Example: Django ModelAdmin Otimizado
```python
from django.contrib import admin
from .models import Order


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    # 1. Exibição e Busca
    list_display = (
        "code",
        "user_email",
        "status",
        "total_amount",
        "is_active",
        "created_at",
    )
    list_filter = ("status", "is_active", "created_at")
    search_fields = ("code", "user__email", "user__username")
    ordering = ("-created_at",)
    list_select_related = ("user",)

    # 2. Performance & Paginação
    list_per_page = 25
    show_full_result_count = False  # Evita COUNT(*) custoso

    # 3. Lookups Velozes
    autocomplete_fields = ("user",)
    readonly_fields = ("id", "created_at", "updated_at")

    # 4. Prevenção N+1 no admin
    def get_queryset(self, request):
        return (
            super()
            .get_queryset(request)
            .select_related("user")
            .prefetch_related("items")
        )

    # 5. Admin display customizado
    @admin.display(description="User Email", ordering="user__email")
    def user_email(self, obj: Order) -> str:
        return obj.user.email
```