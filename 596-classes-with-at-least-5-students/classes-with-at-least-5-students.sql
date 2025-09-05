# Write your MySQL query statement below
select class-- , count(student) as num_students
from courses
group by class
having count(student)>=5;