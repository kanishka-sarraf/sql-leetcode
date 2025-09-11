# Write your MySQL query statement below
select product_id, first_year, quantity, price 
from (
    select *,
    min(year) over(partition by product_id) as first_year
    from sales
) t
where t.year = t.first_year;