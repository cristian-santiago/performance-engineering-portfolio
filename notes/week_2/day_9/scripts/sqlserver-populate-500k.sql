USE master;
GO

DECLARE @i INT = 10001;
WHILE @i <=510000
BEGIN
    INSERT  INTO customers (name, email) VALUES ('User ' + CAST(@i AS VARCHAR), 'user' + CAST(@i AS VARCHAR) + '@email.com');
    SET @i = @i + 1;
END;
GO