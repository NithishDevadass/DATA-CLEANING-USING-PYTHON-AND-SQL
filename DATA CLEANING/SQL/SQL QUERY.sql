
--VIEW THE TABLE

SELECT *
FROM DBO.[Employee Data ]

--STANDARIZE THE DATE FORMAT

SELECT [Hire Date],CONVERT(DATE,[Hire Date])
FROM DBO.[Employee Data ]

-- ADD THIS FORMAT TO THE TABLE

ALTER TABLE DBO.[Employee Data ]
ADD [STANDARD_DATE] DATE;

UPDATE DBO.[Employee Data ]
SET [STANDARD_DATE] =CONVERT(DATE,[Hire Date])

---------------------------------------------------------------------------------------------------------------

--SPILT THE COLUMN BY DELIMITER

SELECT 
SUBSTRING([Job Title],1,CHARINDEX(' ',[Job Title])) AS SPLIT
FROM DBO.[Employee Data ] 

-- ADD THIS COLUMN TO THE TABLE 

ALTER TABLE DBO.[Employee Data ] 
ADD SPLITTED_COLUMN NVARCHAR(255)

UPDATE DBO.[Employee Data ] 
SET SPLITTED_COLUMN=SUBSTRING([Job Title],1,CHARINDEX(' ',[Job Title]))

SELECT *
FROM DBO.[Employee Data ] -- SEE THE UPDATED COLUMN IN THE LAST

-- SPLIT THE COLUMN USING 'SUBSTRING' QUERY IT CONSIST THREE ARGUMENTS.
-----------------------------------------------------------------------------------------------

--TO FIND UNIQUE NAMES IN THE COLUMN

SELECT DISTINCT ([Business Unit]), COUNT([Business Unit])	-- COUNT IS USED TO HOW MANY TIME REPEAT THE NAME
FROM DBO.[Employee Data ]
GROUP BY [Business Unit]

-- TO RENAME THE CORRESPONDING ROW NAME
 
SELECT [Business Unit]
,	CASE WHEN [Business Unit]='Corporate' THEN 'Private'
	ELSE [Business Unit]
	END
FROM DBO.[Employee Data ]		--	ADD TO THE TABLE

ALTER TABLE DBO.[Employee Data ] 
ADD Correct_Form NVARCHAR(255);

UPDATE DBO.[Employee Data ] 
SET Correct_Form = CASE WHEN [Business Unit]='Corporate' THEN 'Private'
				   ELSE [Business Unit]
				   END

SELECT * 
FROM DBO.[Employee Data ]

------------------------------------------------------------------------------------------------------------

--  REMOVE DUPLICATES

ALTER DATABASE PROJECTS
SET COMPATIBILITY_LEVEL = 90;

WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY [Full Name],
							[Job Title],
							Department,
							[Hire Date]
							ORDER BY ([Employee ID])) RowNum

FROM DBO.[Employee Data ])
DELETE FROM CTE WHERE RowNum > 1;

-- TO VIEW THE UPDATED TABLE

SELECT *
FROM DBO.[Employee Data ]

--	CTE = COMMON EXPRESSION TABLE
--	WITHOUT USING COMPATIBILITY_LEVEL = 90.THERE WILL BE ERROR OCCURED.
--	BEFORE RUN THE CTE SET DATABASE COMPATIBILITY_LEVEL IS 90.
 ----------------------------------------------------------------------------------------------------------------

-- TO REMOVE UNUSED COLUMNS

ALTER TABLE DBO.[Employee Data ]
DROP COLUMN Ethnicity;

ALTER TABLE DBO.[Employee Data ]
DROP COLUMN [Exit Date],SPLITTED_COLUMN,STANDARD_DATE;

SELECT *
FROM DBO.[Employee Data ]

------------------------------------------------------------------------------------------------------------------








