# Write your MySQL query statement below
SELECT *
FROM users
WHERE mail COLLATE utf8mb3_bin REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$';

-- WHERE mail COLLATE utf8mb4_bin REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$';
-- COLLATION 'utf8mb4_bin' is not valid for CHARACTER SET 'utf8mb3'

-- WHERE BINARY mail REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\\.com$';
-- Character set 'binary' cannot be used in conjunction with 'utf8mb4_general_ci' in call to regexp_like.


/*
select user_id, name, mail from (
select *, 
substring_index(mail,'@',1) as prefix,
substring_index(mail,'@',-1) as domain
from users
) t
where t.domain = 'leetcode.com' and t.prefix regexp '^[a-zA-Z][a-zA-Z0-9_.-]*$';
*/


