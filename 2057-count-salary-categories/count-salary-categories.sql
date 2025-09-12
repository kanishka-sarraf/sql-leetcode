# Write your MySQL query statement below
with accounts_category as (
    select *,
        case when income < 20000 then 1 else 0 end as low_salary,
        case when income between 20000 and 50000 then 1 else 0 end as average_salary,
        case when income > 50000 then 1 else 0 end as high_salary
    from accounts
)
select 'Low Salary' as category, sum(low_salary) as accounts_count from accounts_category
union
select 'Average Salary', sum(average_salary) from accounts_category
union
select 'High Salary', sum(high_salary) from accounts_category;



/*
-- Not working as there is average salary records.
with account_category as (
    select *,
        case when income < 20000 then 'Low Salary'
            when income between 20000 and 50000 then 'Average Salary'
            else 'High Salary'
        end as salary_category
    from accounts
),
category_count as (
    select salary_category, count(*) as accounts_count 
    from account_category
    group by salary_category
)
select * from category_count
union
select salary_category, 0 
from account_category
where salary_category not in(select salary_category from category_count);
*/
