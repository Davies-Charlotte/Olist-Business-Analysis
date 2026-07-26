/*
Create Analysis Views



Purpose:
Creates analytical views from the raw base tables to combine, transform and aggregate the original
Olist datasets into analysis-ready datasets.

Views created:
1. review_summary
   - Creates a cleaned review table containing only
     the latest review per order.

2. orders_customers_products
   - Creates a central analytical table combining
     orders, customers, products and category data.

3. state_summary
   - Aggregates order volume and revenue by customer
     state for regional analysis.

4. seller_order_table
   - Combines seller, order, customer and review data
     for seller performance analysis.

5. orders_customers
   - Creates a simplified customer-order table for
     customer and order-level analysis.
*/


----------------------------------------------------
-- 1. Create review summary view
----------------------------------------------------

/*
Some orders have multiple review records due to
customers updating or amending reviews.

This view keeps only the most recent review for each
order to avoid duplicate review records during
customer experience analysis.
*/

CREATE OR REPLACE VIEW review_summary AS

SELECT *
FROM (
    SELECT
        review_id,
        order_id,
        review_score,
        review_creation_date,
        ROW_NUMBER() OVER (
            PARTITION BY order_id
            ORDER BY review_creation_date DESC
        ) AS review_rank

    FROM reviews
)
WHERE review_rank = 1;




----------------------------------------------------
-- 2. Create combined orders, customers and products view
----------------------------------------------------

/*
Creates the main analytical dataset used for:
- Revenue analysis
- Product performance
- Regional comparisons
- Order volume analysis

Combines:
orders
customers
order_items
products
product category translation
*/

CREATE OR REPLACE VIEW orders_customers_products AS

SELECT
    orders.order_id,
    orders.customer_id,
    orders.order_status,
    orders.order_purchase_timestamp,

    customer_zip_code_prefix,
    customer_city,
    customer_state,

    order_item_id,
    order_items.product_id,
    price,
    product_category_name_english

FROM orders

JOIN customers
    ON customers.customer_id = orders.customer_id

JOIN order_items
    ON order_items.order_id = orders.order_id

JOIN products
    ON products.product_id = order_items.product_id

LEFT JOIN products_trans
    ON products_trans.product_category_name = products.product_category_name;



----------------------------------------------------
-- 3. Create state revenue and order summary view
----------------------------------------------------

/*
Aggregates marketplace performance by customer state.

Used for:
- Regional revenue analysis
- Regional order concentration
*/

CREATE OR REPLACE VIEW state_summary AS

SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS orders_from_state,
    SUM(price) AS revenue_from_state

FROM orders_customers_products

GROUP BY customer_state;



----------------------------------------------------
-- 4. Create seller performance analytical view
----------------------------------------------------

/*
Combines seller information with orders, customers
and reviews.

Used for:
- Seller revenue analysis
- Seller order volume analysis
- Seller review performance
*/

CREATE OR REPLACE VIEW seller_order_table AS

SELECT
    *

FROM sellers

JOIN order_items
    ON order_items.seller_id = sellers.seller_id

JOIN orders
    ON orders.order_id = order_items.order_id

JOIN customers
    ON customers.customer_id = orders.customer_id

LEFT JOIN review_summary
    ON review_summary.order_id = orders.order_id;




----------------------------------------------------
-- 5. Create orders and customers view
----------------------------------------------------

/*
Creates a simplified customer-order dataset.

Used for:
- Customer behaviour analysis
- Order-level analysis
*/

CREATE OR REPLACE VIEW orders_customers AS

SELECT *

FROM orders

JOIN customers
    ON customers.customer_id = orders.customer_id;

