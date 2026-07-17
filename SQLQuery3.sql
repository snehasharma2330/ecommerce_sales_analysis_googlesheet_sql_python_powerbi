USE ECommerce_Sales;

--region hihest revenue

SELECT Region,
	SUM(Sales) AS Revenue
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY Region
Order by Revenue DESC;

--Which city has the highest average order value?
SELECT City,
	AVG(Sales) AS Avg_order_value
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY City
ORDER BY Avg_order_value DESC;

--Top 10 products by profit
SELECT TOP 10
	Product_Name,
	SUM(Profit) AS Total_profit
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY Product_Name
ORDER BY Total_profit DESC;

--Top 5 sub-categories by revenue
SELECT TOP 5
	Sub_Category,
	SUM(Sales) AS Total_Revenue
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY Sub_Category
ORDER BY Total_Revenue DESC;

--Which payment mode generated the highest sales?
SELECT Payment_Mode,
	SUM(Sales) AS total_revenue
	FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
	GROUP BY Payment_Mode
	ORDER BY total_revenue DESC;

--Which products have discounts above the average discount?
SELECT Product_Name,
	Discount
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
WHERE Discount >
(
	SELECT AVG(Discount)
	FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
	)
ORDER BY Discount DESC;

--Monthly sales trend
SELECT
	YEAR(Order_Date) AS year,
	MONTH(Order_Date) AS month,
	SUM(Sales) AS monthly_sales
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY year(Order_Date),
		month(Order_Date)
ORDER BY year, 
		month;
--Average profit margin by category
SELECT Category,
		ROUND((SUM(Profit) * 100.0)/SUM(Sales) ,2) AS profit_margin_percen
	FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY Category
ORDER BY profit_margin_percen DESC;

--Highest-value order in each region

SELECT Region,
		MAX(Sales) as highest
	FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
	GROUP BY Region;

--Top 5 customers by total sales

SELECT top 5
		Customer_Name,
		Sales AS total_revenue
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
order by total_revenue desc;

--Products sold more than the average quantity

SELECT Product_Name,
		Quantity
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
WHERE Quantity >
(
	SELECT AVG(Quantity)
	FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
)
ORDER BY Quantity DESC;

--Rank products by profit

SELECT Product_Name,
		SUM(Profit) AS total_profit,
		RANK() OVER(ORDER BY SUM(Profit) DESC )AS PROFIT_RANK

FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY Product_Name;

--Running total of monthly sales
SELECT
	YEAR(Order_Date) AS [year],
	MONTH(Order_Date) AS [month],
	SUM(Sales) AS monthly_sales,
	SUM(SUM(Sales)) OVER(ORDER BY YEAR(Order_Date), MONTH(Order_Date)) AS Running_total
	FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
	GROUP BY year(Order_Date), month(Order_Date);

--sales Contribution (%) by Category
SELECT
Category,
SUM(Sales) AS Category_Sales,
ROUND(SUM(Sales)*100.0/
	(SELECT SUM(Sales) FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
	) ,2)
AS sales_contribution
FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
GROUP BY Category
ORDER BY sales_contribution DESC;

--Which categories have profit margins above the overall average?
SELECT
	Category,
	ROUND((SUM(Profit)*100.0)/SUM(Sales),2)  AS profit_margin
	FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
	GROUP BY Category
	HAVING (SUM(Profit)*100.0)/SUM(Sales)  >
	(
		SELECT (SUM(Profit) *100.0)/SUM(Sales)
		FROM [E-Commerce _Sales_Analysis - Ecommerce_Sales_Data_2024_2025 (1)]
		)
	ORDER BY profit_margin DESC;