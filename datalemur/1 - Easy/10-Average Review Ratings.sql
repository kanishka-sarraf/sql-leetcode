/*
Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. 
The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. 
Sort the output first by month and then by product ID.
*/

-- solution
SELECT 
  extract(month from submit_date) as mth, 
  product_id, 
  round(avg(stars),2) as avg_stars
FROM reviews
group by extract(month from submit_date), product_id
order by mth, product_id;

