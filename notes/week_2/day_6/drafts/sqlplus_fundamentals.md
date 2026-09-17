DESCRIBE -> Show the structure of a table/view: Columns, if accept NULL, and data type;

Types

VARCHAR2(N): Variable size string, up to N characteres.
VARCHAR2(N CHAR): Real size of the string, all N characteres can be use.
NUMBER: Accept any number
NUMBER(10): Up to 10 digits
NUMBER(5,2) Up to 3 digits and 2 decimals (5-2)

Null? Empty, the column accept NULL
Null? with NOT NULL -> Mandatory column


--

CREATE TABELE customers (
    id NUMBER GENERATED ALWAYS AS IDENTITY,  
    name VARCHAR2(100 CHAR) NOT NULL,
    email VARCJAR2(254 CHAR) NOT NULL,
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT customers_pk PRIMARY KEY (id)    
);


GENERATED ALWAYS AS IDENTITY: A sequencial number will be generated for each row inserted.
Not necessary to be NOT NULL, it will be increased automatically by Oracle.

NOT NULL: Garantee that the filds name or e-mail as the example, not being empty, at least an input must be inserted.

INSERT INTO customers (name, email) VALUES ('Pedro Silva', 'pedro@email.com');


FORMAT: Format the columns in a table for a confort view, without truncate information.
Data is preserved, but the display is adjusted for a good view.

COLUMN name FORMAT A15 (set 15 characteres for name)
COLUMN email FORMAT A25 (set 25 characteres for email)
COLUMN created_at FORMAT A12 (set 12 characteres for the data created)




COLUMN column_name CLEAR -> Remove the format applied in the column_name only
CLEAR COLUMNS -> Clear all format


SCHEMA: to access the table from other schemas, necessary to insert the user related to this schema.
Examples -> user app -> app.customers (the app is the schema/user that access the customers table)
user api -> api.endpoint (api is the schema/user that access the endpoint table)
system -> sales; (the schema is the own system, not necessary to express system.sales;)


SEQUENCE: Resolve the same problem as IDENTITY, generate new IDs.
SEQUENCE is commonly used for lagecies systems, the IDENTITY is the new pattern used in Oracle 12c+