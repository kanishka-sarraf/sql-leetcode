# Write your MySQL query statement below
-- @total_users = (select count(*) from users)
select 
    contest_id, 
    round((count(*) / (select count(*) from users))*100,2) as percentage
from register
group by contest_id
order by percentage desc, contest_id asc;