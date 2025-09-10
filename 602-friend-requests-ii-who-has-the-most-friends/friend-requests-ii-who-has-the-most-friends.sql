# Write your MySQL query statement below
select id, sum(num) as num from (
    select accepter_id as id, count(*) as num
    from requestaccepted
    group by accepter_id
    union all
    select requester_id as id, count(*) as num
    from requestaccepted
    group by requester_id
) t
group by id
order by num desc
limit 1;