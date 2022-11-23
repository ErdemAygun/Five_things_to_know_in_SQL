USE DigitalEvidence
/*
CREATED BY: WALTER SHIELDS
CREATED DATE: MM/DD/YYYY
DESCRIPTION: THE STRUCTURE OF A BASIC QUERY
*/
SELECT
	TOP 10
	firstName AS [First Name],
	LastName AS [Last Name],
	age AS Age,
	city AS City
FROM
	customer_details
ORDER BY
	Age