with order_items as (
    select * from {{ ref('stg_order_items') }}
),

books as (
    select * from {{ ref('stg_books') }}
),

categories as (
    select
        id          as category_id,
        nombre      as category_name
    from {{ source('tienda_online2', 'categories') }}
),

joined as (
    select
        c.category_name,
        count(distinct oi.order_id)     as total_orders,
        sum(oi.quantity)                as total_books_sold,
        sum(oi.subtotal)::numeric(10,2) as total_revenue
    from order_items oi
    join books b on oi.book_id = b.book_id
    join categories c on b.category_id = c.category_id
    group by c.category_name
)

select * from joined
order by total_revenue desc