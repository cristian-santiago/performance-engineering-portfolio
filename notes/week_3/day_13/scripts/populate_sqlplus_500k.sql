BEGIN
    FOR i IN 1..510000 LOOP
        INSERT INTO customers (name, email)
        VALUES ('User ' || i, 'user' || i || '@gmail.com');
    END LOOP;
    COMMIT;
END;
/