DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id INT PRIMARY KEY ,
	sale_date DATE ,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age INT,
	catogery VARCHAR(15),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10


SELECT 
COUNT(*)
FROM retail_sales

--DATA CLEANING--

SELECT * FROM retail_sales
WHERE 
transactions_id IS NULL
OR 
sale_date IS NULL 
OR 
sale_time IS NULL
OR 
customer_id IS NULL
OR 
gender IS NULL
OR 
age IS NULL
OR 
catogery  IS NULL
OR 
quantiy IS NULL
OR 
price_per_unit IS NULL
OR 
cogs IS NULL
OR 
total_sale IS NULL;

DELETE FROM retail_sales
WHERE 
transactions_id IS NULL
OR 
sale_date IS NULL 
OR 
sale_time IS NULL
OR 
customer_id IS NULL
OR 
gender IS NULL
OR 
age IS NULL
OR 
catogery  IS NULL
OR 
quantiy IS NULL
OR 
price_per_unit IS NULL
OR 
cogs IS NULL
OR 
total_sale IS NULL;


--DATA EXPLORATATION--

--how much items sold--
SELECT COUNT(*) AS total_sale FROM retail_sales


-- How many customer we have--
SELECT COUNT(customer_id) AS total_sale FROM retail_sales

-- how many unique customer--
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales

--how many catogery--
SELECT DISTINCT catogery FROM retail_sales 

--DATA ANALYSIS AND BUSINESS KEY PROBLEM--

--SQL QUERY TO FIND ALL COLUMNS FOR SALES MADE ON "2022-11-05"
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';


-- SQL QUERY TO FIND ALL TRANSACTIONS  WHERE THE CATOGERY  IS CLOTHING AND SOLD MORE THAN 10 IN NOV 2022--
SELECT
*
FROM retail_sales
WHERE 
	catogery = 'Clothing'
	AND 
	TO_CHAR(sale_date ,'YYYY-MM') = '2022-11'
	AND 
	quantiy >= 4

--calculate total sales from each category --
SELECT catogery ,
SUM(total_sale) as net_sale,
COUNT (*) as total_orders
FROM retail_sales
GROUP BY 1

--average age of customer who buy from beauty category --
SELECT 
ROUND(AVG(age)) as avg_age 
FROM retail_sales
WHERE catogery = 'Beauty'


--find all transactions where total sale is greatwe than 1000--
SELECT * FROM retail_sales
WHERE total_sale >1000

-- find the total number transactions(transactions_id) made by each gender in each catogery 
SELECT 
catogery , 
gender ,
COUNT (*) AS total_trans 
FROM retail_sales
GROUP 
BY 
catogery , 
gender 
ORDER BY 1

--CALCULATE THE AVERAGE SALE OF EACH MONTH AND BEST SELLING MONTH IN YEAR --
SELECT 
EXTRACT(YEAR FROM sale_date ) as year,
EXTRACT(MONTH FROM sale_date ) as year ,
ROUND(AVG(total_sale)) as avg_sale
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC

--FIND THE TOP5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES --
SELECT 
customer_id ,
SUM(total_sale) as total_sales 
FROM retail_sales 
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5

--FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATOGERY --
SELECT 
catogery,
COUNT (DISTINCT customer_id) 
FROM retail_sales 
GROUP BY catogery 

-- CREATE EACH SHIFT CATOGERY AND NUMBER OF ORDER --
WITH hourly_sale
AS 
(
SELECT *,
CASE 
WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift 
FROM retail_sales 
)

SELECT 
shift,
COUNT(*) AS total_orders 
FROM hourly_sale
GROUP BY shift

--END OF PROJECT --















