# Write your MySQL query statement below
/*
-- solution1
with user_movie_rating as (
    select m.*, u.*, mr.rating, mr.created_at
    from movierating mr
    join movies m on m.movie_id = mr.movie_id
    join users u on u.user_id = mr.user_id
),
user_review as (
    select *, dense_rank() over(order by cnt desc, name asc) as rnk
    from (
        select user_id, name, count(*) as cnt
        from user_movie_rating
        group by user_id
    ) t1
),
movie_rating as (
    select *, dense_rank() over(order by avg_rating desc, title asc) as rnk
    from (
        select movie_id, title, avg(rating) as avg_rating 
        from user_movie_rating
        where date_format(created_at,'%Y-%m') = '2020-02'
        group by movie_id
    ) t2
)
select name as results from user_review
where rnk = 1
union all
select title from movie_rating
where rnk = 1;
*/

select * from (
select u.name as results
from movierating mr
join users u on u.user_id = mr.user_id
group by u.user_id
order by count(*) desc, u.name
limit 1
) t1
union all
select * from (
select m.title
from movierating mr
join movies m on m.movie_id = mr.movie_id
where date_format(created_at,'%Y-%m') = '2020-02'
group by m.movie_id
order by avg(rating) desc, m.title
limit 1
) t2;

