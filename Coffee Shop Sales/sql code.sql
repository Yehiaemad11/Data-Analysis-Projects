SELECT * FROM coffee_shop_sales;
DESCRIBE coffee_shop_sales;


UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%c/%e/%Y');

ALTER TABLE  coffee_shop_sales
MODIFY COLUMN transaction_date DATE;

UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%H:%i:%s');

ALTER TABLE  coffee_shop_sales
MODIFY COLUMN transaction_time TIME;

ALTER TABLE coffee_shop_sales
RENAME COLUMN ï»¿transaction_id TO transaction_id;
-- ------------------------------------------------------------- Total sales analysis

SELECT ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales 
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 3 ; -- March Month

SELECT ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales 
FROM coffee_shop_sales
GROUP BY 
MONTH(transaction_date);

SELECT 
    MONTH(transaction_date) AS month, -- number of month
    ROUND(SUM(unit_price * transaction_qty)) AS total_sales, -- total sales column
    (SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty), 1) -- Month slaes Difference
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty), 1) -- Divion by PM  sales
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS mom_increase_percentage  -- Percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4, 5) -- for months of April(PM) and May(CM)
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);

-- ------------------------------------------------------------------------ Total orders Analysis

SELECT COUNT(transaction_qty) AS Total_orders 
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 5 ; -- March Month


SELECT 
    MONTH(transaction_date) AS month, -- number of month
    COUNT(transaction_qty) AS total_orders, -- total orders column
    (COUNT(transaction_qty) - LAG(COUNT(transaction_qty), 1) -- Month orders Difference
    OVER (ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_qty), 1) -- Divion by PM  sales
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS orders_increase_percentage  -- Percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4 , 5) -- for months of April(PM) and May(CM)
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);
    
-- ----------------------------------------------- Total quantiy sold Analysis   

SELECT SUM(transaction_qty) AS Total_qty_sales 
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 5 ; -- March Month

SELECT 
    MONTH(transaction_date) AS month, -- number of month
    SUM(transaction_qty) AS total_orders, -- total qty column
    (SUM(transaction_qty) - LAG(SUM(transaction_qty), 1) -- Month qty Difference
    OVER (ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty), 1) -- Divion by PM  sales
    OVER (ORDER BY MONTH(transaction_date)) * 100 AS orders_increase_percentage  -- Percentage
FROM 
    coffee_shop_sales
WHERE 
    MONTH(transaction_date) IN (4 , 5) -- for months of April(PM) and May(CM)
GROUP BY 
    MONTH(transaction_date)
ORDER BY 
    MONTH(transaction_date);
--  ----------------------------------------------------------------------------------------
    SELECT   -- Heat map test
        CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1), 'k') AS Total_Sales,
		CONCAT(ROUND(SUM(transaction_qty)/1000,1),'k') AS Total_Qty_Sold,
        CONCAT(ROUND(COUNT(transaction_id)/1000,1),'k') AS Total_Orders
   FROM   coffee_shop_sales  
   WHERE 
		transaction_date = '2023-03-27';
   
  -- ----------------------------------------------
  
  SELECT 
	CASE 
		WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekend' 
	ELSE  'Weekdays'		
	END AS date_type,
    CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000, 1),'k') AS Total_Sales
 FROM  coffee_shop_sales
 WHERE MONTH(transaction_date) = 5 -- May month
 GROUP BY 
	CASE 
		WHEN dayofweek(transaction_date) IN (1,7) THEN 'Weekend' 
	ELSE  'Weekdays'		
	END;
  -- -------------------------------------------------------------
  --  sales by store location
  SELECT CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),'k')  AS Total_Sales , store_location
  FROM coffee_shop_sales
  WHERE 
	MONTH(transaction_date) = 5 -- MAY month
  GROUP BY store_location
  ORDER BY CONCAT(ROUND(SUM(transaction_qty * unit_price)/1000,1),'k') DESC;
  
  -- -------------------------------------------------------------------------
  
  SELECT  
		CONCAT(ROUND(AVG(total_sales)/1000,1),'k') AS Avg_sales
  FROM 
	(
    SELECT SUM(transaction_qty * unit_price) AS total_sales
    FROM coffee_shop_sales
    WHERE MONTH(transaction_date) = 4 
    GROUP BY  transaction_date
    ) AS Interne_query;
  
  
SELECT 
		DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY DAY(transaction_date)
ORDER BY DAY(transaction_date);
  
  
  SELECT 
    day_of_month,
    CASE 
        WHEN total_sales > avg_sales THEN 'Above Average'
        WHEN total_sales < avg_sales THEN 'Below Average'
        ELSE 'Average'
    END AS sales_status,
    total_sales
FROM (
    SELECT 
        DAY(transaction_date) AS day_of_month,
        SUM(unit_price * transaction_qty) AS total_sales,
        AVG(SUM(unit_price * transaction_qty)) OVER () AS avg_sales
    FROM 
        coffee_shop_sales
    WHERE 
        MONTH(transaction_date) = 5  -- Filter for May
    GROUP BY 
        DAY(transaction_date)
) AS sales_data
ORDER BY 
    day_of_month;
-- ----------------------------------------------------
-- sales by product category 

SELECT 
	product_category,
    ROUND(SUM(transaction_qty * unit_price),0) AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY     product_category
ORDER BY ROUND(SUM(transaction_qty * unit_price),0) DESC;
-- ---------------------------------------------------------
-- top ten products by sales 

SELECT product_type , ROUND(SUM(unit_price*transaction_qty),1) AS total_Sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_type 
ORDER BY SUM(unit_price*transaction_qty) DESC LIMIT 10;


SELECT MAX(unit_price)
FROM coffee_shop_sales

   
   
   