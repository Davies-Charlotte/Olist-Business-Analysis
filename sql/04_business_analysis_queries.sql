/*
Business Analysis Queries

Purpose:
Contains SQL queries used to answer key business questions
and generate insights presented in the Olist marketplace analysis.

Analysis areas:
1. Sales trends analysis
2. Product performance analysis
3. Regional performance analysis
4. Seller marketplace health
5. Delivery performance
6. Customer experience analysis

These queries were used to prepare datasets for analysis
and dashboard visualisations.
*/


----------------------------------------------------
-- 1. Sales Trends Analysis
----------------------------------------------------

/*
Purpose:
Analyse monthly revenue, order volume and average order value
to understand marketplace growth trends.
*/


-- Monthly revenue, orders and AOV

SELECT
    SUM(price) AS total_revenue,
    SUM(price)/COUNT(DISTINCT order_id) AS avg_order_value,
    COUNT(DISTINCT customer_unique_id) AS number_of_customers,
    COUNT(DISTINCT seller_id) AS number_of_sellers,
    ROUND(100*(SELECT COUNT(DISTINCT order_id) FROM orders WHERE order_status = 'delivered')/COUNT(DISTINCT order_id), 2) AS pct_orders_delivered

FROM seller_order_table

/*
Total orders: 99,441
Total revenue: 13,591,643.70
Average order value:137.75
Unique customers: 95,420
Sellers: 3095
% of orders delivered successfully: 97.78%
*/

  
-- Revenue and orders over time


WITH monthly_sales AS
(
    SELECT orders.order_id,
    YEAR(order_purchase_timestamp) AS year,
    MONTH(order_purchase_timestamp) AS month,
    price
  FROM orders
  JOIN order_items ON order_items.order_id = orders.order_id
)


  SELECT
    year,
    month,
    COUNT(DISTINCT order_id) AS orders_in_month,
    SUM(price) AS revenue_by_month,
    ROUND(100.0*SUM(price)/(SELECT SUM(price) FROM order_items), 2) AS pct_of_revenue
FROM monthly_sales

GROUP BY year, month
ORDER BY revenue_by_month ASC


----------------------------------------------------
-- 2. Product Performance Analysis
----------------------------------------------------

/*
Purpose:
Analyse product category demand, revenue contribution and
category concentration.
*/

-- Order volume by product category
SELECT
  product_category_name_english,
  COUNT(product_id) AS product_orders_in_category,
  COUNT(DISTINCT product_id) AS distinct_products_ordered_in_category,
  ROUND(100*COUNT(product_id)/(SELECT COUNT(product_id) FROM orders_customers_products),2) AS pct_of_total_orders
FROM orders_customers_products

GROUP BY product_category_name_english
ORDER BY product_orders_in_category DESC


  
-- Revenue by product category
SELECT

  product_category_name_english,
  SUM(price) AS total_revenue_for_category,
  ROUND(100*SUM(price)/(SELECT SUM(price) FROM orders_customers_products),2) AS pct_of_total_revenue

FROM orders_customers_products

GROUP BY product_category_name_english
ORDER BY total_revenue_for_category DESC




-- Top 10 product categories by order volume

[INSERT QUERY]


----------------------------------------------------
-- 3. Regional Performance Analysis
----------------------------------------------------

/*
Purpose:
Analyse revenue, orders and AOV by customer state
to identify key geographic markets.
*/

-- Revenue and orders by state

[INSERT QUERY]


-- State-level AOV

[INSERT QUERY]


----------------------------------------------------
-- 4. Seller Marketplace Health
----------------------------------------------------

/*
Purpose:
Evaluate seller concentration, revenue contribution and
customer review performance.
*/

-- Seller revenue contribution

[INSERT QUERY]


-- Seller order volume

[INSERT QUERY]


-- Seller review performance

[INSERT QUERY]


----------------------------------------------------
-- 5. Delivery Performance Analysis
----------------------------------------------------

/*
Purpose:
Analyse delivery times, delays and operational bottlenecks.
*/

-- Delivery time metrics

[INSERT QUERY]


-- Delivery delay rates by state

[INSERT QUERY]


-- Delivery delays by route

[INSERT QUERY]


----------------------------------------------------
-- 6. Customer Experience Analysis
----------------------------------------------------

/*
Purpose:
Analyse the relationship between delivery performance
and customer satisfaction.
*/

-- Review scores by delivery status

[INSERT QUERY]


-- One-star reviews associated with delayed deliveries

[INSERT QUERY]
