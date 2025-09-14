# Write your MySQL query statement below
select t1.user_id, t2.trial_avg_duration, t1.paid_avg_duration 
from (
    select user_id, round(avg(activity_duration),2) as paid_avg_duration
    from useractivity
    where activity_type = 'paid'
    group by user_id
) t1 
join (
    select user_id, round(avg(activity_duration),2) as trial_avg_duration
    from useractivity
    where activity_type = 'free_trial'
    group by user_id
) t2 on t1.user_id = t2.user_id
order by t1.user_id;


/*
with user_activity_details as (
select user_id, activity_type,
case when activity_type = 'free_trial' then activity_duration else 0 end as free_trial_duration,
case when activity_type = 'paid' then activity_duration else 0 end as paid_duration
from useractivity
)
select user_id, round(avg(paid_duration),2) as paid_avg_duration
from user_activity_details
where activity_type = 'paid'
group by user_id;
*/
