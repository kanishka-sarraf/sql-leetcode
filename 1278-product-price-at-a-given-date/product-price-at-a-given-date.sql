# Write your MySQL query statement below
select p1.product_id, coalesce(p2.price,10) as price 
from (
    (select distinct product_id
    from products) p1
    left join 
    (select distinct product_id, 
    first_value(new_price) over(partition by product_id order by change_date desc) as price
    from products
    where change_date <= '2019-08-16') p2 
                on p1.product_id = p2.product_id
);