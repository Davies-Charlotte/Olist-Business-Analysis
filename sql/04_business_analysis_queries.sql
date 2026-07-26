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


-- How many total orders have been placed?
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM orders

    
    
-- What is the total revenue?
-- What is the average order value?
-- How many total products have been ordered?
-- How many distinct products have been ordered?
-- How many unique customers do we have?
-- How many sellers operate on the marketplace?
-- What percentage of orders are successfully delivered?
SELECT
    SUM(price) AS total_revenue,
    SUM(price)/COUNT(DISTINCT order_id) AS avg_order_value,
    COUNT(product_id) AS total_products_ordered,
    COUNT(DISTINCT product_id) AS distinct_products_ordered,
    COUNT(DISTINCT customer_unique_id) AS number_of_customers,
    COUNT(DISTINCT seller_id) AS number_of_sellers,
    ROUND(100*(SELECT COUNT(DISTINCT order_id) FROM orders WHERE order_status = 'delivered')/COUNT(DISTINCT order_id), 2) AS pct_orders_delivered

FROM seller_order_table


  
-- How have monthly revenue and order volume changed over time?
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

-- Which categories have the highest order volume?
SELECT
  product_category_name_english,
  COUNT(product_id) AS product_orders_in_category,
  COUNT(DISTINCT product_id) AS distinct_products_ordered_in_category,
  ROUND(100*COUNT(product_id)/(SELECT COUNT(product_id) FROM orders_customers_products),2) AS pct_of_total_orders
FROM orders_customers_products

GROUP BY product_category_name_english
ORDER BY product_orders_in_category DESC

    
  
-- Which categories generate the most revenue?
SELECT

  product_category_name_english,
  SUM(price) AS total_revenue_for_category,
  ROUND(100*SUM(price)/(SELECT SUM(price) FROM orders_customers_products),2) AS pct_of_total_revenue

FROM orders_customers_products

GROUP BY product_category_name_english
ORDER BY total_revenue_for_category DESC

    

-- Which categories have the highest average order price?
SELECT

  product_category_name_english,
  ROUND(AVG(price), 2) AS avg_price_in_category

FROM orders_customers_products

GROUP BY product_category_name_english
ORDER BY avg_price_in_category DESC

    

-- What percentage of total revenue do the top 10 product categories contribute?
    SELECT
      SUM(product_orders_in_category) AS total_products_top_10_categories,
      SUM(pct_of_total_products) AS pct_of_total_products_top_10_categories,
      SUM(total_revenue_for_category) AS total_revenue_top_10_categories,
      SUM(pct_of_total_revenue) AS pct_of_total_revenue_top_10_categories
FROM

    (
      SELECT

        COUNT(product_id) AS product_orders_in_category,
        ROUND(100 * COUNT(product_id)/(SELECT COUNT(product_id) FROM orders_customers_products),2) AS pct_of_total_products,
        SUM(price) AS total_revenue_for_category,
        ROUND(100 * SUM(price)/(SELECT SUM(price) FROM orders_customers_products),2) AS pct_of_total_revenue

      FROM orders_customers_products    

      GROUP BY product_category_name_english
      ORDER BY product_orders_in_category DESC
      LIMIT 10
    )



    
----------------------------------------------------
-- 3. Regional Performance Analysis
----------------------------------------------------

/*
Purpose:
Analyse revenue, orders and AOV by customer state
to identify key geographic markets.
*/

-- Which states generate the most revenue and orders?
SELECT * FROM state_summary
ORDER BY revenue_from_state DESC

    

-- Which states have the highest AOV per order?
SELECT
  customer_state,
  ROUND(revenue_from_state/orders_from_state, 2) AS avg_revenue_per_order,
  orders_from_state
FROM state_summary
ORDER BY avg_revenue_per_order DESC




----------------------------------------------------
-- 4. Seller Marketplace Health
----------------------------------------------------

/*
Purpose:
Evaluate seller concentration, revenue contribution and
customer review performance.
*/

-- Which sellers generate the most revenue?
SELECT
    seller_id,
    SUM(price) AS total_revenue_from_seller

FROM seller_order_table

GROUP BY seller_id
ORDER BY total_revenue_from_seller DESC
LIMIT 10

    

-- Which sellers fulfil the most orders?
SELECT
seller_id,
COUNT(DISTINCT order_id) AS orders_by_seller


FROM seller_order_table

GROUP BY seller_id
ORDER BY orders_by_seller DESC
LIMIT 10
    


-- What percentage of revenue do the top 10 sellers contribute to the marketplace?

WITH seller_revenue AS (

SELECT seller_id,
        SUM(price) AS seller_revenue
FROM seller_order_table
GROUP BY seller_id

)


SELECT
        seller_id,
        seller_revenue,

        ROUND(100*seller_revenue/(SELECT SUM(seller_revenue) FROM seller_revenue), 2)
            AS pct_of_total_revenue,

         ROUND(100*SUM(seller_revenue) OVER(ORDER BY seller_revenue DESC)
            /(SELECT SUM(seller_revenue) FROM seller_revenue), 2)
            AS cumulative_pct_revenue
FROM seller_revenue

ORDER BY seller_revenue DESC
LIMIT 10



-- Which sellers have the highest reviews?
-- Minimum 50 reviews

SELECT
seller_id,
AVG(review_score) AS avg_review_score


FROM seller_order_table

GROUP BY seller_id
HAVING COUNT(review_score) >= 50
ORDER BY avg_review_score DESC


    
-- Do the highest-revenue sellers achieve better customer ratings than the average seller?
SELECT 
    AVG(avg_review_score) AS avg_review_score_top_10pct_revenue_sellers,
    (SELECT AVG(review_score) FROM review_summary) AS avg_review_score_all_sellers

FROM (
    SELECT
        seller_id,
        SUM(price) AS total_revenue_from_seller,
        AVG(review_score) AS avg_review_score,
        COUNT(review_score) AS number_of_reviews

    FROM seller_order_table
    GROUP BY seller_id
    ORDER BY total_revenue_from_seller DESC
    LIMIT 0.1*(SELECT COUNT(DISTINCT seller_id) FROM seller_order_table)
    )



    
----------------------------------------------------
-- 5. Delivery Performance Analysis
----------------------------------------------------

/*
Purpose:
Analyse delivery times, delays and operational bottlenecks.
*/

-- What is the average delivery time?
SELECT
  AVG(DATEDIFF('day', order_purchase_timestamp, order_delivered_customer_date)) AS avg_delivery_time
FROM orders
WHERE order_status = 'delivered'

    

-- Is average delivery time representative of the typical customer experience?
WITH delivery_times AS (
    
SELECT
    order_id,
    DATEDIFF('day', order_purchase_timestamp, order_delivered_customer_date ) AS delivery_time

FROM orders
WHERE order_status = 'delivered'
)

SELECT
    ROUND(AVG(delivery_time), 2) AS avg_delivery_time,
    MEDIAN(delivery_time) AS median_delivery_time,
    QUANTILE_CONT(delivery_time, 0.90) AS percentile_90_delivery_time,
    MAX(delivery_time) AS longest_delivery_time

FROM delivery_times



-- Which orders have the longest delivery times?
SELECT
    order_id,
    order_purchase_timestamp,
    order_delivered_customer_date,

    DATEDIFF('day', order_purchase_timestamp, order_delivered_customer_date) AS delivery_time

FROM orders
WHERE order_status = 'delivered'
ORDER BY delivery_time DESC
LIMIT 10



-- Which states experience the longest delivery times?
SELECT
    customer_state,
    AVG(DATEDIFF('day', order_purchase_timestamp, order_delivered_customer_date)) AS avg_delivery_time,

    ROUND( 100*COUNT(DISTINCT order_id) / (SELECT COUNT(DISTINCT order_id) FROM orders WHERE order_status = 'delivered' ), 2
    ) AS pct_of_total_orders

FROM orders_customers
WHERE order_status = 'delivered'

GROUP BY customer_state
ORDER BY avg_delivery_time DESC

    

-- Which states receive the most orders?
SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(100*COUNT(DISTINCT order_id) / (SELECT COUNT(DISTINCT order_id) FROM orders), 2 )
      AS pct_of_total_orders

FROM orders_customers

GROUP BY customer_state
ORDER BY total_orders DESC


    
-- What % of deliveries are early, on time or delayed?
-- Does delivery time affect review scores?

WITH delivery_status_and_reviews AS
    
(
SELECT
  orders.order_id,
  order_delivered_customer_date,
  order_estimated_delivery_date,
  CASE
      WHEN DATE(order_delivered_customer_date) < order_estimated_delivery_date THEN 'early'
      WHEN DATE(order_delivered_customer_date) = order_estimated_delivery_date THEN 'on_time'
      WHEN DATE(order_delivered_customer_date) > order_estimated_delivery_date THEN 'delayed'
      ELSE 'Unassigned'
  END AS delivery_status,
  review_score
FROM review_summary
RIGHT JOIN orders
    ON orders.order_id = review_summary.order_id

)

SELECT delivery_status,
    COUNT(DISTINCT order_id) AS number_of_orders,
     AVG(review_score) AS avg_review_score,
     ROUND(100.0*COUNT(DISTINCT order_id)/(SELECT COUNT(DISTINCT order_id) FROM delivery_status_and_reviews), 2) AS pct_of_orders
FROM delivery_status_and_reviews

GROUP BY delivery_status
ORDER BY avg_review_score DESC

-- Delayed orders have an average review score of 2.27/5


    
----------------------------------------------------
-- 6. Customer Experience Analysis
----------------------------------------------------

/*
Purpose:
Analyse the relationship between delivery performance
and customer satisfaction.
*/

-- What % of all reviews are 1-star?
SELECT
    COUNT(DISTINCT order_id) AS total_number_of_reviews,
    (SELECT COUNT(DISTINCT order_id) FROM review_summary WHERE review_score = 1) AS total_number_of_1_star_reviews,
    ROUND(100.0*(SELECT COUNT(DISTINCT order_id) FROM review_summary WHERE review_score = 1)/(SELECT COUNT(*) FROM review_summary), 2) AS pct_of_reviews_w_1_star

FROM review_summary
WHERE review_score IS NOT NULL

-- Output: Approx 11.52%, so we can expect 11.52% of late deliveries to have a 1-star review if there is no effect

    

-- What % of 1-star reviews have a late delivery?
SELECT
    COUNT(DISTINCT order_id) AS number_of_1_star_late_deliveries,
    ROUND(100.0*COUNT(*)/(SELECT COUNT(DISTINCT order_id) FROM orders WHERE DATE(order_delivered_customer_date) > order_estimated_delivery_date), 2) AS pct_of_late_deliveries_w_1_star

FROM review_summary
LEFT JOIN orders
    ON orders.order_id = review_summary.order_id
WHERE review_score = 1
AND DATE(order_delivered_customer_date) > order_estimated_delivery_date
