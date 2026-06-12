with source as (
    select * from {{ source('tienda_online2', 'orders') }}
),

renamed as (
    select
        id                          as order_id,
        user_id,
        status,
        total::numeric(10,2)        as total,
        payer_email,
        fecha                       as order_date
    from source
)

select * from renamed