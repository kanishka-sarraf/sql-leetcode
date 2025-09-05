# Write your MySQL query statement below
with single_num as (
    select num, count(num) as num_count
    from mynumbers
    group by num
    having num_count = 1
)
select 
case when (select count(*) from single_num) = 0 then null 
     else (select max(num) from single_num)
end as num;