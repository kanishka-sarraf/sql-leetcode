# Write your MySQL query statement below
with orders_2019 as (
    select buyer_id, count(*) as orders_in_2019
    from orders 
    where year(order_date) = 2019
    group by buyer_id
)
select 
    u.user_id as buyer_id, 
    u.join_date, 
    coalesce(o.orders_in_2019,0) as orders_in_2019
from users u
left join orders_2019 o on u.user_id = o.buyer_id;
