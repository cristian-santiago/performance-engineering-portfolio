Locks - shared, exclusive and deadlock

The DB locks a resource (row, table, block) to avoid that two sessions modifying the same data at the same time.
Consistency mechanism.

Types of Lock

Shared (S):
• Many can read the same data at the same time
• While someone is reading, nobody can write into that data.
Ex.: SELECT (in some cases)


Exclusive (X):
• Only one can write
• While one write, nobody can read or write into that data.
Ex.: UPDATE, DELETE, INSERT

Deadlock:
• Session A locks the row 1 and wants row 2.
• Session B locks the row 2 and wants the row 2.
• No one release. TH DB detect and kill one of the sessions.


