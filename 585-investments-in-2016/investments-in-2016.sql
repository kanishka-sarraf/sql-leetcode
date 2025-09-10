# Write your MySQL query statement below
/*
-- solution1
select round(sum(tiv_2016),2) as tiv_2016 from (
    select *, 
    count(*) over(partition by tiv_2015) as tiv_2015_count,
    count(*) over(partition by lat, lon) as lat_lon_count
    from insurance
) t
where tiv_2015_count > 1 and lat_lon_count = 1;
*/

select round(sum(tiv_2016),2) as tiv_2016
from insurance 
where 
tiv_2015 in(
    select tiv_2015 from insurance
    group by tiv_2015
    having count(*)>1
) and 
(lat, lon) in(
    select lat, lon from insurance
    group by lat, lon
    having count(*)=1
);