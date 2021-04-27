# Scenario 8 - Rate Limiting

While analyzing the traffic patterns and data, the GOGO DevOps team noticed that their backend is receiving a high number of requests and due to these high demand, their latency numbers also increased. The devOps team did some performance tests on their user info backend and identified that their backend service can handle a maximum of 1000 TPS. So GOGO management decided to introduce rate limiting to manage their free users.

**_Time to Complete : 5 mins_**

![Throttle description]({{base_path}}/assets/img/tutorials/scenarios/throttle-desc.png)

WSO2 API Manager provides various levels of rate limiting. For this case let’s apply Subscription Rate Limiting Policy and Maximum Throughput for the backend for **PassengerInfoAPI**.

To Create Subscription Rate Limiting Policy

1. Log in to Admin Portal [https://localhost:9443/admin](https://localhost:9443/admin) using `admin` and password `admin`.
2. Navigate to Rate Limiting **Policies → Subscription** Policies and create a new policy. Following is a sample policy.

    ![Sample policy]({{base_path}}/assets/img/tutorials/scenarios/sample-policy.png)

3. Once policy is created, to apply this to the API, log in to the Publisher Portal using `apiprovider` with the password `user123` and go to **Develop → Portal Configuration → Subscriptions** section.
4. Apply the policy to the **PassengerInfoAPI** and save the API.

    ![Apply policy]({{base_path}}/assets/img/tutorials/scenarios/apply-policy.png)

5. Now log in to the Developer Portal and create, application and try to subscribe to the API. You will notice that it has the newly created policy. 
6. Subscribe to the API using this policy and invoke the API using the generated token. 

    ![Subscribe]({{base_path}}/assets/img/tutorials/scenarios/subscribe-policy-api.png)

    ![Invoke]({{base_path}}/assets/img/tutorials/scenarios/invoke-policy-api.png)

7. When you request more than 10 times you will get a throttled-out message.

    ![Throttle out]({{base_path}}/assets/img/tutorials/scenarios/throttleout-api.png)



You could define a maximum throughput for the backend to protect the backend from high request load. For that

1. Log in to the Publisher Portal and select the API and navigate to **Develop → API Configurations → Runtime section**.
2. Under the **Backend** section, you could define the maximum TPS for the backend. For this demo, to see the results quickly, lets set it to 1 TPS and save the API

    ![Maximum throughput]({{base_path}}/assets/img/tutorials/scenarios/max-throughput.png)

3. For this configuration to take place, you need to create a new revision for this API. For that go to **Deploy → Deployments** and deploy a new revision.
4. Invoke the API in quick succession (more than one request per second). You could use the previous token for this.
   
You should see requests getting throttled out with following message

```
{
  "code": "900801",
  "message": "API Limit Reached",
  "description": "API not accepting requests"
}
```

![Backend throttled out]({{base_path}}/assets/img/tutorials/scenarios/throttleout-backend.png)


This shows API-M is limiting the requests to the backend.
