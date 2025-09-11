# Write your MySQL query statement below
select 
    date_format(trans_date,'%Y-%m') as month, 
    country, 
    count(*) as trans_count,
    count(approved_amount) as approved_count,
    sum(amount) as trans_total_amount,
    coalesce(sum(approved_amount),0) as approved_total_amount  
from (
    select *,
    case when state = 'approved' then amount else null end as approved_amount
    from transactions
) t
group by year(trans_date), 
            month(trans_date), 
                country;