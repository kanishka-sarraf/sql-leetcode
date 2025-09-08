# Write your MySQL query statement below
/*
select *
from users
where length(email) - length(replace(email, '@', '')) = 1 
    and substring_index(email,'@',1) regexp '^[a-zA-Z0-9_]*$'
    and substring_index(email,'@',-1) regexp '^[a-zA-Z]*.com$';
order by user_id asc

failing for: alice@examplecom  
*/

SELECT *
FROM users
WHERE 
    LENGTH(email) - LENGTH(REPLACE(email, '@', '')) = 1
    AND SUBSTRING_INDEX(email, '@', 1) REGEXP '^[a-zA-Z0-9_]+$'
    AND SUBSTRING_INDEX(SUBSTRING_INDEX(email, '@', -1), '.', 1) REGEXP '^[a-zA-Z]+$'
    AND RIGHT(email, 4) = '.com'
ORDER BY user_id ASC;