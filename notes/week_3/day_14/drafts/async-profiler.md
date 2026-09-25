What it is
Low-overhead profiling tool. Uses AsyncGetCallTrace + perf_events to capture stack traces and generate flame graphs (HTML).

How to use
Inside the container:


cd /tmp/async-profiler-4.0-linux-x64
./bin/asprof -d 30 -e cpu -f /tmp/cpu.html 1
Outside the container (host):


sudo ./bin/asprof -d 30 -e cpu -f /tmp/cpu.html <HOST_PID>
-d 30 → duration in seconds

-e cpu → event (cpu, alloc, lock)

-f → output file (HTML)

<PID> → Java process

Copy to host:


docker cp spring-demo:/tmp/cpu.html ./cpu.html
How to read the flame graph
Wide bars → more CPU time

Nesting → who called whom (read bottom-up)

Top → method where time was spent

Practical example (app under load)

libc.so.6
  └── oracle/net/nt/TimeoutSocketChannel.doBlockedWrite
        └── com/demo/DemoApplication.customer
              └── JdbcTemplate.queryForList
Reading: time spent on network I/O with Oracle, not Java CPU. The bottleneck is the database, not the application.

Useful modes
Mode	What it shows
-e cpu	Where CPU is being spent
-e alloc	Where memory is being allocated
-e lock	Where lock contention is happening