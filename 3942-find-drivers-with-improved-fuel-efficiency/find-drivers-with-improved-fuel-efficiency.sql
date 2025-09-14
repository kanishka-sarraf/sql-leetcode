# Write your MySQL query statement below
with first_second_half_efficiency as (
    select 
        driver_id, 
        avg(case when month(trip_date) between 1 and 6 then distance_km / fuel_consumed else null end) as first_half_avg,
        avg(case when month(trip_date) between 7 and 12 then distance_km / fuel_consumed else null end) as second_half_avg
    from trips
    group by driver_id
    having first_half_avg is not null and second_half_avg is not null and second_half_avg > first_half_avg
)
select 
    d.*, 
    round(e.first_half_avg,2) as first_half_avg, 
    round(e.second_half_avg,2) as second_half_avg, 
    round(e.second_half_avg - e.first_half_avg,2) as efficiency_improvement 
from first_second_half_efficiency e
join drivers d on e.driver_id = d.driver_id
order by efficiency_improvement desc, d.driver_name asc;
