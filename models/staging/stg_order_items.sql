with source as (
    select * from {{ source('tienda_online2', 'order_items') }}
),

renamed as (
    select
        id                              as item_id,
        order_id,
        book_id,
        nombre_snapshot                 as book_name,
        precio_snapshot::numeric(10,2)  as unit_price,
        cantidad                        as quantity,
        (precio_snapshot * cantidad)::numeric(10,2) as subtotal
    from source
)

select * from renamed