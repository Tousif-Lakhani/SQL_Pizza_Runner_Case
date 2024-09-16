
USE pizza_runner2;

-- Cleaning runner_orders Table

-- Cleaning Duration Column
 
ALTER TABLE runner_orders
ADD durationInt INT;

SET SQL_SAFE_UPDATES = 0;
UPDATE runner_orders
SET duration = CASE WHEN duration = 'null' THEN 0 ELSE duration END;

UPDATE runner_orders
SET durationInt = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(duration, ' minutes', ''), ' mins', ''), 'mins', ''), ' minute', ''), 'minutes', '');

alter table runner_orders
modify column durationInt INT;

ALTER TABLE runner_orders
DROP COLUMN duration;

ALTER TABLE runner_orders
RENAME COLUMN durationInt TO duration;

UPDATE runner_orders
SET duration = CASE WHEN duration = 0 THEN NULL ELSE duration END;

-- Cleaning Distance Column

ALTER TABLE runner_orders
ADD distanceInt FLOAT;

UPDATE runner_orders
SET distance = CASE WHEN distance = 'null' THEN 0 ELSE distance END;

UPDATE runner_orders
SET distanceInt =REPLACE(REPLACE(distance, 'km', ''), ' km', '');

UPDATE runner_orders
SET distanceint = CASE WHEN distanceint = 0 THEN NULL ELSE distanceint END;

ALTER TABLE runner_orders
DROP COLUMN distance;

ALTER TABLE runner_orders
RENAME COLUMN distanceInt TO distance;

SELECT * FROM runner_orders;

-- Cleaning Cancellation Column

UPDATE runner_orders
SET cancellation = 
CASE 
	WHEN cancellation = '' THEN NULL 
    WHEN cancellation = 'null' THEN NULL
ELSE cancellation END;

-- CLeaning picup_time Column

UPDATE runner_orders
SET pickup_time = 
CASE 
    WHEN pickup_time = 'null' THEN NULL
ELSE pickup_time END;

-- SELECT * FROM runner_orders;

-- Cleaning customer_orders Table

-- Cleaning Exclusion Column

UPDATE customer_orders
SET exclusions = 
CASE 
	WHEN exclusions = '' THEN NULL
    WHEN exclusions = 'null' THEN null
    ELSE exclusions
    END;

-- Cleaning Extras Column

UPDATE customer_orders
SET extras = 
CASE 
	WHEN extras = '' THEN NULL
    WHEN extras = 'null' THEN null
    ELSE extras
    END;

-- SELECT * FROM customer_orders;




























