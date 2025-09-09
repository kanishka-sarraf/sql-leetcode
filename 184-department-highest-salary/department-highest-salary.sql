# Write your MySQL query statement below
/*
-- solution1
with max_department_salary as (
    select e.name as employee,
        d.name as department,
        e.salary,
        max(salary) over(partition by d.name) as max_salary
    from employee e
    join department d on e.departmentid = d.id
)

select department, employee, salary 
from max_department_salary
where salary = max_salary;
*/

select department, employee, salary
from (
    select d.name as department, e.name as employee, e.salary,
    dense_rank() over(partition by d.id order by e.salary desc) as rnk
    from employee e
    join department d on e.departmentid = d.id
) t 
where t.rnk = 1;