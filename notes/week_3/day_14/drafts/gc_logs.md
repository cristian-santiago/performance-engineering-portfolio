Running the app with GC logs enabled

docker run --rm -it -p 8080:8080 --network pe-net -e JAVA_TOOL_OPTIONS="-Xlog:gc*:file=/tmp/gc.log:time,uptime,level,tags" spring-demo

Run k6 for 30s using the k6_api.js (week_2/day_10) with the endpoing to the spring-demo application.

Check in real-time the GC Logs

docker exec -it spring-demo tail -f /tmp/gc.log

OUTPUT

[2026-09-24T23:46:08.231+0000][245.861s][info][gc,phases   ] GC(17)   Post Evacuate Collection Set: 0.64ms
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,phases   ] GC(17)   Other: 0.54ms
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,heap     ] GC(17) Eden regions: 17->0(17)
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,heap     ] GC(17) Survivor regions: 1->1(3)
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,heap     ] GC(17) Old regions: 19->19
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,heap     ] GC(17) Archive regions: 2->2
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,heap     ] GC(17) Humongous regions: 0->0
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,metaspace] GC(17) Metaspace: 47165K(47616K)->47165K(47616K) NonClass: 41492K(41728K)->41492K(41728K) Class: 5672K(5888K)->5672K(5888K)
[2026-09-24T23:46:08.231+0000][245.861s][info][gc          ] GC(17) Pause Young (Normal) (G1 Evacuation Pause) 37M->20M(48M) 4.859ms
[2026-09-24T23:46:08.231+0000][245.861s][info][gc,cpu      ] GC(17) User=0.00s Sys=0.00s Real=0.01s
[2026-09-24T23:46:14.733+0000][252.362s][info][gc,start    ] GC(18) Pause Young (Normal) (G1 Evacuation Pause)
[2026-09-24T23:46:14.733+0000][252.362s][info][gc,task     ] GC(18) Using 4 workers of 4 for evacuation
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,phases   ] GC(18)   Pre Evacuate Collection Set: 0.24ms
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,phases   ] GC(18)   Merge Heap Roots: 0.07ms
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,phases   ] GC(18)   Evacuate Collection Set: 7.87ms
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,phases   ] GC(18)   Post Evacuate Collection Set: 0.51ms
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,phases   ] GC(18)   Other: 0.18ms
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,heap     ] GC(18) Eden regions: 17->0(18)
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,heap     ] GC(18) Survivor regions: 1->1(3)
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,heap     ] GC(18) Old regions: 19->19
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,heap     ] GC(18) Archive regions: 2->2
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,heap     ] GC(18) Humongous regions: 0->0
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,metaspace] GC(18) Metaspace: 47188K(47680K)->47188K(47680K) NonClass: 41516K(41792K)->41516K(41792K) Class: 5672K(5888K)->5672K(5888K)
[2026-09-24T23:46:14.742+0000][252.371s][info][gc          ] GC(18) Pause Young (Normal) (G1 Evacuation Pause) 37M->20M(48M) 9.055ms
[2026-09-24T23:46:14.742+0000][252.371s][info][gc,cpu      ] GC(18) User=0.01s Sys=0.00s Real=0.01s


Line by Line:

GC(17) -> Collect number
Pause Young (Normal) -> Young GC (Minor GC)
G1 Evacuation Pause -> G1 move live objects from Eden to Survivor/OLD
37M-20M(48M) -> Heap before:After (total capacity)
4.859ms -> Pause time (stop-the-world)

What happened:

Eden get full (37MB used)
G1 did 4,8ms pause and then 9ms.
Moved live objects to Survivor, released Eden.
Heap droped to 20MB.

