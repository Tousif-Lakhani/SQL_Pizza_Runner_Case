# Pizza Metrics & Runner Experience Analysis
This repository contains SQL queries analyzing pizza ordering metrics and delivery performance for a fictional pizza delivery service, using the pizza_runner database. The project addresses various business questions, such as order volume, customer preferences, runner performance, and customer satisfaction.

# Overview
This project uses SQL to provide detailed insights into two primary areas:

1 - **Pizza Metrics**: Examines customer orders, delivery stats, and customer customization preferences.

2 - **Runner and Customer Experience**: Analyzes runner performance, delivery times, and customer satisfaction metrics.

# Database Structure
The analyses rely on the following tables:

- **customer_orders**: Details of orders, including pizza type and customization.
- **runner_orders**: Information about delivery status, distance traveled, and duration.
- **pizza_names**: Maps pizza IDs to pizza types.
- **runners**: Stores runner signup and registration details.

# Analysis Sections
**A. Pizza Metrics**

Key questions addressed in this analysis:

- Order Volume: Total pizzas ordered, unique orders, and volume by hour and day.
- Runner Success Rates: Count of successful deliveries by runner.
- Pizza Preferences: Breakdown of pizza types ordered by each customer.
- Order Customizations: Analysis of orders with and without changes (exclusions/extras).

**B. Runner and Customer Experience**

Key questions addressed in this analysis:

- Runner Sign-ups: Weekly signup count.
- Order Preparation Time: Average pickup times and correlation with order size.
- Delivery Distance and Speed: Average distance and speed metrics per runner.
- Delivery Success Rates: Success percentage for each runner.

# How to Use

1 - Clone this repository to your local environment.

2 - Ensure access to the pizza_runner database with the tables described above.

3 - Run each SQL file (pizza_metrics.sql and runner_experience.sql) sequentially in your SQL environment.
