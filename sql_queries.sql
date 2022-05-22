#/Set the database to the newly created `sales` db/#
USE sales;

#/Query that returns raw, unaggregated data like the Excel dataframe builder/#
SELECT c.cust_id, t.transaction_id, c.first_name, c.last_name, c.age, c.gender, c.credit_score, c.email, c.phone,
	j.job_title, c.street_num, c.street_nam, cs.city, cs.state, t.stamp, e.emp_fname, e.emp_lname, e.emp_title,
    t.vin, cr.make, cr. model, t.color, t.car_year, t.price
FROM customers AS c
LEFT JOIN jobs AS j
ON c.job_id = j.job_id
LEFT JOIN city_state AS cs
ON c.city_state_id = cs.city_state_id
LEFT JOIN transactions AS t
ON c.cust_id = t.cust_id
LEFT JOIN cars AS cr
ON t.make_model_id = cr.make_model_id
LEFT JOIN employees AS e
ON t.employee_id = e.employee_id;

#/Query time series data by date using a CTE to create a Total Row/#
WITH Temp AS (
	SELECT
		t.stamp AS Sales_Date, SUM(t.price) AS Sales_Price
FROM transactions AS t
GROUP BY Sales_Date)
SELECT Sales_Date, Sales_Price FROM Temp
UNION ALL
SELECT 'Total', SUM(Sales_Price) FROM Temp;

#/Query time series data by month using a CTE to create a Total Row/#
WITH Temp AS (
	SELECT
		CONCAT(YEAR(t.stamp),'-',MONTH(t.stamp)) AS Sales_Period, SUM(t.price) AS Sales_Price
FROM transactions AS t
GROUP BY Sales_Period)
SELECT Sales_Period, Sales_Price FROM Temp
UNION ALL
SELECT 'Total', SUM(Sales_Price) FROM Temp;

#/Query a Top-10 List of States with highest Sales and a rank number #/
SELECT
	ROW_NUMBER() OVER (ORDER BY SUM(t.price) DESC)  Sequence_no,
    cs.state AS State, SUM(t.price) AS Sales_Price
FROM transactions AS t
LEFT JOIN customers AS c
ON t.cust_id = c.cust_id
LEFT JOIN city_state AS cs
ON c.city_state_id = cs.city_state_id
GROUP BY State
ORDER BY Sales_Price DESC
LIMIT 10;

#/Query a total of Sales by City and ordered by State and City with Sub Totals by State/#
SELECT
	IFNULL(cs.state,'Grand Total') AS State, IFNULL(cs.city, 'Sub Total') AS City, SUM(t.price) AS Sales_Price
FROM transactions AS t
LEFT JOIN customers AS c
ON t.cust_id = c.cust_id
LEFT JOIN city_state AS cs
ON c.city_state_id = cs.city_state_id
GROUP BY State, City WITH ROLLUP
ORDER BY State, City;