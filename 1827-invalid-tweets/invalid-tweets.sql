# Write your MySQL query statement below
select tweet_id from (
select *, 
case when length(content) > 15 then 'invalid' 
     else 'valid'
end as is_valid
from tweets
) t 
where t.is_valid = 'invalid';