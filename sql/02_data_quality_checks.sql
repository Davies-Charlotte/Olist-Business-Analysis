/*
Data Quality Checks



These checks were performed before analysis to validate dataset completeness, 
identify missing values, confirm relational integrity and ensure calculated metrics 
such as revenue, order volume and customer satisfaction were based on reliable data.


Checks performed:
1. Dataset size and record counts
2. Primary key uniqueness
3. Date range validation
4. Revenue validation
5. Category and product completeness
6. Data consistency checks
7. Foreign key relationship validation


*/

----------------------------------------------------
-- 1. Dataset size and record counts
----------------------------------------------------

SELECT COUNT(*) AS total_orders
FROM orders;
-- 99,441 orders


SELECT COUNT(*) AS total_customers
FROM customers;
-- 99,441 customers


SELECT COUNT(*) AS total_products
FROM products;
-- 32,951 products


SELECT COUNT(*) AS total_sellers
FROM sellers;
-- 3,095 sellers


SELECT COUNT(*) AS total_reviews
FROM reviews;
-- 99,224 reviews
-- 217 orders without reviews



----------------------------------------------------
-- 2. Primary key uniqueness
----------------------------------------------------

SELECT
    COUNT(customer_id) AS total_customer_records,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers;

-- 99,441 customer records
-- 99,441 unique customers
-- No duplicate customer IDs


SELECT
    COUNT(order_id) AS total_order_records,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

-- 99,441 orders
-- 99,441 unique orders
-- No duplicate order IDs


SELECT
    COUNT(product_id) AS total_product_records,
    COUNT(DISTINCT product_id) AS unique_products
FROM products;

-- 32,951 products
-- 32,951 unique products
-- No duplicate product IDs


SELECT
    COUNT(seller_id) AS total_seller_records,
    COUNT(DISTINCT seller_id) AS unique_sellers
FROM sellers;

-- 3,095 sellers
-- 3,095 unique sellers
-- No duplicate seller IDs



----------------------------------------------------
-- 3. Date range validation
----------------------------------------------------

SELECT
COUNT(*) AS total_orders,
COUNT(order_purchase_timestamp) AS purchase_dates,
COUNT(order_delivered_customer_date) AS delivered_dates
FROM orders;

-- 99,441 orders made
-- 99,441 purchase dates
-- 96,476 delivered dates
-- No purchase dates missing. 2,965 delivery dates missing.


SELECT
MIN(order_purchase_timestamp),
MAX(order_purchase_timestamp)
FROM orders;
-- Earliest order on 04-09-2016.
-- Most recent order on 17-10-2018.


SELECT *
FROM orders
WHERE order_delivered_customer_date < order_purchase_timestamp;
-- Empty return. No delivery dates occur before the purchase dates, delivery timestamps are logically consistent.


SELECT *
FROM orders
WHERE order_delivered_customer_date > order_estimated_delivery_date;
-- 7,827 orders were delayed



----------------------------------------------------
-- 4. Revenue validation 
----------------------------------------------------

SELECT
SUM(price) AS total_revenue
FROM order_items;
-- Total marketplace product revenue: £13,591,643.70


SELECT
MIN(price) AS minimum_price,
MAX(price) AS maximum_price
FROM order_items;
-- Min price: 0.85
-- Max price: 6,735.00
-- No negative prices.



----------------------------------------------------
-- 5. Category and product completeness
----------------------------------------------------

SELECT
COUNT(DISTINCT product_category_name)
FROM products;
-- 73 unique product categories

SELECT
COUNT(*)
FROM products
WHERE product_category_name IS NULL;
-- 610 products without product category



----------------------------------------------------
-- 6. Duplicate order items check
----------------------------------------------------

SELECT
    order_id,
    product_id,
    seller_id,
    COUNT(*) AS item_count

FROM order_items

GROUP BY
    order_id,
    product_id,
    seller_id

HAVING COUNT(*) > 1;

-- 7,088 records returned.
-- Investigation confirmed these represent multiple quantities of the same product purchased within an order,
-- rather than duplicated records. No data correction required.



----------------------------------------------------
-- 7. Foreign key relationship validation
----------------------------------------------------

-- Ordered items without order IDs
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;
-- Empty result

-- Orders without customers
SELECT COUNT(*)
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- Empty result

-- Order items without product IDs
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;
-- Empty result

-- Order items without sellers
SELECT COUNT(*)
FROM order_items oi
LEFT JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;
-- Empty result
