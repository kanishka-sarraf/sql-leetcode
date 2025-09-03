create database techtfq;
use techtfq;

-- Drop tables if they exist
DROP TABLE IF EXISTS sales_order;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- Create products table
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  price FLOAT,
  release_date DATE
);

-- Insert data into products
INSERT INTO products 
VALUES (DEFAULT, 'iPhone 15', 800, STR_TO_DATE('22-08-2023','%d-%m-%Y'));
INSERT INTO products 
VALUES (DEFAULT, 'Macbook Pro', 2100, STR_TO_DATE('12-10-2022','%d-%m-%Y'));
INSERT INTO products 
VALUES (DEFAULT, 'Apple Watch 9', 550, STR_TO_DATE('04-09-2022','%d-%m-%Y'));
INSERT INTO products 
VALUES (DEFAULT, 'iPad', 400, STR_TO_DATE('25-08-2020','%d-%m-%Y'));
INSERT INTO products 
VALUES (DEFAULT, 'AirPods', 420, STR_TO_DATE('30-03-2024','%d-%m-%Y'));

-- Create customers table
CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(30)
);

-- Insert data into customers
INSERT INTO customers VALUES (DEFAULT, 'Meghan Harley', 'mharley@demo.com');
INSERT INTO customers VALUES (DEFAULT, 'Rosa Chan', 'rchan@demo.com');
INSERT INTO customers VALUES (DEFAULT, 'Logan Short', 'lshort@demo.com');
INSERT INTO customers VALUES (DEFAULT, 'Zaria Duke', 'zduke@demo.com');

-- Create employees table
CREATE TABLE employees (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100)
);

-- Insert data into employees
INSERT INTO employees VALUES (DEFAULT, 'Nina Kumari');
INSERT INTO employees VALUES (DEFAULT, 'Abrar Khan');
INSERT INTO employees VALUES (DEFAULT, 'Irene Costa');

-- Create sales_order table
CREATE TABLE sales_order (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  order_date DATE,
  quantity INT,
  prod_id INT,
  status VARCHAR(20),
  customer_id INT,
  emp_id INT,
  FOREIGN KEY (prod_id) REFERENCES products(id),
  FOREIGN KEY (customer_id) REFERENCES customers(id),
  FOREIGN KEY (emp_id) REFERENCES employees(id)
);

-- Insert data into sales_order
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('01-01-2024','%d-%m-%Y'), 2, 1, 'Completed', 1, 1);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('01-01-2024','%d-%m-%Y'), 3, 1, 'Pending', 2, 2);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('02-01-2024','%d-%m-%Y'), 3, 2, 'Completed', 3, 2);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('03-01-2024','%d-%m-%Y'), 3, 3, 'Completed', 3, 2);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('04-01-2024','%d-%m-%Y'), 1, 1, 'Completed', 3, 2);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('04-01-2024','%d-%m-%Y'), 1, 3, 'Completed', 2, 1);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('04-01-2024','%d-%m-%Y'), 1, 2, 'On Hold', 2, 1);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('05-01-2024','%d-%m-%Y'), 4, 2, 'Rejected', 1, 2);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('06-01-2024','%d-%m-%Y'), 5, 5, 'Completed', 1, 2);
INSERT INTO sales_order 
VALUES (DEFAULT, STR_TO_DATE('06-01-2024','%d-%m-%Y'), 1, 1, 'Cancelled', 1, 1);

-- View data
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;
