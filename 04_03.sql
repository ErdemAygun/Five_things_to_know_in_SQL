--1.	Select the NAMES of the people who live in NYC (choose all that apply)
/********************************************************************************
* HINT: Include the Primary Key column "id" in your query result                *
*********************************************************************************/

SELECT
	firstName,
	LastName,
	city,
	id,*
FROM
	[dbo].[customer_details]
WHERE
	city = 'New York City'
/*
RESULTS
Barry	Allen	New York City	32
Opra	Baker	New York City	38
*/





--2.	Select the NAMES of all the PEOPLE who FLEW to NY BEFORE the DATE of the crime.
/************************************************************************************
* HINT: YOU NEED 2 SQL QUERIES TO ANSWER THIS QUESTION                              *
* a. First Query: Select all the records that satisfies the questions criteria      *
*    from flight_details (Include and note the values in the customer_id field).
*
* b.Second Query: Select all the records from the customer_details table WHERE the  *
*    "id" field = the customer_id values you noted.                                 *     *
*                                                                                   * 
*************************************************************************************/

SELECT
	*
FROM
	[dbo].[flight_details]
WHERE
	dest_city = 'New York City'
	AND flightDate < '2021-10-23'



SELECT
	*
FROM
	[dbo].[customer_details]
WHERE
	ID IN (100, 105, 106)

/*
RESULT
100	Bruce	Puerto Princesa	42	Fisher
105	Aleana	Machida	19	Jordan
106	Brenda	Karatsu	39	Reynolds
*/


--3.	Select the NAMES of all the PEOPLE who FLEW from NY AFTER the DATE of the crime.
/************************************************************************************
* HINT: YOU NEED 2 SQL QUERIES TO ANSWER THIS QUESTION                              *
* a. First Query: Select all the records that satisfies the questions criteria      *
*    from the customer_details table (note the values in the customer_id field).   *
* b. Second Query: Select all the records from the customer_details table WHERE the "id"*
*    field = the customer_id field values you noted.                                *
*                                                                                   * 
*************************************************************************************/

SELECT
	*
FROM
	[dbo].[flight_details]
WHERE
	start_city = 'New York City'
	AND 
	flightDate > '2021-10-23'


SELECT 
	*
FROM
	[dbo].[customer_details]
WHERE
	ID IN (100,105,106,141)
		
/*
RESULT:
100	Bruce	Puerto Princesa	42	Fisher
105	Aleana	Machida	19	Jordan
106	Brenda	Karatsu	39	Reynolds
141	Hajrah	Haldia	73	Burns
*/
	   	  







--4.	Look at the list of names from questions 2 and 3.  
--Are there any names that exist on both? List them here:

/*
RESULTS:
100	Bruce Fisher Puerto Princesa		
106	Brenda Reynolds	Karatsu		
105	Aleana Jordan Machida	
*/	










--5.	Look at list of people from the last question you answered.  
--Then look at your answer for Question 1.  List all names that exist on both here:
/*
RESULTS:
100	Bruce Fisher Puerto Princesa	42	
106	Brenda Reynolds	Karatsu	39	
105	Aleana Jordan Machida	19	
32	Barry	Allen	New York City	
38  Opra	Baker	New York City
*/










--6.	What is the name of the table that contains text messages?
--text_messages















--7.	What is the name of the table that contains phone contracts?
--cellphone_details















--8.	How many text messages were sent BETWEEN 10/20/2021 and 10/25/2021?
--Note: A couple of days before and after the date of the crime 10/23/2021

SELECT
	*
FROM
	[dbo].[text_messages]
WHERE
	sent BETWEEN '2021-10-20' AND '2021-10-25'















--9. How many text messages were sent BETWEEN 10/20/2021 and 10/25/2021 
--   by any the people on our list of suspects?
/************************************************************************************
* HINT: YOU NEED LOGICAL OPERATORS (AND and IN) TO ANSWER THIS QUESTION  	        *
*  a. SELECT all the records that satisfies the questions criteria                  *
*    from text_messages table                                                       *
*                                                                                   * 
*		AND                                                                   *      *                                                                                   *
*  b. All the records from the same table WHERE the "sender_id"                     *	
*    field = ANY of the id field values from your list of suspects from Question 5  *       *                                                                                   *
*                                                                                   * 
*************************************************************************************/
/*
LIST OF SUSPECTS FROM QUESTION 5
100	Bruce Fisher Puerto Princesa	42	
106	Brenda Reynolds	Karatsu	39	
105	Aleana Jordan Machida	19	
32	Barry	Allen	New York City	
38  Opra	Baker	New York City
*/

SELECT
	*
FROM
	[dbo].[text_messages]
WHERE
	sent BETWEEN '2021-10-20' AND '2021-10-25'
AND
	sender_id IN (100,106,105,32,38)









--10.	Who are the thieves? 
/************************************************************************************
* HINT: a. Analyze the contents of the text messages from your query results and     *
*		   and identify any suspicious messages. (note the sender_id and reciever_id * 
*		   values)                                                                   *
*		b. Option1: Compare the sender_id and reciever_id numbers to the id          *
*           to the "id" values from your list of suspects (Question 5) and select the* 
*		   associated name(s).                                                       *
*		c. Option 2: Select the records from the customer_details table WHERE        *
*			the "id" column equals to the sender_id and reciever_id values from the  *
*			records you identified after analyzing the message contents.             *
**************************************************************************************/
SELECT
	*
FROM
	customer_details
WHERE
	id in(100,106) 







/*
RESULTS:
100	Bruce Fisher 
106	Brenda Reynolds	
*/

