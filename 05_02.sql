USE DigitalEvidence
/*
CREATED BY: WALTER SHIELDS
CREATED DATE: MM/DD/YYYY
DESCRIPTION: YOUR DESCRIPTION GOES HERE
*/

SELECT
	firstName AS [First Name],
	LastName AS [Last Name],
	city AS City,
	age AS Age,
	CASE
		WHEN age <=17 THEN 'Minors'
		WHEN age BETWEEN 10 AND 59 THEN 'Adults'
		WHEN age BETWEEN 60 AND 90 THEN 'Seniors'
		ELSE 'Wise' 
	END AS [Age Category]
FROM
	customer_details


--CASE statement in the WHERE clause 

SELECT
	firstName AS [First Name],
	LastName AS [Last Name],
	city AS City,
	age AS Age,
	CASE
		WHEN age <=17 THEN 'Minors'
		WHEN age BETWEEN 10 AND 59 THEN 'Adults'
		WHEN age BETWEEN 60 AND 90 THEN 'Seniors'
		ELSE 'Wise' 
	END AS [Age Category]
FROM
	customer_details
WHERE
		CASE
		WHEN age <=17 THEN 'Minors'
		WHEN age BETWEEN 10 AND 59 THEN 'Adults'
		WHEN age BETWEEN 60 AND 90 THEN 'Seniors'
		ELSE 'Wise' 
	END = 'Minors' -- Try changing to other custom segments e.g. Seniors or Wise.  Also try using the IN Operator
ORDER BY
	[Age Category] -- We are ordering by the Calculated Column by specifying the Alias name

