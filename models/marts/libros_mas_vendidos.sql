with order_items as (
    select * from {{ ref('stg_order_items') }}
),

aggregated as (
    select
        book_id,
        book_name,
        sum(quantity)                   as total_sold,
        count(distinct order_id)        as times_ordered,
        sum(subtotal)::numeric(10,2)    as total_revenue,
        avg(unit_price)::numeric(10,2)  as avg_price
    from order_items
    group by book_id, book_name
)

select * from aggregated
order by total_sold desc