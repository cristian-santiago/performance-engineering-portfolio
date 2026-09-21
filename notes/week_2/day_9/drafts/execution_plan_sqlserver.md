Table customers with 510000 rows due the script sqlserver-populate-500.sql

Before:

SET SHOWPLAN_TEXT ON;
GO
SELECT * FROM customers WHERE name = 'User 5000';
GO

Plain:

StmtText                                                                                                    
------------------------------------------------------------------------------------------------------------------------------------------------
  |--Clustered Index Scan(OBJECT:([master].[dbo].[customers].[PK__customer__3213E83F8D017704]), WHERE:([master].[dbo].[customers].[name]=[@1]))


SET STATISTICS TIME ON;
GO

SELECT...

Creating index

CREATE INDEX idx_customers_name on customers(name);
GO

SELECT...

(1 rows affected)
StmtText                                                                                    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  |--Nested Loops(Inner Join, OUTER REFERENCES:([master].[dbo].[customers].[id]))           
       |--Index Seek(OBJECT:([master].[dbo].[customers].[idx_customers_name]), SEEK:([master].[dbo].[customers].[name]='User 5000') ORDERED FORWARD)
       |--Clustered Index Seek(OBJECT:([master].[dbo].[customers].[PK__customer__3213E83F8D017704]), SEEK:([master].[dbo].[customers].[id]=[master].[dbo].[customers].[id]) LOOKUP ORDERED FORWARD)

(3 rows affected)