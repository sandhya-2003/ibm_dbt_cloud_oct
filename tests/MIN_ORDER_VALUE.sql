with orders as (
    select * from {{ ref('stg_orders') }}
)


SELECT order_id,total_price
FROM stg_orders
WHERE total_price <= 800