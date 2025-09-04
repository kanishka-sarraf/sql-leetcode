/*
Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. 
Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

Assumption: No two users have sent the same number of messages in August 2022.
*/

-- solution
SELECT 
  sender_id, 
  count(message_id) as message_count 
FROM messages
where sent_date between '2022-08-01' and '2022-08-31'
-- where EXTRACT(MONTH FROM sent_date) = '8' AND EXTRACT(YEAR FROM sent_date) = '2022' 
group by sender_id
order by message_count DESC
limit 2;
