# Write your MySQL query statement below
select 
    query_name, 
    round(avg(rating / position),2) as quality,
    round(100*((select count(*) from queries q2 where rating < 3 and q2.query_name = q1.query_name) / count(*)),2) as poor_query_percentage
from queries q1
group by query_name;
