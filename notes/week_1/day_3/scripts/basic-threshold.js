import http from 'k6/http';

export const options = {

vus: 50,
duration: '30s',

// basic thresholds for the test to define pass or fail criteria
thresholds: {
    // http request duration must be less than 500ms for 95% of the requests
    http_req_duration: ['p(95)<500'],
    // The error rate must be below 1%
    http_req_failed: ['rate<0.01'],
    // The RPS must be greater than 100 per second.
    http_reqs: ['rate>100']
    
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

    const res = http.post(url, payload, params);
    console.log(res.body);

}