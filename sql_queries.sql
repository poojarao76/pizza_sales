-- TOTAL REVENUE:

SELECT SUM(total_price) AS total_revenue
FROM pizza_sales

-- AVERAGE ORDER VALUE:
  
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS average_order_value
FROM pizza_sales

-- TOTAL PIZZAS SOLD:

SELECT SUM(quantity) AS total_pizza_sold
FROM pizza_sales

-- TOTAL ORDERS PLACED:

SELECT count(DISTINCT order_id)
FROM pizza_sales

-- AVERAGE PIZZA PER ORDER:

SELECT CAST(CAST(SUM(quantity) AS DECIMAL (10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL (10, 2))AS DECIMAL) 
AS avg_pizza_per_order
FROM pizza_sales

-- DAILY TRENDS FOR TOTAL ORDERS:

SELECT dayname(order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date)

-- MONTHLY TRENDS FOR TOTAL ORDERS:

SELECT COUNT(DISTINCT order_id) AS total_orders, MONTHNAME(order_date) AS order_month
FROM pizza_sales
GROUP BY MONTHNAME(order_date)

-- PERCENTAGE OF SALES BY PIZZA CATEGORY:

SELECT pizza_category, SUM(quantity), SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)
AS total_sales
FROM pizza_sales
GROUP BY pizza_category

-- THIS FOR JANUARY MONTH SALES:

SELECT pizza_category,SUM(total_price) AS total_sales, 
SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales WHERE MONTH(order_date) = 1) AS total_sales
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_category

--  THIS IS FOR HOURLY SALES:

SELECT HOUR(order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY  HOUR(order_time)

-- PERCENTAGE OF SALES BY PIZZA SIZE:

SELECT pizza_size, SUM(total_price) as total_sales , SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)
AS salesby_pizza_size
FROM pizza_sales
GROUP BY pizza_size

-- THIS IS FIRST QUATER SALES:

SELECT pizza_size, SUM(total_price) as total_sales , SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales WHERE QUARTER(order_date) = 1)
AS salesby_pizza_size
FROM pizza_sales
WHERE quarter(order_date) = 1
GROUP BY pizza_size

-- TOP 5 BESTSELLERS BY REVENUE:

SELECT pizza_name, SUM(total_price) AS total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue DESC limit 5

-- 1. TOP 5 WORST SELLERS BY REVENUE:

SELECT pizza_name, SUM(total_price) AS total_revenue FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_revenue ASC limit 5

-- TOP 5 BESTSELLERS BY QUANTITY:

SELECT pizza_name, SUM(quantity) AS total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity desc limit 5

-- TOP 5 WORST SELLERS BY QUANTITY:

SELECT pizza_name, SUM(quantity) AS total_quantity FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity asc limit 5

-- TOP 5 BESTSELLERS BY ORDERS:

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders DESC limit 5

-- 1. TOP 5 WORST SELLERS BY ORDERS:

SELECT pizza_name, COUNT(DISTINCT order_id) AS total_orders FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders ASC limit 5
