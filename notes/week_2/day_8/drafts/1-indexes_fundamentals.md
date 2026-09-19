INDEXES, create or NOT create, this is the question...

WHen create:
• Columns used in WHERE frequently
• Columns used in JOIN (foreign keys)
• Columns used in ORDER BY/GROUP BY
• Huge tables and slow queries

When NOT:
• Small tables, full scan is faster.
• Column with low selectivity, like Sex (M/F) Options(Yes,No)
• Tables with lots of writes (INSERT, UPDATE, DELETE) -  The indexes are heavy for those operations, every indexes is a trade-off.
• Column that almost never aoopear in WHERE.

Tips: Index speed up the reading, slow down the writing. 
