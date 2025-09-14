# Write your MySQL query statement below
/*
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
*/

SELECT 
    e.*, 
    COUNT(*) AS meeting_heavy_weeks
FROM (
    SELECT 
        employee_id, 
        WEEK(meeting_date, 1) AS meeting_week, 
        YEAR(meeting_date) AS meeting_year,  -- Prevent cross-year week clashes
        SUM(duration_hours) AS total_duration
    FROM meetings
    GROUP BY employee_id, YEAR(meeting_date), WEEK(meeting_date, 1)
    HAVING total_duration > 20
) AS heavy_weeks
JOIN employees e ON e.employee_id = heavy_weeks.employee_id
GROUP BY e.employee_id
HAVING COUNT(*) >= 2
ORDER BY meeting_heavy_weeks DESC, e.employee_name ASC;
