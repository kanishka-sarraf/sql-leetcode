# Write your MySQL query statement below
select t.employee_id, t.department_id from (
select *,
count(department_id) over(partition by employee_id) as num_dept
from employee
) t
where t.num_dept = 1 or t.primary_flag = 'Y';