# Write your MySQL query statement below
/*
-- solution1
with last_three_rating as (
    select e.name, p.*,
        first_value(rating) over w as latest_rating,
        nth_value(rating,2) over w as second_last_rating,
        nth_value(rating,3) over w as third_last_rating
    from employees e
    join performance_reviews p on e.employee_id = p.employee_id
    window w as (partition by e.employee_id order by review_date desc rows between unbounded preceding and unbounded following)
)
select distinct employee_id, name, latest_rating - third_last_rating as improvement_score
from last_three_rating
where latest_rating > second_last_rating and second_last_rating > third_last_rating
order by improvement_score desc, name asc;
*/

with last_three_rating as (
    select 
        employee_id,
        sum(case when rnk = 1 then rating else null end) as rating_1,
        sum(case when rnk = 2 then rating else null end) as rating_2,
        sum(case when rnk = 3 then rating else null end) as rating_3
    from (
        select *,
            dense_rank() over(partition by employee_id order by review_date desc) as rnk
        from performance_reviews
    ) t
    group by employee_id
)
select 
    e.employee_id, 
    e.name, 
    l.rating_1 - l.rating_3 as improvement_score  
from last_three_rating l
join employees e on l.employee_id = e.employee_id
where l.rating_1 > l.rating_2 and l.rating_2 > l.rating_3
order by improvement_score desc, e.name asc;