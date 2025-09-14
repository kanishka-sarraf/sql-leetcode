# Write your MySQL query statement below
select 
    p1.product_id as product1_id, 
    p2.product_id as product2_id, 
    pi1.category as product1_category, 
    pi2.category as product2_category, 
    count(distinct p1.user_id) as customer_count 
from productpurchases p1
join productpurchases p2 on p1.user_id = p2.user_id and p1.product_id < p2.product_id
join productinfo pi1 on p1.product_id = pi1.product_id 
join productinfo pi2 on p2.product_id = pi2.product_id 
group by p1.product_id, p2.product_id
having customer_count >= 3
order by customer_count desc, p1.product_id asc, p2.product_id asc;