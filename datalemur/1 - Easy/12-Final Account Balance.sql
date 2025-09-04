/*
Given a table containing information about bank deposits and withdrawals made using Paypal, write a query to retrieve the final account balance 
for each account, taking into account all the transactions recorded in the table with the assumption that there are no missing transactions.
*/

-- solution (my approach)
select account_id, sum(amt) as final_balance  from (
SELECT *, 
case when transaction_type = 'Deposit' then amount
     when transaction_type = 'Withdrawal' then amount*(-1)
end as amt
FROM transactions) t
group by account_id;

-- solution2
SELECT
  account_id,
  SUM(
    CASE 
      WHEN transaction_type = 'Deposit' THEN amount
      ELSE -amount END
  ) AS final_balance
FROM transactions
GROUP BY account_id;
