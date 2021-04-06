# Event Hub and Subscription Validation Model

When using WSO2 API Manager as the key manager with Microgateway, it can be configured to validate the API Subscriptions. For this, the same API should be published in both API Manager and Microgateway, and a valid access token (JWT or Reference token) should be obtained by subscribing to the API via an Application. Microgateway is capable of validating subscriptions only for the configured tenant (One tenant per Microgateway basis).

## Subscription Validation Model

Subscriptions are validated in the Microgateway itself using a set of internal data stores. These data stores contain APIs, Applications, and Subscription related information.

The following are the data stores that are being used.

|Data Store|Description|
|----------|-----------|
|Application Key Mapping Data Store|Holds the consumer key and the corresponding applicatioId of Oauth applications created in API Manager|
|Application Data Store|Stores information about the Applications (id, application throttling policy, etc)|
|API Data Store|Stores API information (API Name, Version, Owner, etc)|
|Subscription Data Store|Stores API Subscription data. (API id, subscribed app id, subscription status, subscription policy)|

### Subscription Validation Process

1. Validate the token and get the consumer key (using the aud claim of JWT or introspection response).
2. Check in the Application Key Mapping Data store and get the Application Id for the consumer key.
3. If the Application Key Mapping is not found, invoke the internal data API and retrieve the application key mapping information.
4. If an entry is not found for the consumer key, the subscription validation is considered failed.
5. Get the API information from the API data store. (API id)
6. Get subscription information for API id and application id from the subscription data store.
7. If subscription data is not found (in data stores and api manager) then, the subscription is considered failed.
8. If a valid subscription is found, then the relevant data is populated into the internal context for other functions (analytics data, throttling, etc)

## The Event Hub

Event Hub is the endpoint configuration which is used to fetch API, Application and Subscription data from WSO2 API Manager.

Microgateway uses the below methods to fetch API and subscription-related data from API Manager.

- Internal Data REST API
- JMS Topic

The Internal Data API (```https://<APIM_HOST>:<PORT>/internal/data/v1```) is a REST API exposed in WSO2 API Manager to retrieve data related to APIs, applications, subscriptions, key managers, throttling and token revocation. During the startup, Choreo Connect invokes this API to fetch the already created APIs, applications, subscriptions, key managers and retrieve throttling, revoked token data of the configured tenant.

For new create/remove/update action happens for an API, application or subscription in WSO2 API Manager, it publishes events through relevant JMS topic. Therefore the Choreo Connect, which are subscribed to the topics, update the in-memory data stores when the event is received.

## Setting the Connection for JMS receiver

Multiple event listening endpoints can be defined as an array to use for the connection, along with optional failover parameters. 

| Option| Default Value| Description|
|-----------|-----------|----------|
|`retries`  | 1 |The number of retry attempts when connecting to the broker.|
|`connectdelay`  | None | How long (in seconds) to wait before attempting to reconnect. The recommended value is 30 seconds.|

Sample configuration for `eventListeningEndpoints` for JMS reciever can be defined as follows.
```
[controlPlane.eventHub.jmsConnectionParameters]
 eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'",
 "amqp://admin:$env{cp_admin_pwd}@apim:5673?retries='20'&connectdelay='30'"]
```


### Event Hub Configuration

``` toml
# Control plane's eventHub details
[controlPlane.eventHub]
  enabled = true
  serviceUrl = "https://apim:9443/"
  username="admin"
  password="$env{cp_admin_pwd}"
  environmentLabels = ["Production and Sandbox"]
  retryInterval = 5
  skipSSLVerification=true
  # Message broker connection URL of the control plane
  [controlPlane.eventHub.jmsConnectionParameters]
    eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='5'&connectdelay='30'"]

```