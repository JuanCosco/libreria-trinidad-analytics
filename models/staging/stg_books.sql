with source as (
    select * from {{ source('tienda_online2', 'books') }}
),

renamed as (
    select
        id          as book_id,
        nombre      as book_name,
        precio::numeric(10,2) as price,
        descuento   as discount_pct,
        activo      as is_active,
        category_id
    from source
)

select * from renamed