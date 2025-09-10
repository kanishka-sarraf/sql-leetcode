# Write your MySQL query statement below
select id,
case when id%2 = 1 then lead(student,1,student) over(order by id asc) 
     else lag(student,1) over(order by id asc)
end as student
from seat;