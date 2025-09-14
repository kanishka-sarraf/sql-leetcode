# Write your MySQL query statement below
with sales_details as (
select s.*, p.product_name, p.category,
case when month(sale_date) in(12,1,2) then 'Winter'
     when month(sale_date) in(3,4,5) then 'Spring'
     when month(sale_date) in(6,7,8) then 'Summer'
     else 'Fall'
end as season,
s.quantity * s.price as revenue
from sales s
join products p on s.product_id = p.product_id
),
season_revenue as (
select season, category, sum(quantity) as total_quantity, sum(revenue) as total_revenue
from sales_details
group by season, category
)
select season, category, total_quantity, total_revenue from (
select *,
dense_rank() over(partition by season order by total_quantity desc, total_revenue desc) as rnk
from season_revenue
) t 
where t.rnk = 1
order by season asc;