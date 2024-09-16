
-- 			     												PIZZA METRICS
USE pizza_runner;

-- 1 -  How many pizzas were ordered?

SELECT COUNT(pizza_id) AS 'Total_Pizzas' FROM customer_orders;

-- 2 - How many unique customer orders were made?

SELECT COUNT(DISTINCT order_id) AS Unique_Orders FROM customer_orders;

-- 3 - How many successful orders were delivered by each runner?

SELECT runner_id, COUNT(pickup_time) AS 'Successful_Orders' FROM runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;

-- 4 - How many of each type of pizza was delivered?

SELECT pizza_id,
COUNT(pizza_id) as total_items
FROM customer_orders 
WHERE order_id NOT IN (6,9)
GROUP BY pizza_id;

--  5 - How many Vegetarian and Meatlovers were ordered by each customer?

WITH cte2 AS(
WITH cte AS (
SELECT customer_id, pizza_id,
COUNT(pizza_id) OVER (PARTITION BY customer_id, pizza_id) AS freq
FROM customer_orders)

SELECT * FROM cte
GROUP BY customer_id, pizza_id)

SELECT c.customer_id, c.pizza_id, pn.pizza_name, c.freq
FROM cte2 AS c, pizza_names AS pn
WHERE c.pizza_id = pn.pizza_id;

-- 6 - What was the maximum number of pizzas delivered in a single order?

SELECT c.order_id, COUNT(c.order_id) AS Number_of_pizzas
FROM customer_orders AS c
INNER JOIN runner_orders AS r
ON c.order_id = r.order_id
WHERE r.distance IS NOT NULL
GROUP BY c.order_id;

-- 7 - For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

WITH cte AS (
SELECT c.customer_id, 
(CASE WHEN exclusions OR extras IS NOT NULL THEN 1 ELSE 0 END) AS changes, 
(CASE WHEN exclusions IS NULL AND extras IS NULL THEN 1 ELSE 0 END) AS no_changes
FROM customer_orders AS c
INNER JOIN runner_orders AS r
ON c.order_id = r.order_id
WHERE r.distance IS NOT NULL
ORDER BY c.customer_id)

SELECT customer_id,
SUM(changes) AS total_pizzas_with_changes,
SUM(no_changes) AS total_pizzas_without_changes
FROM cte
GROUP BY customer_id;

-- 8 - How many pizzas were delivered that had both exclusions and extras?

WITH cte AS (
SELECT c.customer_id,  
(CASE WHEN exclusions IS NOT NULL AND extras IS NOT NULL THEN 1 ELSE 0 END) AS changes
FROM customer_orders AS c
INNER JOIN runner_orders AS r
ON c.order_id = r.order_id
WHERE r.distance IS NOT NULL
ORDER BY c.customer_id)

SELECT customer_id , SUM(changes) AS Total_changes FROM cte
GROUP BY customer_id;

-- 9 - What was the total volume of pizzas ordered for each hour of the day?

SELECT HOUR(order_time) AS hour, 
COUNT(HOUR(order_time)) AS freq
FROM customer_orders
GROUP BY HOUR(order_time);

-- 10 - What was the volume of orders for each day of the week?

WITH cte AS (
SELECT
WEEKDAY(order_time) AS Days,
COUNT(WEEKDAY(order_time)) Volume
FROM
customer_orders
GROUP BY WEEKDAY(order_time))

SELECT 
CASE WHEN Days = 2 THEN "Wednesday"
WHEN Days = 3 THEN "Thursday"
WHEN Days = 4 THEN "Friday"
WHEN Days = 5 THEN "Saturday"
END AS Days_Ordered, Volume
From cte;
