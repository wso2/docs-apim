# Scenario 7 - Analytics

## User Story

**GOGO Transit has identified a new business opportunity; since the train arrival data contain the number of passengers in each arrival, it could be used to predict the crowd in the station for a certain time period. Therefore, the services built around the station such as stores in mall and cab services could use this data to optimize the number of employees they require for the services for each day. Thus, the GOGO decides to provide the passenger details API to the public with the subscription capability that generates revenue based on the number of successful requests completed within a time period.**

**_Time to Complete : 5 mins_**

Choreo API-M Analytics can be used to fulfil the stats and analytics needs of the API Manager. It is a cloud analytics offering for the Choreo API Manager and On-Prem API Manager deployments. 

![Analytics description]({{base_path}}/assets/img/tutorials/scenarios/analytics-desc.png)

To configure analytics, 

1. Signup to [https://console.choreo.dev/login/ ](https://console.choreo.dev/login/ )
2. Go to [https://console.choreo.dev/user-settings/onpremkeys](https://console.choreo.dev/user-settings/onpremkeys) and generate a key
3. Open the `/dockerfiles/conf/apim/repository/conf/deployment.toml` file and update the `[apim.analytics]` configuration similar to the following.
```
[apim.analytics]
enable = true
config_endpoint = "https://analytics-event-auth.choreo.dev/auth/v1"
auth_token = "<on prem key>"
```
4. Restart the api-manager container by using following.

    ```
    docker-compose restart api-manager

    ```


Let’s generate some traffic. We have deployed an API (**PassengerInfoAPI**) in super tenant domain. 

1. Go to the [https://localhost:9443/devportal/](https://localhost:9443/devportal/) and select carbon.super tenant domain.
2. Login using peter with password user123 and subscribe to **PassengerInfoAPI** api and generate an access token.
3. Invoke the API using the token.

```
curl -X GET "https://localhost:8243/info/1.0.0/passenger-count" -H "accept: application/json" -H "Authorization: Bearer <token>" -k

```

Go to [https://analytics.choreo.dev/overview](https://analytics.choreo.dev/overview) to view statistics. Following are some of the graphs.

![Usage]({{base_path}}/assets/img/tutorials/scenarios/usage-graph.png)


![Usage over time]({{base_path}}/assets/img/tutorials/scenarios/usage-ot-graph.png)

![Response time]({{base_path}}/assets/img/tutorials/scenarios/resp-time-graph.png)