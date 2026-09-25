JVM: Heap, GC and Threads

JVM - The virtual environment from JAVA;

It organize in three different memory tipes:

Heap ->
• Where the objects live
• Shared between all threads
• Managed by GC(garbage collector)
It can be divided in
• Young (Eden + Survivor)
• Old (Tenured)
The flow:
Object created -> Eden
Survivor(S0, S1) -> Objects that survived a GC.
Old generation (Tenured) -> Objects that survived several GCs

Stack ->
• One per thread
• Where local variable and call methods are alocated
• Fast but small

Metaspace ->

• Where classes metadata are alocated.
• Outside the Heap
• It increases (grow) accordingly classes are loaded.



Garbage Collection

GC is the proccess that free up object's memory that are no longer being used. With no GC, the heap should fill up and the appication crashes.

GC Tipes

Serial: One thread, stop everything(stop-the-world). Small Apps.

Parallel: Multiple threads, focus in throughput. Still pause.

G1 (Garbage First): Divide Heap in two reagions, collect the first with more garbage. Standard for Java 9+.

ZGC: Ultra-slow pauses (<10ms). Apps that may not stop.


Threads and Thread Pools

Thread: Execution unit. Each thread has own stack but share the heap.
Thread pool: Reusable thread set (pool), avoid create and destroy threads each request.

Why does this matter?
• Small Pool-> Requests increase the queue
• Large Pool-> Increase the context exchange, more GC, more memory
• The pool size affects directly the latency and throughput

SpringBoot TomCat, the standard is 200 threads.


Tools: jps, jstack, jmap

jps -l -> List the running Java process.

1 spring-demo-0.0.1-SNAPSHOT.jar
56 Jps

jstat-> Check the JVM statistic (GC, heap, classes)

jstat -gc PID 1000

OUTPUT Example:

    S0C         S1C         S0U         S1U          EC           EU           OC           OU          MC         MU       CCSC      CCSU     YGC     YGCT     FGC    FGCT     CGC    CGCT       GCT
        0.0      3072.0         0.0      2440.2      16384.0       6144.0      18432.0      10164.0    30016.0    29527.8    3968.0    3733.2      8     0.065     0     0.000     2     0.010     0.075


S0C/S1C -> Survivor Capacity 0/1
S0U/S1U -> Survivor Usage 0/1
EC/EU -> Eden Capacity/Eden Usage
OC/OU -> Old Capacity/Old Usage
MC/MU -> Metaspace Capacity/Metaspace Usage
YGC/YGCT -> Young Garbage Collectors/ YGC Total time
FGC/FGCT -> Full GCs/Total time
GCT -> GC Total Time



JCMD (JDK 17+)

jstat -> jcmd GC.heap_info: Display generic information about JVM heap usage.

jstack -> jcmd Thread.print: Generate the thread dump(stack trace for all threads)

jmap -heap -> GC.heap_info: Display generic information about JVM heap

jmap -histo -> GC.class_histogram Generate a histogram of classes(amount of instances and memory per class)

jmap -dump -> GC.heap_dump: Create a dump from heap(.hprof for analyze)

jinfo -> VM.flags: Display all JVM congig flags.

Usefull commands (necessary evaluate):

jcmd <PID> VM.uptime: Show how long time the VM is running

jcmd <PID> VM.system_properties: List all the system properties

jcmd <PID> JFR.dump: Generate a dump of Java Flight Recorder (events performance record)

jcmd <PID> VM.native_memory: Display the native memory JVM( useful to detect leaks outside the heap)

