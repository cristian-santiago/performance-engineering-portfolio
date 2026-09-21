# Week 2 - DB Tuning Case

## Environment

- Oracle XE 21c + SQL Server 2022 (Docker)
- Table: customers (510k rows)

## 1. Oracle
- Query: SELECT * FROM customers WHERE name = 'User 5000';
- Before: TABLE ACCESS FULL | cost ~991 | 20ms
- After: INDEX RANGE SCAN | cost 4 | 10ms
- Plan: 

BEFORE
PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 2008213504

-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |     1 |    47 |   991   (1)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| CUSTOMERS |     1 |    47 |   991   (1)| 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   1 - filter("NAME"='User 5000')

13 rows selected.

Elapsed: 00:00:00.28

AFTER

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 2464999847

----------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name               | Rows  | Bytes | Cost (%CPU)| Time         |
----------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                    |     1 |    47 |     4   (0)| 00:00:01 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| CUSTOMERS          |     1 |    47 |     4   (0)| 00:00:01 |
|*  2 |   INDEX RANGE SCAN                  | IDX_CUSTOMERS_NAME |     1 |       |     3   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - access("NAME"='User 5000')
14 rows selected.

Elapsed: 00:00:00.04

## 2. SQL Server
- Query: SELECT * FROM customers WHERE name = 'User 5000';
- Before: Clustered Index Scan | CPU 64ms | Elapsed 66ms
- After: Index Seek | CPU 0ms | Elapsed 0ms
- Plan:

BEFORE
StmtText                                                                                                    
------------------------------------------------------------------------------------------------------------------------------------------------
  |--Clustered Index Scan(OBJECT:([master].[dbo].[customers].[PK__customer__3213E83F8D017704]), WHERE:([master].[dbo].[customers].[name]=[@1]))




AFTER
StmtText                                                                                    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  |--Nested Loops(Inner Join, OUTER REFERENCES:([master].[dbo].[customers].[id]))           
       |--Index Seek(OBJECT:([master].[dbo].[customers].[idx_customers_name]), SEEK:([master].[dbo].[customers].[name]='User 5000') ORDERED FORWARD)
       |--Clustered Index Seek(OBJECT:([master].[dbo].[customers].[PK__customer__3213E83F8D017704]), SEEK:([master].[dbo].[customers].[id]=[master].[dbo].[customers].[id]) LOOKUP ORDERED FORWARD)


## 3. K6 + API
- Setup: API Flask, python-oracledb, 10VUs, 30s
- No index: avg 336ms | p95 516ms | 29 req/s
- With index: avg 169ms | p95 231ms | 58 req/s
- Gain: ~50% latency, +98% throughput

## Bottleneck

510k rows per request with full table scan in column 'name'.