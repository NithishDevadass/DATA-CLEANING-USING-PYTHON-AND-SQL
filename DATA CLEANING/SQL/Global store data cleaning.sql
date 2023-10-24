 
 -- VIEW THE DATA

 use projects
 select * 
 from dbo.[Global-Superstore]

 -- STANDARDIZE DATE

 select [Order Date],[Ship Date], CONVERT(Date,[Order Date]), CONVERT(Date,[Ship Date])
 from dbo.[Global-Superstore]

 -- CREATE NAME FOR NEW COLUMN

 alter table dbo.[Global-Superstore]
 add [Order_Date] Date;

 -- UPDATE THE TABLE

 update dbo.[Global-Superstore]
 set [Order_Date] = CONVERT(Date,[Order Date])

 alter table dbo.[Global-Superstore]
 add [Ship_Date] Date;

 update dbo.[Global-Superstore]
 set [Ship_Date] = CONVERT(Date,[Ship Date])

 -- REMOVE THE PREVIOUS DATE COLUMNS

 alter table dbo.[Global-Superstore]
 drop column [Order Date],[Ship Date]

 -- FIND HOW MANY UNQUIE ORDERID

 select count(distinct ([Order ID]))
 from dbo.[Global-Superstore]

-- REMOVE DUPLICATES ROWS

ALTER DATABASE PROJECTS
SET COMPATIBILITY_LEVEL = 100;

WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY [Order ID],[Customer ID],[Customer Name],[Product ID],[Product Name]
							ORDER BY ([Order ID])) RowNum

from dbo.[Global-Superstore])
delete from CTE where RowNum > 1;

select *
from dbo.[Global-Superstore]

 -- VIEW PROFITABLE PRODUCTS

 select [Product Name],[Profit]
 from dbo.[Global-Superstore]
 where [Profit]>0
 order by [Profit]desc     -- IT SHOW PROFIT IN DESENDING ORDER

 -- TO VIEW SALES BY CATEGORY

 select count([Category]),Category
 from dbo.[Global-Superstore]
 group by Category


 
