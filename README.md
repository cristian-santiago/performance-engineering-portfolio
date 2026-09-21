# Performance Engineering Portfolio

Hands-on notes, SQL exercises, and k6 scripts focused on application and database performance analysis.

## Repository structure

```text
notes/
├── week_1/
│ ├── day_1/ # Performance fundamentals
│ ├── day_2/ # k6 fundamentals and scenarios
│ └── day_3/ # k6 thresholds and aggregation methods
├── week_2/
│ ├── day_5/ # Oracle XE and SQL Server setup notes
│ ├── day_6/ # SQL*Plus fundamentals and SQL exercises
│ ├── day_7/ # Execution plans and SQL Server scripts
│ ├── day_8/ # Indexes, locks, wait events, and blocking
│ ├── day_9/ # Database tuning case and data population script
│ └── day_10/ # Flask API and k6 API load test
```

## Weeks covered

### Week 1 — Performance Fundamentals and k6

- Observability signals, throughput, latency percentiles, error rate, saturation, Little's Law, and the hockey-stick behavior.
- Smoke, load, stress, and soak testing.
- k6 scenarios, ramping stages, checks, thresholds, and metric aggregation methods.

### Week 2 — Databases, Tuning, and API Load Testing

- Oracle XE, SQL Server, SQL*Plus basics, schemas, data types, and data population.
- Oracle and SQL Server execution plans, AWR, and Query Store.
- Index fundamentals and types, locks, blocking, and Oracle wait events.
- A database tuning case comparing full scans with indexed access on a customers table.
- A Flask API backed by Oracle and a k6 test used to measure the effect of the index.

## Tools used

- k6
- Oracle XE 21c and SQL*Plus
- SQL Server 2022 and sqlcmd
- Docker
- Python, Flask, and python-oracledb

## How to run the scripts

Install the required tools and make sure the target service or database is available before running a script.

Run the k6 examples from the repository root:

```powershell
k6 run notes/week_1/day_2/scripts/k6-test.js
k6 run notes/week_1/day_3/scripts/load_test.js
k6 run notes/week_1/day_3/scripts/aggregation-method.js
```

The Week 1 tests target the QuickPizza API. The API load test requires a local Oracle XE instance with the customers table and the Flask application running:

```powershell
pip install -r notes/week_2/day_10/scripts/api-demo/requirements.txt
python notes/week_2/day_10/scripts/api-demo/app.py
k6 run notes/week_2/day_10/scripts/k6_api.js
```

Execute the SQL Server scripts with sqlcmd and the Oracle scripts with SQL*Plus after connecting to the appropriate database. The SQL Server setup scripts create and populate customers; the 500k script extends that dataset for the tuning exercise.

```text
notes/week_2/day_7/scripts/sqlserver-basics.sql
notes/week_2/day_7/scripts/sqlserver-populate.sql
notes/week_2/day_9/scripts/sqlserver-populate-500k.sql
```
