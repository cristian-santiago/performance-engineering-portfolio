AWR - Automatic Workload Repository

It's a historical repo from Oracle.

Purpose:
• Periodic snapshots from performance (each 1h standard)
• Top SQL per time, CPU, I/O
• Wait events
• System statistics

access via DBMS_WORKLOAD_REPOSITORY

Query Store (SQL SERVER)

Equals to AWR, keeps history queries, plans and statistics.

It keeps:
• Executed queries, time, CPU, I/O
• Execution plan along the time
• Regression (queries that became slow after change)

Purpose: Identify problematic queries in history, compare plans before/after.

