-- group the users by the number of tweets they posted in 2022 and count the number of users in each group.

-- solution (my approach)
SELECT t.tweet_bucket,
       Count(t.user_id) AS users_num
FROM   (SELECT user_id,
               Count(tweet_id) AS tweet_bucket
        FROM   tweets
        WHERE  Year(tweet_date) = 2022
        GROUP  BY user_id) t
GROUP  BY t.tweet_bucket; 

-- solution 2
WITH total_tweets AS (
  SELECT 
    user_id, 
    COUNT(tweet_id) AS tweet_count_per_user
  FROM tweets 
  WHERE tweet_date BETWEEN '2022-01-01' 
    AND '2022-12-31' 
  GROUP BY user_id) 
  
SELECT 
  tweet_count_per_user AS tweet_bucket, 
  COUNT(user_id) AS users_num 
FROM total_tweets 
GROUP BY tweet_count_per_user;
