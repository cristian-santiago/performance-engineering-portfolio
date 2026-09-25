Eclipse Memory Analyzer - Heap Dump heap.hprof analyzer

Problem Suspect 1

5.664 instances of “java.lang.Class”, loaded by “<system class loader>” occupy 3.418.496 (23,38%) bytes. 

Biggest instances:
•class oracle.jdbc.driver.JavaToJavaConverter @ 0x851c21b8 - 204.376 (1,40%) bytes. 
•class java.time.zone.ZoneRulesProvider @ 0x848ff5c0 - 203.224 (1,39%) bytes. 
•class java.lang.invoke.MethodType @ 0xffc05d98 - 163.184 (1,12%) bytes. 
•class sun.util.locale.BaseLocale$Cache @ 0xffc37248 - 151.200 (1,03%) bytes. 
•class sun.util.calendar.ZoneInfoFile @ 0xffc26450 - 149.432 (1,02%) bytes. 

Keywords
java.lang.Class


Problem Suspect 2

One instance of “org.springframework.beans.factory.support.DefaultListableBeanFactory” loaded by “org.springframework.boot.loader.launch.LaunchedClassLoader @ 0x84400098” occupies 1.767.920 (12,09%) bytes. The memory is accumulated in one instance of “org.springframework.beans.factory.support.DefaultListableBeanFactory”, loaded by “org.springframework.boot.loader.launch.LaunchedClassLoader @ 0x84400098”, which occupies 1.767.920 (12,09%) bytes.

Thread “java.util.TimerThread @ 0x851011b0 oracle.jdbc.diagnostics.Diagnostic.CLOCK” has a local variable or reference to “org.springframework.boot.web.embedded.tomcat.TomcatEmbeddedWebappClassLoader @ 0x84de2650” which is on the shortest path to “org.springframework.beans.factory.support.DefaultListableBeanFactory @ 0x8471c8c0”. The thread java.util.TimerThread @ 0x851011b0 oracle.jdbc.diagnostics.Diagnostic.CLOCK keeps local variables with total size 344 (0,00%) bytes.


Keywords
org.springframework.beans.factory.support.DefaultListableBeanFactory
org.springframework.boot.loader.launch.LaunchedClassLoader


Problem Suspect 3

The classloader/component “org.springframework.boot.loader.launch.LaunchedClassLoader @ 0x84400098” occupies 1.550.760 (10,61%) bytes. The memory is accumulated in one instance of “java.lang.Object[]”, loaded by “<system class loader>”, which occupies 1.327.232 (9,08%) bytes.

Thread “org.apache.tomcat.util.threads.TaskThread @ 0x84dc4c50 Catalina-utility-1” has a local variable or reference to “org.springframework.boot.loader.launch.LaunchedClassLoader @ 0x84400098” which is on the shortest path to “java.lang.Object[6246] @ 0x84e73f28”. The thread org.apache.tomcat.util.threads.TaskThread @ 0x84dc4c50 Catalina-utility-1 keeps local variables with total size 320 (0,00%) bytes.


Keywords
org.springframework.boot.loader.launch.LaunchedClassLoader
java.lang.Object[]



----

Context
Application: Spring Boot + Oracle JDBC

Heap dump generated with jcmd 1 GC.heap_dump /tmp/heap.hprof

Analysis in Eclipse MAT (Leak Suspects Report)

Heap Overview
Metric	Value
Used heap	13.9 MB
Objects	329,128
Classes	9,482
Class loaders	32
GC roots	2,786
Suspect 1 — java.lang.Class
5,664 instances occupying 3.4 MB (23%)

Largest instance: oracle.jdbc.driver.JavaToJavaConverter (204 KB)

Cause: Spring Boot loads many classes (framework + libs + Oracle driver)

Leak? No. Normal Spring cost.

Suspect 2 — DefaultListableBeanFactory
1 instance occupying 1.7 MB (12%)

Cause: Spring bean container. Holds all managed objects.

Leak? No. Core Spring structure.

Suspect 3 — LaunchedClassLoader
1 instance occupying 1.5 MB (10%)

Accumulated in an Object[] of 1.3 MB

Cause: Spring Boot classloader holds class references

Leak? No. Normal.

Conclusion
Heap of 13.9 MB, no leak.

The 3 suspects are normal structures of Spring Boot + Oracle JDBC.

No abnormal object growth.

How to identify a real leak
Generate two heap dumps with an interval (e.g., 1h or after load).

Compare: if the number of instances of the same class grows continuously, it's a leak.

Here, java.lang.Class and DefaultListableBeanFactory are stable.