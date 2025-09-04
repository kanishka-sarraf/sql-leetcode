-- group the users by the number of tweets they posted in 2022 and count the number of users in each group.

SELECT t.tweet_bucket,
       Count(t.user_id) AS users_num
FROM   (SELECT user_id,
               Count(tweet_id) AS tweet_bucket
        FROM   tweets
        WHERE  Year(tweet_date) = 2022
        GROUP  BY user_id) t
GROUP  BY t.tweet_bucket; 
