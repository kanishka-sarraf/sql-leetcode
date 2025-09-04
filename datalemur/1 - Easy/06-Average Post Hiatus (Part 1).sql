/*
Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between 
each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each 
user's first and last post.
*/

-- solution 1
SELECT user_id,
       Datediff(last_post, first_post) AS days_between
FROM   (SELECT user_id,
               post_date,
               Count(post_id) OVER(partition BY user_id) AS post_count,
               Min(post_date) OVER(partition BY user_id) AS first_post,
               Max(post_date) OVER(partition BY user_id) AS last_post
        FROM   posts
        WHERE  Year(post_date) = 2021) t
WHERE  t.post_count >= 2
GROUP  BY user_id; 

-- solution 2
SELECT user_id,  DATEDIFF(MAX(DATE(post_date)), MIN(DATE(post_date))) AS days_between
FROM posts
where year(post_date) = 2021
group by user_id
having count(post_id)>=2; 

