# Subscription Validation Model

When using WSO2 API Manager as the control plane with Choreo Connect, it can be configured to validate the API Subscriptions. For this, the same API should be published in both API Manager and Choreo Connect, and a valid access token (JWT or Reference token) should be obtained by subscribing to the API via an Application. Choreo Connect is capable of validating subscriptions only for the configured tenant (One tenant per Choreo Connect basis).

## Subscription Validation Model

Subscriptions are validated in the Choreo Connect itself using a set of internal data stores. These data stores contain APIs, Applications, and Subscription related information.

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

