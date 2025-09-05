# Write your MySQL query statement below
with first_quater_product as (
select product_id, count(*) as num_prod
from sales s1
where sale_date between '2019-01-01' and '2019-03-31'
group by product_id
having num_prod = (select count(*) 
                   from sales s2 
                   where s2.product_id = s1.product_id)
)
select p.product_id, p.product_name
from first_quater_product t
join product p on t.product_id = p.product_id;