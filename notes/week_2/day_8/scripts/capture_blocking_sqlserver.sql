WHILE 1 = 1
BEGIN
    SELECT GETDATE() AS ts, session_id, blocking_session_id, wait_type, wait_time
    FROM sys.dm_exec_requests
    WHERE blocking_session_id <> 0;
    WAITFOR DELAY '00:00:01';
END
GO