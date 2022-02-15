-- two variables to save the JSON text in memory 
DECLARE @JSON VARCHAR(MAX), @JSON_Formatted VARCHAR(MAX)

-- Import the JSON file into 
SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'D:\Ryerson\CIND 820\Data sets\yelp_dataset\yelp_academic_dataset_review.json', SINGLE_CLOB) AS j

-- Replace line feeds with ',' and add [] to begining and end of the files
SELECT @JSON_Formatted = REPLACE('[ ' + REPLACE(REPLACE(@JSON, CHAR(13), ''), CHAR(10), ',') + ' ]', ', ]', ']')

-- Check
IF (ISJSON(@JSON_Formatted) = 1)
	PRINT 'Valid JSON'
ELSE
	PRINT 'Invalid JSON'

-- Use the OPENJSON function to convert JSON string to tabular form
SELECT *
INTO dbo.Review
FROM OPENJSON(@JSON_Formatted)
WITH
(
	review_id varchar(36)		'$.review_id', 
	user_id nvarchar(36)		'$.user_id', 
	business_id nvarchar(36)	'$.business_id',
	stars nvarchar(50)			'$.stars',
	useful nvarchar(50)			'$.useful',
	funny nvarchar(50)			'$.funny',
	cool nvarchar(50)			'$.cool', 
	text nvarchar(max)			'$.text',
	date nvarchar(50)			'$.date'
) AS Review;


