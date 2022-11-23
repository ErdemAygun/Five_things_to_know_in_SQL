USE DigitalEvidence
/*
CREATED BY: WALTER SHIELDS
CREATED DATE: MM/DD/YYYY
DESCRIPTION: YOUR DESCRIPTION GOES HERE
*/

SELECT
	bank_transaction_pk AS [Bank Transaction #],
	account_number_fk AS [Account Num],
	transdate AS [Transaction Date],
	amount AS Amount,
	amount + 10 [Amount Plus $10 Fee]
FROM
	bank_transactions
ORDER BY
	[Amount Plus $10 Fee]


	---Using the WHERE with Calculated Columns---
SELECT
	bank_transaction_pk AS [Bank Transaction #],
	account_number_fk AS [Account Num],
	transdate AS [Transaction Date],
	amount AS Amount,
	amount + 10 [Amount Plus $10 Fee]
FROM
	bank_transactions
WHERE
	amount + 10 > 20
ORDER BY
	[Amount Plus $10 Fee]

---Cautions with Calculated Columns---

SELECT
	age AS Age,
	age/2 AS [Age Divided by 2 Integer (Incorrect Result)],
	age/2.0 AS [Age Divided by 2.0 Decimal (Correct Result)]
FROM
	customer_details

----Order of Operations in Calculated Columns----

SELECT
	bank_transaction_pk AS [Bank Transaction #],
	account_number_fk AS [Account Num],
	transdate AS [Transaction Date],
	amount AS Amount,
	amount + 10 [Amount Plus $10 Fee],
	(amount + 10) / 2 AS [50% OFF PROMO] -- The order is determined by the () brackets
FROM
	bank_transactions
WHERE
	amount + 10 > 20
ORDER BY
	[Amount Plus $10 Fee]