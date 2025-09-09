# Write your MySQL query statement below
select distinct num as ConsecutiveNums from (
select *,
lag(num,1) over(order by id asc) as previous_num,
lag(num,2) over(order by id asc) as previous_second_num
from logs
) t
where num = previous_num and num = previous_second_num;