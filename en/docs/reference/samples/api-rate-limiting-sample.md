# API Rate Limiting Sample

### Usecase

-   For monetization purposes, to enforce limits on an Application based on its subscriptions

-   Enforce fair usage policy among an application’s users

-   Allow privileged rate limits based on location, device type, user credentials, etc.

-   Enforce a peak limit on back-end services to prevent total outages.

### Business Story

-   ABC organization has an API to expose there mobile phone prices. This organization currently exposes prices to the sales agents and they have a large number of third party sales agents.

-   They need to limit the total number of API calls to 50PerMin for this mobile price API

-   They need to limit the number of requests to 5000, when specific third party agent calls the mobile price API.

-   They need to allow API calls coming from a specific location (IP address - 192.168.1.1 to 192.168.1.100) and they need to restrict specific device types such as mobiles.

-   Even though they allow a specific number of API calls for a given period of time, they need to limit the API calls that come at a given point in time to restrict the burst requests and to prevent their back end service.

### Business Use Cases

-   For the above mentioned business story, ABC organization needs to have an API manager solution to expose their mobile price API.

-   They need to limit the the number of API calls that invokes by a specific third party agent

-   They need to limit the number of API calls that invokes by all the agents in a given time frame

-   They need to control the number of request comes from specific devices, locations

-   They need to control the number of requests comes at given time to limit the burst requests.

### How can this Business Scenario be achieved using WSO2 API Manager ?

In WSO2 API Manager we need to,

-   Create an API to expose their mobile phone prices.

-   Create an Application throttle policy to manage the API calls that come from all the third party agents subscribed to that particular application.

-   Create a Subscription throttle policy to limit the number of API calls from a specific third party agent.

-   Add a Burst Control (Rate Limiting) to the subscription policy to prevent the burst requests that can come in a given time frame.

### Running the sample to populate the sample data

-   Start wso2am-2.2.0-updateX.
-   Go to `<API-M_HOME>/sample-scenarios`. Execute the `run.sh` file. Enter the scenario number as 10, when prompted.

### User credentials needed for log in

| User         | Username | Password |
|--------------|----------|----------|
| Super tenant | admin    | admin    |

The screenshots below show how this usecase can be implemented.

![](https://lh3.googleusercontent.com/bFpveisjMdQmRpCtViTDEvf7cYJUqyseYJkoNArHLZgXGxwlCKYYRwb46abT8XRUQLc8qTNnI9fAt6v37_vP-vXqELZHfq9VKDRr0d9XdTslrBW8ZUJAKlc4t3k9AiyySkY-VLDu)
![](https://lh6.googleusercontent.com/7iLD_BnfGaL-qNljE3vzYRX0hu9-N3yZg5NA8LaerzSDeHMcLsRw8AMieYaLwN5t5fT5ugnJ5lm-WmrxFmorCvDZEKx75krdG8PaOItRCsGJz04akYBpfKdfPlEOd-0syVsdy8NB)
![](https://lh5.googleusercontent.com/1jcKwyM9cCZljZLnDX257aEYOe8ya9Mwgeue1y8QUnOxuDlLnc8nBHXhZVahCpgeog6Myg5belqNIKc17lx012v5eQVAdhiBcktJrWkQanoJH24JCGYEn_h3uinmmyyY4TXcB-Wc)
![](https://lh5.googleusercontent.com/gnCDQcYmKgGU6EEV5AVPGABP9jDGFzoz5FHyY3n3a3iG5cG1SWgWoULB5UB1ktS_liQSqEobKDbjJtiAkNGSX8OrrEZr4zHuMrl7D_K0XC-FIEKPXx8WAdKrMZEJfvIdIV_N8Waf)

