-- Sales Order Dataset - Case Study

-- Problem Statements:

-- 1. Identify the total no of products sold
select sum(quantity) as quantity_sold from sales_order;

-- 2. Other than Completed, display the available delivery status's
 select distinct status from sales_order where status != 'Completed';
 
-- 3. Display the order id, order_date and product_name for all the completed orders.
select s.order_id, s.order_date, p.name
from sales_order s 
join products p on s.prod_id = p.id 
where s.status = 'Completed';

-- 4. Sort the above query to show the earliest orders at the top. Also display the customer who purchased these orders.
select s.order_id, s.order_date, p.name as product_name, c.name as customer_name
from sales_order s 
join products p on s.prod_id = p.id 
join customers c on s.customer_id = c.id
where s.status = 'Completed'
order by s.order_date asc;

-- 5. Display the total no of orders corresponding to each delivery status
select status, count(*) from sales_order group by status;

-- 6. For orders purchasing more than 1 item, how many are still not completed?
select count(order_id) from sales_order where quantity > 1 and status != 'Completed';

/* 7. Find the total no of orders corresponding to each delivery status by ignoring the case in delivery status. 
Status with highest no of orders should be at the top. */
select lower(status), count(*) as order_count 
from sales_order 
group by lower(status)
order by order_count desc;

select updated_status, count(*)  as order_count from (
select status, case when status = 'completed' then 'Completed' else status end as updated_status from sales_order) t
group by updated_status
order by order_count desc;

-- 8. Write a query to identify the total products purchased by each customer
select c.id, c.name, coalesce(sum(s.quantity),0) as total_purchase
from customers c 
left join sales_order s on c.id = s.customer_id
group by c.id, c.name; 

-- 9. Display the total sales and average sales done for each day.
select s.order_date, sum(p.price*s.quantity) as total_sales, avg(p.price*s.quantity) as avg_sales
from sales_order s
join products p on s.prod_id = p.id
group by s.order_date
order by s.order_date asc;

-- 10. Display the customer name, employee name and total sale amount of all orders which are either on hold or pending.
SELECT 
    c.name AS customer_name,
    e.name AS employee_name,
    sum(p.price * s.quantity) AS total_sales_amount
FROM sales_order s
JOIN customers c ON s.customer_id = c.id
JOIN employees e ON s.emp_id = e.id
JOIN products p ON s.prod_id = p.id
WHERE s.status IN ('On Hold' , 'Pending')
group by c.name, e.name;

/* 11. Fetch all the orders which were neither completed/pending or were handled by the employee Abrar. 
Display employee name and all details of order. */
select e.name as employee_name, s.*
from sales_order s
join employees e on s.emp_id = e.id
where s.status not in('Completed','Pending') or e.name = 'Abrar Khan';

-- 12. Fetch the orders which cost more than 2000 but did not include the macbook pro. Print the total sale amount as well.
select s.*, p.name, p.price * s.quantity as order_value
from sales_order s
join products p on s.prod_id = p.id
where p.name != 'Macbook Pro' and (p.price * s.quantity)>2000;

-- 13. Identify the customers who have not purchased any product yet.
select * from customers where id not in(select distinct customer_id from sales_order);

select c.*
from customers c
left join sales_order s on c.id = s.customer_id
where s.order_id is null;

/* 14. Write a query to identify the total products purchased by each customer. Return all customers irrespective of whether 
they have made a purchase or not. Sort the result with highest no of orders at the top. */
select c.id, c.name, coalesce(sum(s.quantity),0) as total_purchase
from customers c 
left join sales_order s on c.id = s.customer_id
group by c.id, c.name
order by total_purchase desc; 

/* 15. Corresponding to each employee, display the total sales they made of all the completed orders. 
Display total sales as 0 if an employee made no sales yet. */
select e.name as employee_name, 
sum(case when s.status = 'Completed' then p.price*s.quantity else 0 end) as total_sales 
from employees e
left join sales_order s on e.id = s.emp_id
left join products p on s.prod_id = p.id
group by e.name
order by total_sales desc;

select e.name as employee_name, 
coalesce(sum(p.price*s.quantity),0) as total_sales
from employees e
left join sales_order s on e.id = s.emp_id and status = 'Completed'
left join products p on s.prod_id = p.id
group by e.name
order by total_sales desc;

/* 16. Re-write the above query so as to display the total sales made by each employee corresponding to each customer. 
If an employee has not served a customer yet then display "-" under the customer. */
select e.name as employee_name, coalesce(c.name,'-') as customer_name,
sum(case when s.status = 'Completed' then p.price*s.quantity else 0 end) as total_sales 
from employees e
left join sales_order s on e.id = s.emp_id
left join products p on s.prod_id = p.id
left join customers c on s.customer_id = c.id
group by e.name, c.name
order by e.name, c.name;

select e.name as employee_name, coalesce(c.name,'-') as customer_name,
coalesce(sum(p.price*s.quantity),0) as total_sales
from employees e
left join sales_order s on e.id = s.emp_id and status = 'Completed'
left join products p on s.prod_id = p.id
left join customers c on s.customer_id = c.id
group by e.name, c.name
order by e.name, c.name;

-- 17. Re-write above query so as to display only those records where the total sales is above 1000
select e.name as employee_name, coalesce(c.name,'-') as customer_name,
sum(case when s.status = 'Completed' then p.price*s.quantity else 0 end) as total_sales 
from employees e
left join sales_order s on e.id = s.emp_id
left join products p on s.prod_id = p.id
left join customers c on s.customer_id = c.id
group by e.name, c.name
having total_sales>1000
order by e.name, c.name;

-- 18. Identify employees who have served more than 2 customer.
select e.name as employee_name, count(distinct s.customer_id) as unique_customers
from employees e
left join sales_order s on e.id = s.emp_id
group by e.name
having unique_customers>2;

-- 19. Identify the customers who have purchased more than 5 products
select c.id, c.name, sum(s.quantity) as total_purchase
from customers c 
left join sales_order s on c.id = s.customer_id
group by c.id, c.name
having total_purchase>5; 

-- 20. Identify customers whose average purchase cost exceeds the average sale of all the orders
select distinct t.name as customer_name, t.customer_avg, t.overall_avg from (
select c.name, s.quantity, p.price, 
avg(s.quantity*p.price) over(partition by c.id) as customer_avg,
avg(s.quantity*p.price) over() as overall_avg
from sales_order s 
join products p on s.prod_id = p.id
join customers c on s.customer_id = c.id) t
where t.customer_avg > t.overall_avg;

select c.name as customer_name, avg(s.quantity * p.price) as customer_avg
from sales_order s
join customers c on c.id = s.customer_id
join products p on p.id = s.prod_id
group by c.name
having avg(s.quantity * p.price) > (select avg(s.quantity * p.price)
								  from sales_order s
								  join products p on p.id = s.prod_id);