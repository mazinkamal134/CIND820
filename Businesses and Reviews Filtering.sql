-- Fiter business --> Open Restaurants in BC
SELECT *
INTO [dbo].[BCRestaurants] -- Create a new table with the filtered Restaurants
FROM [CIND820].[dbo].[Business]
WHERE IsOpen = 1
AND State = 'BC'
AND Categories LIKE '%Restaurant%'

-- Get the associated reviews and save to a new table
SELECT A.*
INTO [dbo].[BCRestaurantReviews]
FROM [dbo].[Review] A
JOIN [dbo].[BCRestaurants] B ON A.BusinessId = B.[BusinessId]