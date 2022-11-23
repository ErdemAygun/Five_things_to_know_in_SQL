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
	Age <> 3 --Try swapping out the operators when you build your own Query.
ORDER BY
	Age