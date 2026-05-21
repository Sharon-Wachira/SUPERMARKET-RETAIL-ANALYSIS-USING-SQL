--1. Show the product name and price of all products in the Groceries category
SELECT product_name, price
FROM products
WHERE category = 'Groceries';

--2. Find all customers from Kisumu. Show full name, city, and signup date
SELECT full_name, city, signup_date
FROM customers
WHERE city = 'Kisumu';

--3. Products under KES 300, sorted cheapest first
SELECT product_name, price
FROM products
WHERE price < 300
ORDER BY price ASC;

--4. The 3 cheapest products in the shop
SELECT product_name, price
FROM products
ORDER BY price ASC
LIMIT 3;

--5. Male customers who signed up earliest
SELECT full_name, signup_date
FROM customers
WHERE gender = 'Male'
ORDER BY signup_date ASC
LIMIT 5;

--6. Most expensive beverage
SELECT product_name, category
FROM products
WHERE category = 'Beverages'
ORDER BY price DESC
LIMIT 1;


-- CLASS 2

--1. How many orders are in the database in total?
SELECT COUNT(*) AS total_orders
FROM orders;

--2. How many orders exist for each status?
SELECT status, COUNT(*) AS count
FROM orders
GROUP BY status;


--3.How many customers in each city? Highest to lowest.
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;


--4.  Total stock value and average product price (one query)
SELECT ROUND(SUM(price * stock_qty), 2) AS total_stock_value,
       ROUND(AVG(price), 2) AS avg_price
FROM products;

--5. Average salary per department
SELECT department, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department;


--6.  Cheapest and most expensive product per category
SELECT category,
       MIN(price) AS cheapest,
       MAX(price) AS most_expensive
FROM products
GROUP BY category;


--7. — Which cities have more than 25 customers?
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 25;

--8. All M-Pesa orders with customer name and city
SELECT o.order_id, c.full_name, c.city
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.payment_method = 'M-Pesa';


--9. How many orders came from each city? Highest to lowest.
SELECT c.city, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;

--10. Customers who have placed 5 or more orders
SELECT c.full_name, c.city, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING COUNT(o.order_id) >= 5
ORDER BY order_count DESC;


-- CLASS 3;

--1.Show all customers. How many are there?
SELECT * FROM customers;

SELECT COUNT(*) AS total_customers FROM customers;


--2. Full name and city, ordered alphabetically by city (A–Z)
SELECT full_name, city
FROM customers
ORDER BY city ASC;


--3. Top 5 most expensive products
SELECT product_name, price
FROM products
ORDER BY price DESC
LIMIT 5;


--4. Female customers who signed up after 1st July 2023
SELECT full_name, city, signup_date
FROM customers
WHERE gender = 'Female'
AND signup_date > '2023-07-01';


--5. Orders per payment method, most to least used
SELECT payment_method, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;


--6. Total revenue from all order items
SELECT ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM order_items;


--7. Each order with customer name and city (first 10)
SELECT o.order_id, o.order_date, c.full_name, c.city
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LIMIT 10;


--8. Order items with product names (first 10)
SELECT oi.item_id, oi.order_id, p.product_name, oi.quantity, oi.unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LIMIT 10;


--9. Total revenue per product category, highest to lowest
SELECT p.category,
       ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;
