/*
Assume you're given a table containing job postings from various companies on the LinkedIn platform. 
Write a query to retrieve the count of companies that have posted duplicate job listings.

Definition: Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
*/

-- solution
WITH duplicate_job_posting AS 
(
  SELECT company_id, title, description,
         Count(*) AS job_posting
  FROM   job_listings
  GROUP  BY company_id, title, description
  HAVING Count(job_id) > 1
)
SELECT Count(*) AS duplicate_companies
FROM   duplicate_job_posting; 

-- solution2
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
) AS job_count_cte
WHERE job_count > 1;
