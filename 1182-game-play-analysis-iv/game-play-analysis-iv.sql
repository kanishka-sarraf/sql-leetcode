# Write your MySQL query statement below
with player_logins as (
select *,
first_value(event_date) over w as first_login_date,
nth_value(event_date,2) over w as second_login_date
from activity
window w as (partition by player_id order by event_date asc rows between unbounded preceding and unbounded following)
)
select round((select count(distinct player_id)
                from player_logins
                where datediff(second_login_date, first_login_date) = 1
        ) 
        / 
        (select count(distinct player_id) from activity),2) as fraction
;