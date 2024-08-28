
Select * from pizza_sales

-------------------------------- KPI ------------------------------------
--Total_revenue
Select SUM(total_price) AS Total_Revenue from pizza_sales

-- Average_order_value
Select SUM(total_price) / COUNT(DISTINCT order_id) Avg_order_value from pizza_sales

-- Total_pizza_sold
Select SUM(quantity) AS Total_pizza_sold from pizza_sales

-- Total_orders
Select COUNT(DISTINCT order_id) AS Total_orders from pizza_sales

-- Average_pizza_per_order 
Select CAST(CAST(SUM(quantity) AS decimal(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) 
AS Avg_pizzas_per_order from pizza_sales


---------------------------- Hourly Trend for total Pizzas sold --------------------------

Select DATEPART(HOUR, order_time) AS order_hour, SUM(quantity) AS Total_Pizza_sold 
from pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time) 

---------------------------- Weekly Trend for total Pizzas sold --------------------------

Select DATEPART(ISO_WEEK, order_date) AS week_number, YEAR(order_date) AS Order_year,
COUNT(DISTINCT(order_id)) AS Total_orders from pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY  DATEPART(ISO_WEEK, order_date), YEAR(order_date)

--------------------------- Percentage of Sales by Pizza Category ------------------------

Select pizza_category, SUM(total_price) AS Total_Sales, SUM(total_price) * 100 / 
(Select sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) AS PCT
from pizza_sales 
WHERE MONTH(order_date) = 1		
GROUP BY pizza_category

--------------------------- Percentage of Sales by Pizza Size ------------------------

Select pizza_size, CAST(SUM(total_price) AS decimal(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(Select sum(total_price) from pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS decimal(10,2)) AS PCT
from pizza_sales 
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT DESC

--------------------------- Top 5 Pizzas by Revenue -------------------------

Select TOP 5 pizza_name, SUM(total_price) AS Total_Revenue from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

---------------------------- Bottom 5 Pizzas by Revenue ---------------------

Select TOP 5 pizza_name, SUM(total_price) AS Total_Revenue from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue 

---------------------------- Top 5 Pizzas by Quantity ---------------------

Select TOP 5 pizza_name, SUM(quantity) AS Total_Quantity from pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC 

