-- Create database
CREATE DATABASE superstore_analysis;
SELECT COUNT(*) AS total_rows
FROM superstore_analysis.superstoreorders;

DESC superstore_analysis.superstoreorders;

ALTER TABLE superstore_analysis.superstoreorders
ADD order_date_new DATE,
ADD ship_date_new DATE;


ALTER TABLE superstore_analysis.superstoreorders
MODIFY sales DOUBLE,
MODIFY profit DOUBLE,
MODIFY shipping_cost DOUBLE,
MODIFY discount DOUBLE,
MODIFY quantity INT,
MODIFY year INT;


SET SQL_SAFE_UPDATES = 0;
UPDATE superstore_analysis.superstoreorders
SET order_date_new = STR_TO_DATE(order_date, '%d/%m/%Y'),
    ship_date_new = STR_TO_DATE(ship_date, '%d/%m/%Y');


SELECT
COUNT(*) AS total_rows,
SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit,
SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_date
FROM superstore_analysis.superstoreorders;

SELECT *
FROM superstore_analysis.superstoreorders
WHERE profit < 0;

SELECT ROUND(SUM(sales),2) AS total_revenue
FROM superstore_analysis.superstoreorders;

SELECT SUM(profit) AS total_profit
FROM superstore_analysis.superstoreorders;

SELECT ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percent
FROM superstore_analysis.superstoreorders;

SELECT discount,
ROUND(AVG(profit),2) AS avg_profit
FROM superstore_analysis.superstoreorders
GROUP BY discount
ORDER BY discount;


SELECT product_name,
AVG(discount) AS avg_discount,
SUM(profit) AS total_profit
FROM superstore_analysis.superstoreorders
GROUP BY product_name
ORDER BY avg_discount DESC;


SELECT category,
ROUND(SUM(sales),2) AS total_revenue,
ROUND(SUM(profit),2) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100,2) AS profit_margin_percent
FROM superstore_analysis.superstoreorders
GROUP BY category
ORDER BY total_profit DESC;

SELECT product_name,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit
FROM superstore_analysis.superstoreorders
GROUP BY product_name
HAVING total_profit < 0
ORDER BY total_profit;

SELECT region,
ROUND(SUM(sales),2) AS total_revenue,
ROUND(SUM(profit),2) AS total_profit
FROM superstore_analysis.superstoreorders
GROUP BY region
ORDER BY total_revenue DESC;

SELECT region,
ROUND(SUM(sales),2) AS total_revenue,
ROUND(SUM(profit),2) AS total_profit
FROM superstore_analysis.superstoreorders
GROUP BY region
ORDER BY total_revenue DESC;

SELECT segment,
ROUND(SUM(sales),2) AS total_sales,
ROUND(SUM(profit),2) AS total_profit,
COUNT(DISTINCT customer_name) AS total_customers
FROM superstore_analysis.superstoreorders
GROUP BY segment
ORDER BY total_sales DESC;

SELECT YEAR(order_date) AS year,
ROUND(SUM(sales),2) AS yearly_sales,
ROUND(SUM(profit),2) AS yearly_profit
FROM superstore_analysis.superstoreorders
GROUP BY YEAR(order_date)
ORDER BY year;

