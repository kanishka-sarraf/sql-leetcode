# Write your MySQL query statement below
select 
    t.machine_id, 
    round(avg(end_time-start_time),3) as processing_time
from (
select 
    machine_id, process_id,
    sum(case when activity_type = 'start' then timestamp else 0 end) as start_time,
    sum(case when activity_type = 'end' then timestamp else 0 end) as end_time
from activity
group by machine_id, process_id
) t
group by t.machine_id;