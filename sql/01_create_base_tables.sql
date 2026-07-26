/*

Create Base Tables

Purpose:
Creates the initial database tables by importing the
raw Olist CSV datasets into the SQL environment.

These base tables represent the original source data
used throughout the analysis before any cleaning,
transformation or analytical modelling.

Source Tables Created:
- orders              : Order lifecycle information,
                        including order status and timestamps
- customers           : Customer identifiers and location data
- order_items         : Individual products purchased within orders
- products            : Product attributes and category information
- products_trans      : Product category translation mapping
- sellers             : Seller identifiers and location information
- reviews             : Customer review scores and comments


*/

CREATE TABLE orders AS
SELECT *
FROM read_csv_auto('/content/drive/MyDrive/Olist_Project/olist_orders_dataset.csv');

CREATE TABLE customers AS 
SELECT *
FROM read_csv_auto('/content/drive/MyDrive/Olist_Project/olist_customers_dataset.csv');


CREATE TABLE order_items AS
SELECT *
FROM read_csv_auto('/content/drive/MyDrive/Olist_Project/olist_order_items_dataset.csv');


CREATE TABLE products AS 
SELECT * 
FROM read_csv_auto('/content/drive/MyDrive/Olist_Project/olist_products_dataset.csv'); 


CREATE TABLE products_trans AS
SELECT * 
FROM read_csv_auto('/content/drive/MyDrive/Olist_Project/product_category_name_translation.csv');


CREATE TABLE sellers AS 
SELECT *
FROM read_csv_auto('/content/drive/MyDrive/Olist_Project/olist_sellers_dataset.csv');


CREATE TABLE reviews AS 
SELECT *
FROM read_csv_auto('/content/drive/MyDrive/Olist_Project/olist_order_reviews_dataset.csv');



