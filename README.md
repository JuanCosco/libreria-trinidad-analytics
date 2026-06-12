# Librería Trinidad — Analytics Layer

Capa de transformación de datos construida con dbt sobre PostgreSQL, parte del proyecto de migración de Librería Trinidad de PHP legacy a stack moderno.

## Stack

- **Herramienta:** dbt Core 1.11.11
- **Adaptador:** dbt-postgres 1.10.0
- **Base de datos:** PostgreSQL (tienda_online2)
- **Schema de salida:** analytics

## Arquitectura

public (PostgreSQL)        analytics (PostgreSQL)

├── orders          →      ├── stg_orders
├── order_items     →      ├── stg_order_items
├── books           →      ├── stg_books
├── categories      →      │
└── users           →      └── marts/
├── ventas_por_categoria
├── libros_mas_vendidos
└── resumen_ordenes

## Modelos

### Staging
Vistas que limpian y estandarizan las tablas raw del backend.

| Modelo | Fuente | Descripción |
|---|---|---|
| stg_orders | public.orders | Órdenes con columnas renombradas y tipos casteados |
| stg_order_items | public.order_items | Items con subtotal calculado |
| stg_books | public.books | Libros estandarizados |

### Marts
Tablas con métricas de negocio listas para consumir.

| Modelo | Descripción |
|---|---|
| ventas_por_categoria | Revenue, órdenes y unidades vendidas por categoría |
| libros_mas_vendidos | Ranking de libros por cantidad vendida e ingresos |
| resumen_ordenes | Órdenes agrupadas por estado con métricas de valor |

## Tests

12 tests de calidad de datos cubriendo:
- Unicidad de IDs
- Valores no nulos en columnas críticas
- Valores aceptados para el campo `status`

## Instalación

```bash
# Instalar dbt
pip install dbt-core==1.11.11 dbt-postgres==1.10.0

# Configurar conexión en ~/.dbt/profiles.yml
# Ver profiles.yml.example para referencia

# Verificar conexión
dbt debug

# Correr modelos
dbt run

# Correr tests
dbt test

# Ver documentación
dbt docs generate
dbt docs serve
```

## Configuración profiles.yml

```yaml
tienda_analytics:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      port: 5432
      user: tu_usuario
      pass: tu_password
      dbname: tienda_online2
      schema: analytics
      threads: 1
```

## Resultados actuales

| Métrica | Valor |
|---|---|
| Categoría top | Programación — S/ 994.78 |
| Libro más vendido | Python — 12 unidades |
| Órdenes pagadas | 5 |
| Revenue total | S/ 1,061.78 |