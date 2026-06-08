USE ecommerce_analytics;

-- 1. Create a clean staging table with proper data types
DROP TABLE IF EXISTS sales_analysis_table;

CREATE TABLE sales_analysis_table (
    transaction_id INT PRIMARY KEY,
    order_date DATE,                  
    product_category VARCHAR(100),
    product_name VARCHAR(255),
    units_sold INT,
    unit_price DECIMAL(10,2),
    total_revenue DECIMAL(10,2),
    region VARCHAR(100),
    payment_method VARCHAR(100)
);

-- 2. Pull from the raw wizard table (handling spaces with backticks)
INSERT INTO sales_analysis_table (
    transaction_id, order_date, product_category, product_name, 
    units_sold, unit_price, total_revenue, region, payment_method
)
SELECT 
    `Transaction ID`,
    STR_TO_DATE(`Date`, '%Y-%m-%d'), 
    `Product Category`,
    `Product Name`,
    `Units Sold`,
    `Unit Price`,
    `Total Revenue`,
    `Region`,
    `Payment Method`
FROM `Online Sales Data`; -- Matches default wizard naming structure

-- Verify the migration worked perfectly
SELECT * FROM sales_analysis_table LIMIT 5;

SELECT 
    EXTRACT(YEAR FROM order_date) AS sales_year,
    EXTRACT(MONTH FROM order_date) AS sales_month,
    COUNT(DISTINCT transaction_id) AS total_order_volume,
    SUM(total_revenue) AS monthly_gross_revenue
FROM sales_analysis_table
GROUP BY sales_year, sales_month
ORDER BY sales_year ASC, sales_month ASC;

SELECT 
    EXTRACT(YEAR FROM order_date) AS sales_year,
    EXTRACT(MONTH FROM order_date) AS sales_month,
    SUM(total_revenue) AS peak_monthly_revenue
FROM sales_analysis_table
GROUP BY sales_year, sales_month
ORDER BY peak_monthly_revenue DESC
LIMIT 3;

