# Write your MySQL query statement below
/*
-- solution1
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
*/

WITH ranked_products AS (
    SELECT 
        s.store_id,
        s.store_name,
        s.location,
        i.product_name,
        i.price,
        i.quantity,
        ROW_NUMBER() OVER (PARTITION BY s.store_id ORDER BY i.price DESC) AS rn_expensive,
        ROW_NUMBER() OVER (PARTITION BY s.store_id ORDER BY i.price ASC) AS rn_cheap,
        COUNT(*) OVER (PARTITION BY s.store_id) AS total_products
    FROM inventory i
    JOIN stores s ON i.store_id = s.store_id
),
aggregated AS (
    SELECT
        store_id,
        store_name,
        location,
        MAX(CASE WHEN rn_expensive = 1 THEN product_name END) AS most_exp_product,
        MAX(CASE WHEN rn_cheap = 1 THEN product_name END) AS cheapest_product,
        MAX(CASE WHEN rn_expensive = 1 THEN quantity END) AS most_expensive_product_quantity,
        MAX(CASE WHEN rn_cheap = 1 THEN quantity END) AS cheapest_product_quantity,
        MAX(total_products) AS total_products
    FROM ranked_products
    WHERE rn_expensive = 1 OR rn_cheap = 1
    GROUP BY store_id, store_name, location
)
SELECT 
    store_id,
    store_name,
    location,
    most_exp_product,
    cheapest_product,
    ROUND(cheapest_product_quantity / most_expensive_product_quantity, 2) AS imbalance_ratio
FROM aggregated
WHERE total_products >= 3
  AND cheapest_product_quantity > most_expensive_product_quantity
ORDER BY imbalance_ratio DESC, store_name ASC;
