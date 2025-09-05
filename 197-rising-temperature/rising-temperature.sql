# Write your MySQL query statement below
select t.id from (
select *,
    datediff(recorddate, lag(recorddate,1) over(order by recorddate asc)) as day_diff,
    lag(temperature,1) over(order by recorddate asc) as previous_date_temp
from weather
) t 
where (t.day_diff = 1) and (t.temperature > t.previous_date_temp);
-- where (t.temperature > t.previous_date_temp);
-- and (t.day_diff = 1);

/*
select id from (
select *,
-- recorddate - lag(recorddate) over(order by recorddate asc) as day_diff
lag(temperature,1) over(order by recorddate asc) as previous_date_temp
from weather
) t
where t.temperature > t.previous_date_temp;
*/

