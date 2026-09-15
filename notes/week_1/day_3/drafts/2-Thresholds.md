In K6  thresholds are pass/fail criteria that has to be defined for the metrics.
Is possible to codify the SLO into the load test with the syntax

Threshold Syntax fallow the pattern: Metric name, operator, and target value.

basic thresholds for the test to define pass or fail criteria

--
basisc_threshold.js
thresholds: {
    // http request duration must be less than 500ms for 95% of the requests
    http_req_duration: ['p(95)<500'],
    // The error rate must be below 1%
    http_req_failed: ['rate<0.01'],
    // The RPS must be greater than 100 per second.
    http_reqs: ['rate>100']
    
    }
    

--

Aggregation Methods

K6 can support different aggregation methods for thresholds and each one suits different SLO requirements.

Types of metric for threshold aggregation

Counter: Uses count or rate 
Gauge: Uses value
Rate: Uses rate
Trend: Use avg, min, max, med, p(N)


Percentile Thresholds