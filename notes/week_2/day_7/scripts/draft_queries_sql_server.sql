Creatomg the table and populating with 10,000 rows of data.


USE master;
GO

CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    email VARCHAR(254) NOT NULL
);

GO

DECLARE @i INT = 1;
WHILE @i <= 10000
BEGIN
    INSERT INTO customers (name, email) VALUES ('User' + CAST(@i AS VARCHAR), 'user' + CAST(#i AS VARCHAR) + '@email.com');
    SET @i = @i + 1;
END;
GO



-----

SET SHOWPLAN_TEXT ON;
GO
SELECT * FROM customers WHERE email = 'user5000@email.com';
GO

---

CREATE INDEX idx_customers_email ON customer(email);
GO

----

UPDATE STATISTICS customers;
GO

