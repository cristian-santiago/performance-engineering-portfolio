# Week 1 Fundamentals

## 1. Fundamental metrics: Observability Pilar

Metrics: are aggregated numbers that change along the time.

RPS (Requests per second, throughput)
Latency, media or percentis (p50, p95, p99)
Erro rate
Memory and CPU Usage.
Queues size.

Logs: Text events that describe what happened in a specific moment.
HTTTPs requests, execution erros, debug messages.

Traces (Distributed tracking): show the completed way of a request through multiples services.

### Essential metrics (the four golden signals)

#### Latency

The time that takes to process a request.

p50 (media)= What tipicaly users can see, half of them are fast other are slow.
p95 = Antecipated alert of latency tail. 5% of the requests are worst than this.
p99 = Critical tail. The worst 1% of the requests, usually where conentratec the high value traffic.

> Note: User p50 to detec regression. p95 to adjust performance of the sistem and p99 to expose bottlenecks and discrepant values.

Traffic: Quantity of demand in the server, request per seconds RPS
Erros: Request rate that failed or rate error that occurred in the application.
Saturation: How 'full' is the service, like CPU, memory, disk.


## 2. Little's law

It's the mathematic principal that relate the number of items in a system and the deliver rate (average arrival)

### Formula

L = λ . W

- L (inventory, WIP)= the average number of items, people or tasks in the system.
- λ (lambda, throughput) = the average arrival or completion rate of items per unit of time (RPS)
- W (Wait Time or Cycle Time) = the average time an item spends inside the system.

### Key conditions

For the law work accurately, the system must meet the following basic rules:

- Steady State: The system must be stable, meaning that the rate of work entering matches the rate leaving over the long term.
- Flow Consistency: Items must not disappear or drop out unexpectedly between the start and the end.
- Matching Units: All time units across variables(hour, days, weeks) must match.

### Why it matters

- Predictability: Knowing two variables, it possible to calculate the third.
- Workload Control: To reduce wait times without working faster.

## 3. Hockey Stick

Describe a critical behavior where the response time or the resource utilization of a system stay stable util get a critical inflection and start to grow exponentially with minimum load increasement.

This phenomenum is directly associeated with Queue Theory, when a resource (CPU, memory, Disk, Network) reaches the total capacity and the time that requests spend waiting, the queue persists and 'explode'.

## 4. Type of tests

### Smoke Testing

Smoke Testing: Used to test a script over the system with a minimum load.
Better practice to use after create a new script and execute for exemplo with one user, to test if passed or there are any error.

Example: 1 user - 1min

### Load testing

Load testing: It's a test to check the environment performance in a normal usage condition with user and request simultaneously.
Better to understand how the application is working in normal condition of usage for the specific amount of user/request that are expected for it.

### Stress testing

Stress testing: Different from load test, the stress one are used to perform the environment to the extreme condition to observe the availability and estability.

Example:

- 100 users - 1min
- 600 users - 3min (peak, the stress test)
- 100 users - 1min

What it solves: How system behaves against extreme conditions.
What is the maximoum capacity that the system can support regarding user and response time.
What is the rupture point of the system and how it fails.
If the system recover itself afeter finish the stress test.

### Soak testing

Soak testing: This test is used to understand the confiability of the environment over a long time.
It reveals any kind of performance problem and confiability of a system under a long stress period.

#### What the test verify

- If appear bugs or memory leak that carries an instability/outage of the system after many hours.
- Certify that DB don't get disk full and stop;
- Verify that the logs along the time don't fill the disk space alocated.
- Certify that external APIS and integrations are still working after the application be exposed for a long time in the soak test.