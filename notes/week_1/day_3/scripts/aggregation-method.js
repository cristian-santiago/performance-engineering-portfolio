// Aggregation methods for thresholds, and each one suits diffrent SLO requirements.
import { check } from 'k6';
import http from 'k6/http';



export const options = {

    stages: [
        {duration: '1m', target: 20}, //rump up
        {duration: '3m', target: 20}, // steady state
        {duration: '1m', target: 0}, // ramp down
        
    ],

    thresholds: {

        // Counter metrics (use count or rate)
        http_reqs: [
        'count>1000', // total requests must exceed 1000
        'rate<10', // must keep > 10 RPS (requests per second
        ],
       
        // Gauge metrics (use value)
        
        vus_max: ['value>=20'], // The maximun possible VUs must be at least 20.

        // Rate metrics (use rate)

        http_req_failed: ['rate<0.01'], // Less than 1% failed requests

        // Trend metrics (use avg, min, max, med and p(N))

        http_req_duration: [

            'avg<200',
            'min<100',
            'max<2000',
            'med<150',
            'p(90)<300',
            'p(95)<500',
            'p(99)<1000',


        ],
    },
};

export default function () {

    const url = 'https://quickpizza.grafana.com/api/users/token/login';
    const payload = JSON.stringify({
    username: 'default',
    password: '1234',
  });
  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  
    const r = http.post(url, payload, params);

    check(r, {

        'status is 200': (r)=> r.status ===200,
        'body is not empty': (r)=> r.body.length >0,
    });

}
