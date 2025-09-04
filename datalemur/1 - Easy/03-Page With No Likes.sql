-- Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

-- solution 1 (my approach)
select page_id from pages 
where page_id not in(SELECT distinct page_id 
                     FROM page_likes)
order by page_id asc;

-- solution 2
SELECT page_id
FROM pages
EXCEPT
SELECT page_id
FROM page_likes
order by page_id;

-- solution 3
SELECT pages.page_id
FROM pages
LEFT OUTER JOIN page_likes AS likes
  ON pages.page_id = likes.page_id
WHERE likes.page_id IS NULL
order by page_id;

-- solution 4
SELECT page_id
FROM pages
WHERE NOT EXISTS (
  SELECT page_id
  FROM page_likes AS likes
  WHERE likes.page_id = pages.page_id
)
order by page_id;
