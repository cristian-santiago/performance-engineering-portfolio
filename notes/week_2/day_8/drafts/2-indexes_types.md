Types of INDEXES (B-tree, bitmap, covering)

B-tree (standard):

• Most common. Balanced tree structure.
• It works well with high selectivity (many distinct values)
• Used in =, <, >, BETWEEN, LIKE 'x%'


Bitmap:

• Used  in column with low selectivity (few distinct values)
Ex.: sex, status, active/inactive
• Common in data warehouse (heavy reading, few writing)
• Bad in OLTP (Online Transaction Processing) - Generate heavy locks.

Covering:

• Index that cover the query. It contains the whole necessary column.
• The DB don't need to go through the table (avoid lock)
Ex.: CREATE INDEX idx ON customers(email, name) -> if a query only use email and name, the index resolve itself.