-- two variables to save the JSON text in memory 
DECLARE @JSON VARCHAR(MAX), @JSON_Formatted VARCHAR(MAX)

-- Import the JSON file into 
SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'D:\Ryerson\CIND 820\Data sets\yelp_dataset\yelp_academic_dataset_business.json', SINGLE_CLOB) AS j

-- Format the JSON text/file properly for OPENJSON function
SELECT @JSON_Formatted = REPLACE('[ ' + REPLACE(REPLACE(@JSON, CHAR(13), ''), CHAR(10), ',') + ' ]', ', ]', ']')

-- Check
IF (ISJSON(@JSON_Formatted) = 1)
	PRINT 'Valid JSON'
ELSE
	PRINT 'Invalid JSON'

-- Use the OPENJSON function to convert JSON string to tabular form
SELECT * 
INTO dbo.Business
FROM OPENJSON(@JSON_Formatted)
WITH
(
	business_id varchar(36)							'$.business_id', 
	name nvarchar(255)								'$.name', 
	address nvarchar(255)							'$.address',
	city nvarchar(100)								'$.city',
	state nvarchar(50)								'$.state',
	postal_code nvarchar(50)						'$.postal_code',
	stars nvarchar(50)								'$.stars',
	review_count nvarchar(50)						'$.review_count',
	is_open nvarchar(50)							'$.is_open',
	RestaurantsTableService nvarchar(50)			'$.attributes.RestaurantsTableService', 
	WiFi nvarchar(50)								'$.attributes.WiFi',
	BikeParking nvarchar(50)						'$.attributes.BikeParking',
	BusinessParking nvarchar(255)					'$.attributes.BusinessParking',
	BusinessAcceptsCreditCards nvarchar(50)			'$.attributes.BusinessAcceptsCreditCards',
	RestaurantsReservations nvarchar(50)			'$.attributes.RestaurantsReservations',
	WheelchairAccessible nvarchar(50)				'$.attributes.WheelchairAccessible',
	Caters nvarchar(50)								'$.attributes.Caters',
	OutdoorSeating nvarchar(50)						'$.attributes.OutdoorSeating',
	RestaurantsGoodForGroups nvarchar(50)			'$.attributes.RestaurantsGoodForGroups',
	HappyHour nvarchar(50)							'$.attributes.HappyHour',
	BusinessAcceptsBitcoin nvarchar(50)				'$.attributes.BusinessAcceptsBitcoin',
	RestaurantsPriceRange2 nvarchar(50)				'$.attributes.RestaurantsPriceRange2',
	Ambience nvarchar(max)							'$.attributes.Ambience',
	HasTV nvarchar(50)								'$.attributes.HasTV',
	Alcohol nvarchar(50)							'$.attributes.Alcohol',
	GoodForMeal nvarchar(max)						'$.attributes.GoodForMeal',
	DogsAllowed nvarchar(50)						'$.attributes.DogsAllowed',
	RestaurantsTakeOut nvarchar(50)					'$.attributes.RestaurantsTakeOut',
	NoiseLevel nvarchar(50)							'$.attributes.NoiseLevel',
	RestaurantsAttire nvarchar(50)					'$.attributes.RestaurantsAttire',
	RestaurantsDelivery nvarchar(50)				'$.attributes.RestaurantsDelivery',
	categories nvarchar(max)						'$.categories',
	Monday_hours nvarchar(255)						'$.hours.Monday',
	Tuesday_hours nvarchar(255)						'$.hours.Tuesday',
	Wednesday_hours nvarchar(255)					'$.hours.Wednesday',
	Thursday_hours nvarchar(255)					'$.hours.Thursday',
	Friday_hours nvarchar(255)						'$.hours.Friday',
	Saturday_hours nvarchar(255)					'$.hours.Saturday',
	Sunday_hours nvarchar(255)						'$.hours.Sunday'
) AS Business;


