# Write your MySQL query statement below
select name 
from employee 
where id in(
            select managerid
            from employee
            group by managerid
            having count(*)>=5
        );

/*
select *-- m.name
from employee e
left join employee m on e.managerid = m.id
group by m.id, m.name
having count(*)>=5;
*/