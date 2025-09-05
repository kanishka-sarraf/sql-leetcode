# Write your MySQL query statement below
/*
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
*/

/*
select 
    machine_id,
    round(avg(end_time-start_time),3) as processing_time
from (
select 
machine_id, process_id, timestamp as end_time, 
lag(timestamp,1) over(partition by machine_id, process_id 
                            order by timestamp asc) as start_time
from activity
) t 
where t.start_time is not null
group by machine_id;
*/

select s.machine_id , round(avg(e.timestamp-s.timestamp),3) as processing_time 
from activity s 
join activity e on s.machine_id = e.machine_id 
                    and s.process_id = e.process_id
                    and s.activity_type= 'start'
                    and e.activity_type = 'end'
group by s.machine_id; 