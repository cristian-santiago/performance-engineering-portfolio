Improvements for the thread dump analysis script

1. BLOCKED thread count

Detect and count threads in the BLOCKED state.

If > 0, list which ones they are and where they are blocked.

2. Deadlock detection

Search for "Found one Java-level deadlock" in the dump.

If found, isolate the involved threads.

3. Threads with repeated stacks

Group methods/lines appearing across multiple threads.

If N threads share the same stack top, it indicates a common bottleneck.

4. Threads WAITING on I/O

Search for `socketRead0`, `socketWrite0`, `epollWait`.

Indicates waiting on network or database.

5. Threads WAITING on connection pool

Search for `borrowObject` or `HikariPool`.

Indicates pool exhaustion.

6. RUNNABLE threads consuming CPU

Cross-reference with `top -H` to find CPU-consuming threads.

Show the stack traces for these threads.

7. Count by state

Sum the number of threads in RUNNABLE, WAITING, TIMED_WAITING, and BLOCKED states.

Provides a quick overview of JVM health.

8. Top N threads by CPU (TIME+)

Sort `top -H` output by accumulated time.

Cross-reference with the dump to show what each thread is doing.

9. Comparison across multiple dumps

Collect 3 dumps at intervals.

If the same thread appears at the top in all 3, the issue is persistent.