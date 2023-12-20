-- To Retrieve all columns for all records in the dataset.
SELECT * FROm Pharma_data$;

-- To represnt UNIQUE countries from the dataset
SELECT DISTINCT(country) FROM Pharma_data$;

-- To get the names of all the customers on the 'Retail' channel
SELECT [Customer Name] FROM Pharma_data$ Where [Sub-channel]='Retail';

-- the total quantity sold for the ' Antibiotics' product class
SELECT COUNT(Quantity) AS [total quantity] FROM Pharma_data$ WHERE [Product Class]='Antibiotics' ;

--TO list all the distinct months present in the dataset.
SELECT DISTINCT(Month) FROM Pharma_data$;

-- the total sales for each year
SELECT SUM(Sales),[Year]  FROM Pharma_data$ GROUP BY [Year];

-- to find  the customer with the highest sales value.
SELECT [Customer Name] FROM Pharma_data$ GROUP BY[Customer Name] ORDER BY MAX(Sales) DESC;

-- To Get the names of all employees who are Sales Reps and are managed by 'James Goodwill'
SELECT DISTINCT([Name of Sales Rep]) FROM Pharma_data$ WHERE Manager='James Goodwill';

-- To Retrieve the top 5 cities with the highest sales
SELECT TOP 5 City,MAX(Sales) FROM Pharma_data$ GROUP BY City ;

-- TO Calculate the average price of products in each sub-channel
SELECT AVG(price),[Sub-channel] FROM Pharma_data$ GROUP BY [Sub-channel];

--Join the 'Employees' table with the 'Sales' table to get the name of the Sales Rep and the corresponding sales records.

SELECT E.[Emp Name], p.Sales 
FROM general_data$ AS e 
JOIN Pharma_data$ AS p ON E.[Emp Name] = p.[Name of Sales Rep];
-- Retrieve all sales made by employees from ' Rendsburg ' in the year 2018.
SELECT [Name of Sales Rep],SUM(Sales) FROM Pharma_data$  WHERE City='Rendsburg' AND Year=2018
GROUP BY [Name of Sales Rep];

-- Calculate the total sales for each product class, for each month, and order the results by year, month, and product class

SELECT [Product Class],Month,Year, SUM(Sales)As total_sales_for_each_productclass FROM Pharma_data$
GROUP BY [Product Class],Month,Year
ORDER BY Year,Month,[Product Class];

--Find the top 3 sales reps with the highest sales in 2019.
SELECT TOP 3 Sales FROM Pharma_data$ Where Year=2019;

/*Calculate the monthly total sales for each sub-channel, and then 
calculate the average monthly sales for each sub-channel over the years.*/

WITH MONTHLYSALES AS(
SELECT [Sub-channel],Month,Year,SUM(sales) AS TOTAl_MONTHLY_SALES  FROM Pharma_data$ 
GROUP BY [Sub-channel],Month,Year
)
SELECT [Sub-channel],AVG(TOTAl_MONTHLY_SALES) AS Sales_average FROM MONTHLYSALES
 GROUP BY [Sub-channel];

 -- Create a summary report that includes the total sales, average price, and total quantity sold for each product class.
 SELECT [Product Class],Sum(sales),AVG(Price),Sum(Quantity) FROM Pharma_data$
 GROUP BY [Product Class];

 --Find the top 5 customers with the highest sales for each year
WITH top5customers AS(SELECT [Customer NAME],year AS saleyear,SUM(Sales) AS Totalsales,ROW_NUMBER() OVER(PARTITION BY year ORDER BY SUM(Sales) DESC) AS SalesRank FROM Pharma_data$ GROUP BY [Customer Name],Year ) SELECT TOP 5 [Customer Name],saleyear,Totalsales  FROM top5customers where SalesRank <=5 ORDER BY saleyear,Totalsales DESC; --Calculate the year-over-year growth in sales for each country SELECT AVG(Sales) AS SalesAVG,Year,Country FROM Pharma_data$ GROUP BY Year,Country ORDER BY Year;-- List the months with the lowest sales for each yearWITH lowersales AS(SELECT year AS SaleYear,month AS Sale_month,SUM(sales) AS Totalsales,RANK()OVER(PARTITION BY year ORDER BY SUM(sales) ASC)AS salesrank FROM Pharma_data$GROUP By Year,Month)SELECT Totalsales,Saleyear AS year,Sale_month AS month FROM lowersales ORDER BY salesrank ;/*Calculate the total sales for each sub-channel in each country, and then find the country
with the highest total sales for each sub-channel*/With Totolsalesincountry AS(SELECT [Sub-channel] ,SUM(Sales) AS Totalsales,Country FROM Pharma_data$ GROUP BY [Sub-channel],Country),RankedCountries AS(SELECT country,[Sub-channel],Totalsales,ROW_NUMBER() OVER(PARTITION BY [Sub-Channel] ORDER BY Totalsales DESC)AS CountryRank FROM Totolsalesincountry)SELECT country,[Sub-channel],Totalsales FROM RankedCountries; 