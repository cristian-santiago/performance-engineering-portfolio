BEGIN
    FOR i IN 1..10000 LOOP
        INSERT INTO customers (name, email)
        VALUES (
            'User ' || i, 'user' || i || '@email.com'
        );
    END LOOP;
    COMMIT;
END;
/


Execution plan for email:

EXPLAIN PLAN FOR 
SELECT * FROM customers WHERE email = 'user5000@email.com';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

---------------------------------
Explained.

SQL> SQL>
PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
Plan hash value: 2008213504

-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |     1 |    37 |     2   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| CUSTOMERS |     1 |    37 |     2   (0)| 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------

   1 - filter("EMAIL"='user5000@email.com')

13 rows selected.

----------------------------------------------------

Operation: The query executed a select in a full table scan on the customers tabke.
Name: the table scanned (CUSTOMERS)
Rows: the number of rows returned by the query (1)
Cost: the cost of executing the query (2) less is better
Time: the estiimated time to execute the query.

TABLE ACCESS FULL: the query scanned the entire table to find the exact match.


Creating Indexes and Comparing Execution Plans

CREATE INDEX idx_customers_email ON customers(email);

Update statistics for the table customers.

BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('SYSTEM', 'CUSTOMERS');
END;
/



Plan execution for name:

EXPLAIN PLAN FOR
SELECT * FROM customers WHERE name = 'User 5000';

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Plan hash value: 2008213504

-------------------------------------------------------------------------------
| Id  | Operation         | Name      | Rows  | Bytes | Cost (%CPU)| Time     |
-------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |     1 |    41 |    20   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| CUSTOMERS |     1 |    41 |    20   (0)| 00:00:01 |
-------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

   1 - filter("NAME"='User 5000')

13 rows selected.

-----------

Full scan still occurs for the filters that contains % in the beginning of the string.

SELECT * FROM customers WHERE name LIKE '%User'; Don't use indexes, the full scan runs the entirely table.
SELECT * FROM customers WHERE name LIKE 'User%'; Uses the index, the full scan runs only the index.