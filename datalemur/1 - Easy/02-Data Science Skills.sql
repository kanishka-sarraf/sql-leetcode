SELECT candidate_id
FROM   (SELECT candidate_id,
               Group_concat(skill) AS skill_set
        FROM   candidates
        GROUP  BY candidate_id
        HAVING skill_set LIKE '%Python%'
               AND skill_set LIKE '%Tableau%'
               AND skill_set LIKE '%PostgreSQL%') t
ORDER  BY candidate_id ASC; 
