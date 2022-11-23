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
	firstName = 'Lewis'
ORDER BY
	Age

-----------

SELECT
	firstName AS [First Name],
	LastName AS [Last Name],
	age AS Age,
	city AS City
FROM
	customer_details
WHERE
	firstName LIKE 'L%' -- Try changing the % card character position, other text columns and other values 
ORDER BY
	Age