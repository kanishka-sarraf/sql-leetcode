# Write your MySQL query statement below
/*
-- solution1
with refund_details as (
    select 
        customer_id, 
        max(transaction_date) as latest_transaction_date, 
        min(transaction_date) as first_transaction_date, 
        sum(case when transaction_type = 'purchase' then 1 else 0 end) as purchase_transactions,
        sum(case when transaction_type = 'refund' then 1 else 0 end) as refund_transactions,
        count(*) as total_transactions
    from customer_transactions
    group by customer_id
)
select 
    customer_id
from refund_details
where purchase_transactions>=3 
        and datediff(latest_transaction_date,first_transaction_date)>=30
        and (refund_transactions / total_transactions) < 0.2
order by customer_id asc;
*/

SELECT 
    customer_id
FROM (
    SELECT 
        customer_id,
        MAX(transaction_date) AS latest_transaction_date,
        MIN(transaction_date) AS first_transaction_date,
        SUM(transaction_type = 'purchase') AS purchase_transactions,
        SUM(transaction_type = 'refund') AS refund_transactions,
        COUNT(*) AS total_transactions
    FROM customer_transactions
    GROUP BY customer_id
) AS refund_summary
WHERE 
    purchase_transactions >= 3
    AND DATEDIFF(latest_transaction_date, first_transaction_date) >= 30
    AND refund_transactions < total_transactions * 0.2
ORDER BY customer_id;




/*
SELECT customer_id
FROM customer_transactions 
GROUP BY customer_id 
HAVING COUNT( IF(transaction_type = 'purchase', 1,  NULL) ) > 2 
AND DATEDIFF(MAX(transaction_date) , MIN(transaction_date)) > 29 
AND ( COUNT( IF(transaction_type = 'refund' , 1, NULL) ) / COUNT(1) ) < 0.2
ORDER BY customer_id;
*/


