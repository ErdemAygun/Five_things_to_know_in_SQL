USE DigitalEvidence
/*
CREATED BY: WALTER SHIELDS
CREATED DATE: MM/DD/YYYY
DESCRIPTION: YOUR DESCRIPTION GOES HERE
*/


SELECT
	firstName AS [First Name],
	LastName AS [Last Name],
	age AS Age,
	city AS City
FROM
	customer_details
WHERE
	Age BETWEEN 2 AND 10
ORDER BY
	Age

-------
SELECT
	firstName AS [First Name],
	LastName AS [Last Name],
	age AS Age,
	city AS City
FROM
	customer_details
WHERE
	Age IN (2, 5, 10) -- Try swapping out values and using the NOT operator
ORDER BY
	Age