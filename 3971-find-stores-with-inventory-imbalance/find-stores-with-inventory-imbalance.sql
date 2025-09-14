# Write your MySQL query statement below
with store_details as (
    select 
        s.*, i.product_name, i.quantity, i.price,
        first_value(product_name) over w as most_exp_product ,
        last_value(product_name) over w as cheapest_product,
        first_value(price) over w as most_expensive_product_price,
        last_value(price) over w as cheapest_product_price,
        first_value(quantity) over w as most_expensive_product_quantity,
        last_value(quantity) over w as cheapest_product_quantity,
        count(*) over w as total_products
    from inventory i
    join stores s on i.store_id = s.store_id
    window w as (partition by store_id 
                 order by price desc 
                 rows between unbounded preceding and unbounded following)
)
select distinct
    store_id,
    store_name,
    location, 
    most_exp_product, 
    cheapest_product, 
    round(cheapest_product_quantity / most_expensive_product_quantity,2) as imbalance_ratio
from store_details
where total_products>=3 and cheapest_product_quantity > most_expensive_product_quantity
order by imbalance_ratio desc, store_name asc;