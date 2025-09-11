# Write your MySQL query statement below
/*
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
*/

SELECT 
  DATE_FORMAT(trans_date, '%Y-%m') AS month,
  country,
  COUNT(*) AS trans_count,
  SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
  SUM(amount) AS trans_total_amount,
  SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;