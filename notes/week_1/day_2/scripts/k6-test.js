// K6 API test
import { check } from 'k6';
import http from 'k6/http';

// Config Options and Thresholds

export const options = {
    thresholds: {
        http_req_failed: ['rate<0.01'], // http erroos must be less than 1% to meets the SLO
        http_req_duration: ['p(99)<1000'], // 99% of the requests must complete below 1s also to meets the SLO
    },

    // Scenario configuration
    scenarios: {
        average_load: {
            executor: 'ramping-vus',
            stages: [
                {duration: '10s', target: 20}, // ramp up to avg load of 20 VUs in 10s
                {duration: '50s', target: 20}, // maintain avg load of 20 VUs for 50s
                {duration: '5s', target:0}, // ramp down to 0 VUs in 5s
            ],
        },
    },
};


export default function () {

    const url = 'https://quickpizza.grafana.com/api/users/token/login';
    const payload = JSON.stringify({
        username: 'default',
        password: '12345678',
    });

    const params = {

        headers: {
            'Content-Type': 'application/json',
        },

    };

    const res = http.post(url, payload, params);
    // console.log(res.body);

    // chec if the response is 200
    check(res,{
        'response code was 200': (res) => res.status == 200,
    }
    );

}
