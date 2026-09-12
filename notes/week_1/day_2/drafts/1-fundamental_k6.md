# K6 tool

K6 is a tool for load test that's open source and free to use, based in JavaScript, it can execute load tests like spike, stress and soak ones.


## imports

- http to get the request
- check to get the response code, like 200

## Set the API endpoint and the payload
Set the params with respected content Type


## Test Result Output

### Header
• execution: The test was performed in the local machine.
• script: The file executed (test.js)
• scenarios: How the test was configurated, 1VU (virtual user), 1 iteration

### Check

• checks_total: How much verifications the script has done.
• checks_succeeded: How much have succeeded.
• checks_failed> How much failed.
• Response code -> the check verification for status (like 200), if passed or not.

### Http

• http_req_duration: Time that the API took to respond
• {expected_response:true}: 

• http_req_failed: The % of requests that have failed.
• http_reqs: Total requests done.

### Execution

• iteration_duration: Time of the entire iteration (everything that the script did)
• iterations: How many time the script run completely

### Network

• data_received: The bytes that the API delivered.
• data_sent: The bytes that have been sent.

PS.: For 1 sample, the p95 doensn't make any sense due the avg = med = p95 are the same value.
Percentis just gain value with many iterations.