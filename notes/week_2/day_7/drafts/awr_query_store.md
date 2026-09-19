AWR - Automatic Workload Repository

It's a historical repo from Oracle.

Purpose:
• Periodic snapshots from performance (each 1h standard)
• Top SQL per time, CPU, I/O
• Wait events
• System statistics

access via DBMS_WORKLOAD_REPOSITORY

ASH (V$ACTIVE_SESSION_HISTORY) -> show each 1 second the exact timeline.
AWR -> Aggregated snapshot of the period (1h). Top SQL, wait events, load profile etc.

Query Store (SQL SERVER)

Equals to AWR, keeps history queries, plans and statistics.

It keeps:
• Executed queries, time, CPU, I/O
• Execution plan along the time
• Regression (queries that became slow after change)

Purpose: Identify problematic queries in history, compare plans before/after.

