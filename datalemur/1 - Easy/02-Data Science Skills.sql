-- You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.
-- Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.

-- solution1
SELECT candidate_id
FROM   (SELECT candidate_id,
               Group_concat(skill) AS skill_set
        FROM   candidates
        GROUP  BY candidate_id
        HAVING skill_set LIKE '%Python%'
               AND skill_set LIKE '%Tableau%'
               AND skill_set LIKE '%PostgreSQL%') t
ORDER  BY candidate_id ASC; 

-- solution2
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;
