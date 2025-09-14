# Write your MySQL query statement below
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