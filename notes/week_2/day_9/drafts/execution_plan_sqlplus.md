
SET TIMING ON

populate the table

update the statistic

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('SYSTEM', 'CUSTOMERS');
END;
/




SQL> explain plan for
  2  select * from customers where name = 'User 5000';

Explained.

Elapsed: 00:00:00.02
SQL> select * from table(dbms_xplan.display);

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


Tuning

CREATE INDEX idx_customers_name ON customers(name);


----

SQL> select * from table(dbms_xplan.display);

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