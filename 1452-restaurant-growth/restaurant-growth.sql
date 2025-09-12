# Write your MySQL query statement below
select * from (
select 
    visited_on,
    sum(total_amount) over w as amount,
    round(avg(total_amount) over w,2) as average_amount
from (
    select visited_on, sum(amount) as total_amount
    from customer
    group by visited_on
) t
-- where visited_on >= date_add((select min(visited_on) from customer),interval 6 day)  (filtering first 6 days from running sum and average)
window w as (order by visited_on rows between 6 preceding and current row)
order by visited_on asc
) o
where visited_on >= date_add((select min(visited_on) from customer),interval 6 day);