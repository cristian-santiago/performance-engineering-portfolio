
Stages

Stages in K6 define the traffic shape of a test just configuring how VUs change over time.

Rump up
The initial phase, gradually increases the number of VUs from a starting point up to a target load, over a specific duration.

Plateau

Also known as Steady State, this phase the VUs remains constant for a set duration. It allows to measure system performance and stabilty under a steady load.

Ramp down

The final stage, when VUs decrease smothly and back to down to zero or a lower target over time.
Prevent pending conections, false errors from endpoint and dirty metrics, so the test has a graceful shutdown.