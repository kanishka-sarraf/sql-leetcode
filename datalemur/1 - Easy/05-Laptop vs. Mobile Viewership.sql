/*
Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. 
Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.
*/

-- solution
SELECT
sum(case when device_type = 'laptop' then 1 else 0 end) as laptop_views,
sum(case when device_type in('tablet','phone') then 1 else 0 end) as mobile_views
FROM viewership;
