# Write your MySQL query statement below
with swap_sex_cte as
(select *, case when sex = 'm' then 'f' else 'm' end as swap_sex from salary)
update salary s
set s.sex = (select swap_sex from swap_sex_cte c where c.id = s.id);
