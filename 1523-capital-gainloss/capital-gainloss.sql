# Write your MySQL query statement below
select stock_name, sum(change_price) as capital_gain_loss from (
select *,
case when operation = 'Sell' then price else -1*price end as change_price
from stocks
) t
group by stock_name;