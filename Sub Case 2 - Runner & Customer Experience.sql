-- 													B. Runner and Customer Experience

USE pizza_runner;

-- 1 - How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

SELECT
WEEK(registration_date) AS week,
COUNT(runner_id) AS runner_count
FROM runners
GROUP BY week;

-- 2 - What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

WITH cte AS (
SELECT r.runner_id,  TIME(c.order_time) AS Order_Time, TIME(pickup_time) AS Pickup_Time, TIMEDIFF(r.Pickup_Time, c.Order_Time) AS time_diff
FROM customer_orders AS c
JOIN runner_orders AS r
ON c.order_id = r.order_id
WHERE r.pickup_time IS NOT NULL)

SELECT 
    runner_id,
   --  AVG(time_diff)
   ROUND(AVG(TIME_TO_SEC(time_diff)) / 60,2) AS avg_time_diff_minutes
FROM cte
GROUP BY runner_id;

-- 3 - Is there any relationship between the number of pizzas and how long the order takes to prepare?

WITH cte AS (
SELECT c.customer_id, TIMEDIFF(r.pickup_time, c.order_time) AS time_diff
FROM customer_orders AS c
JOIN runner_orders AS r
ON c.order_id = r.order_id
WHERE r.pickup_time IS NOT NULL
ORDER BY c.customer_id)

SELECT customer_id, COUNT(customer_id) AS freq,
ROUND(AVG(TIME_TO_SEC(time_diff)) / 60,2) AS avg_time_diff_minutes
FROM cte
GROUP BY customer_id
ORDER BY freq;

-- 4 - What was the average distance travelled for each customer?

SELECT c.customer_id, ROUND(AVG(r.distance),2) AS Average_distance
FROM customer_orders AS c
JOIN runner_orders AS r
ON c.order_id = r.order_id
WHERE r.distance IS NOT NULL
GROUP BY c.customer_id;

-- 5 - What was the difference between the longest and shortest delivery times for all orders?

SELECT MAX(duration) - MIN(duration) AS Time_difference
FROM runner_orders;

-- 6 -What was the average speed for each runner for each delivery and do you notice any trend for these values?

SELECT  runner_id, ROUND(AVG(distance/duration),2) AS speed
FROM runner_orders
WHERE distance IS NOT NULL
GROUP BY runner_id;

-- 7 - What is the successful delivery percentage for each runner?

WITH cte AS (
SELECT  r.runner_id, c.order_id, r.cancellation,
CASE WHEN r.cancellation IS NULL THEN 1 ELSE 0 END AS No_canc_count,
CASE WHEN r.cancellation IS NOT NULL THEN 1 ELSE 0 END AS canc_count
FROM customer_orders AS c
JOIN runner_orders AS r
ON c.order_id = r.order_id
ORDER BY r.runner_id)

SELECT runner_id,
(SUM(No_canc_count) / (SUM(No_canc_count) + SUM(canc_count))*100) AS 'Success_%'
FROM cte
GROUP BY runner_id;
