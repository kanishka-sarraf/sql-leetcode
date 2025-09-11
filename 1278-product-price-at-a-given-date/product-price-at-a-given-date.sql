# Write your MySQL query statement below
/*
-- solution1
select p1.product_id, coalesce(p2.price,10) as price 
from (
    (select 
        distinct product_id
    from products) p1
    left join 
    (select 
        distinct product_id, 
        first_value(new_price) over(partition by product_id order by change_date desc) as price
    from products
    where change_date <= '2019-08-16') p2 
                on p1.product_id = p2.product_id
);
*/

with updated_price as (
    select *,
    row_number() over(partition by product_id order by change_date desc) as rnk
    from products
    where change_date <= '2019-08-16'
)
select product_id, new_price as price 
from updated_price
where rnk = 1
union
select product_id, 10 as price
from products where product_id not in(select distinct product_id from updated_price);