with orders as (
    select * from {{ ref('stg_orders') }}
),

aggregated as (
    select
        status,
        count(*)                        as total_orders,
        sum(total)::numeric(10,2)       as total_revenue,
        avg(total)::numeric(10,2)       as avg_order_value,
        min(total)::numeric(10,2)       as min_order,
        max(total)::numeric(10,2)       as max_order
    from orders
    group by status
)

select * from aggregated
order by total_orders desc