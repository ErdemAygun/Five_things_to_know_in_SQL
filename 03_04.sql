USE DigitalEvidence
/*
CREATED BY: WALTER SHIELDS
CREATED DATE: MM/DD/YYYY
DESCRIPTION: YOUR DESCRIPTION GOES HERE
*/


SELECT
	start_city AS [Start City],
	dest_city AS [Dest. City],
	flightDate AS [Flight Date]
FROM
	flight_details
WHERE 
	flightDate = '2021-07-05'
ORDER BY
	flightDate

	/*
	Note:
	You can enter the flightdate value as it is stored in the database
	e.g. 2021-07-05 00:00:00.000 or just the date 2021-07-05

	Tip: Another way to tell how a date (or any value) is stored in a table is to 
	RIGHT CLICK the table in the Object Explorer and select "Select Top 1000 Rows"

	Some of the Formats that dates can be stored in include:
	MM/DD/YYYY
	MM-DD-YYYY
	YYYY-MM-DD
	DD/MM/YY

	Dont forget to try the BETWEEN as well as other Operators and observe how the results change
	*/
