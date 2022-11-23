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
	age > 40 AND (firstName LIKE 'P%' OR firstName LIKE 'D%')
ORDER BY
	Age

	/*
	NOTE: 
	The Order Of Operations matter for the correct filtering when working with multiple
	Operators.
	*/