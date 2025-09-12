# Write your MySQL query statement below
/*
-- solution1
select stock_name, sum(change_price) as capital_gain_loss from (
select *,
case when operation = 'Sell' then price else -1*price end as change_price
from stocks
) t
group by stock_name;
*/

select stock_name,
sum(case when operation = 'Sell' then price else -1*price end) as capital_gain_loss
from stocks
group by stock_name;