WAIT Events

V$SESSION_WAIT - dinamic view from Oracle that shows, for each session, what it's waiting now.

Views

V$SESSION_WAIT -> Shows the current waiting
V$SESSION_EVENT -> Shows the session total (historic)

Useful Query

SELECT sid, event, wait_class, seconds_in_wait, state
FROM v$session_wait
WHERE event NOT LIKE 'SQL*Net%'
AND event NOT LIKE 'rdbms%'
AND wait_class != 'Idle';

--

Columns

SID -> Sessiion
EVENT -> What is waiting
WAIT_CLASS -> Category (Application, User I/O, Network...)
SECONDS_IN_WAIT -> Seconds waiting
STATE -> WAITING or WAITED SHORT TIME

Common Events

enq: TX - row lock contention -> waiting row's lock
db file sequential read -> I/O index
db file scattered read -> full table scan

How to reproduce (blocking)

With 3 sessions ->
S1
UPDATE customers SET name = 'LOCKED' WHERE id = 1;

Don't commit
--
S2
UPDATE customers SET name = 'WAITING' WHERE id = 1;

It will lock
--
S3
SELECT sid, event, wait_class, seconds_in_wait, state
FROM v$session_wait
WHERE event NOT LIKE 'SQL*Net%'
AND event NOT LIKE 'rdbms%'
AND wait_class != 'Idle';

The output will show the state
enq: TX - row lock contention | Application | WAITING

S1
COMMIT;
It releases and the S2 continues.

Observation
SECONDS_IN_WAIT count the current waiting. After commit, it resets to zero. For historical, V$SESSION_EVENT is used.
