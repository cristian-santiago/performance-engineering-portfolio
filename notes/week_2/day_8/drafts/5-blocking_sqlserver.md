Blocking in SQL Server

As in Oracle, that necessary to look at V$SESSION_WAIT, in SQL Server, we look at 
sys.dm_exec_requests, the column blocking_session_id


How to find:

SELECT
    r.session_id AS blocked,
    r.blocking_session_id AS blocker,
    r.wait_type,
    r.wait_time,
    t.text AS query
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0;

---
blocking_session_id = 0 -> It's no being blocked.

Head Blocker:  The session that block other, but isn't blocked by anyone.

Reproducing with 3 sessions

S1 

BEGIN TRANSACTION;

UPDATE customers SET name = 'LOCKED' WHERE id = 1;
GO
-- no commit

S2

UPDATE customers SET name = 'WAITING' WHERE id = 1;
GO
-- Lock here

S3 (monitoring)

SELECT
    r.session_id,
    r.blocking_session_id,
    r.wait_type,
    r.wait_time
FROM sys,dm_exec_requests r
WHERE r.blocking_session_id <> 0;
GO

---
Result: session_id from S2, blocking_session_id = S1, wait_type = LCK_M_X

Output


session_id = 55 | blocking_session_id = 59 | wait_type = LCK_M_X | wait_time = 47760

Session 55 is blocked (S2)
Session 59 is the blocker (head blocker) (S1)
LCK_M_X -> waiting for exclusive lock (X) (S3)
47760ms (~47s) -> waiting for 47s (S3)


Logging the realtime blocking captured

docker exec -i <container_name> <sqlcmd_path> -S <host> -U <user> -P '<password>' -C -i /dev/stdin < <script_path> > <log_file> 

