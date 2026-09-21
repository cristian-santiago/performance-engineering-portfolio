
WITHOUT Tunning> dropped index before run the test:


 TOTAL RESULTS

    checks_total.......: 891     29.540452/s
    checks_succeeded...: 100.00% 891 out of 891
    checks_failed......: 0.00%   0 out of 891

    ✓ status 200

    HTTP
    http_req_duration..............: avg=336.86ms min=132.94ms med=324.57ms max=777.14ms p(90)=467.93ms p(95)=516.71ms
      { expected_response:true }...: avg=336.86ms min=132.94ms med=324.57ms max=777.14ms p(90)=467.93ms p(95)=516.71ms
    http_req_failed................: 0.00%  0 out of 891
    http_reqs......................: 891    29.540452/s

    EXECUTION
    iteration_duration.............: avg=337.48ms min=133.34ms med=325.56ms max=778.67ms p(90)=468.55ms p(95)=517.37ms
    iterations.....................: 891    29.540452/s
    vus............................: 10     min=10       max=10
    vus_max........................: 10     min=10       max=10

    NETWORK
    data_received..................: 201 kB 6.6 kB/s
    data_sent......................: 80 kB  2.7 kB/s




running (0m30.2s), 00/10 VUs, 891 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  30s

----------

TUNNING> created index for column name

 TOTAL RESULTS

    checks_total.......: 1763    58.574028/s
    checks_succeeded...: 100.00% 1763 out of 1763
    checks_failed......: 0.00%   0 out of 1763

    ✓ status 200

    HTTP
    http_req_duration..............: avg=169.74ms min=77.16ms med=167.64ms max=318.31ms p(90)=215.15ms p(95)=231.64ms
      { expected_response:true }...: avg=169.74ms min=77.16ms med=167.64ms max=318.31ms p(90)=215.15ms p(95)=231.64ms
    http_req_failed................: 0.00%  0 out of 1763
    http_reqs......................: 1763   58.574028/s

    EXECUTION
    iteration_duration.............: avg=170.42ms min=77.56ms med=168.2ms  max=342.93ms p(90)=215.66ms p(95)=232.17ms
    iterations.....................: 1763   58.574028/s
    vus............................: 10     min=10        max=10
    vus_max........................: 10     min=10        max=10

    NETWORK
    data_received..................: 397 kB 13 kB/s
    data_sent......................: 159 kB 5.3 kB/s




running (0m30.1s), 00/10 VUs, 1763 complete and 0 interrupted iterations
default ✓ [======================================] 10 VUs  30s


	With index	No index	difference
avg	169,74ms	336,86ms	+98%
p95	231,64ms	516,71ms	+123%
max	318,31ms	777,14ms	+144%
req/s	58,57	29,54	-50%

The latency doubled
The troughput dropped by half, means that the API can't handdle the amount.
DB face bottleneck, each request do full scan of 500k+ rows.
