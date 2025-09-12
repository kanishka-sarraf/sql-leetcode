# Write your MySQL query statement below
select person_name from (
    select *,
    sum(weight) over(order by turn asc 
                        rows between unbounded preceding and current row) as cum_weight
    from queue
) t
where t.cum_weight <= 1000
order by turn desc limit 1;