# Write your MySQL query statement below
select 
    e.*, 
    count(distinct meeting_week) as meeting_heavy_weeks 
from (
    select 
        employee_id, 
        week(meeting_date,1) as meeting_week,  -- week: monday to sunday
        sum(duration_hours) as total_duration
    from meetings
    group by employee_id, week(meeting_date,1)
    having total_duration>20
) t 
join employees e on e.employee_id = t.employee_id
group by e.employee_id
having meeting_heavy_weeks >= 2
order by meeting_heavy_weeks desc, e.employee_name asc;


/*
select 
        employee_id, 
        meeting_date,
        week(meeting_date) as meeting_week,
        week(meeting_date,1) as meeting_week_mon,
        dayofweek(meeting_date) as dy,
        dayname(meeting_date) as dyn
        -- sum(duration_hours) as total_duration
    from meetings;
    -- group by employee_id, week(meeting_date);
*/