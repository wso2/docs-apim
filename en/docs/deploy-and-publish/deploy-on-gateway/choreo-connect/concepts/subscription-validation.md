# Subscription Validation Model

When using WSO2 API Manager as the control plane with Choreo Connect, it can be configured to validate the API Subscriptions. For this, the same API should be published in both API Manager and Choreo Connect, and a valid access token (JWT or Reference token) should be obtained by subscribing to the API via an Application. Choreo Connect is capable of validating subscriptions only for the configured tenant (One tenant per Choreo Connect basis).

## Choreo Connect subscription validation with API Manager event hub

Choreo Connect connects with event hub to receive different events in order to validate the subscriptions.
The following set of events are received by the Choreo Connect in order to perform the subscription validation.

- API Deploying events.
- Application creation event.
- Application key generation event (generation of consumer key and secret).
- Subscribing an API to application event.

In order to get the events that has happened before the Gateway startup, the adapter will pull the following details of the tenant defined for the Choreo Connect instance during the startup. The Adapter will have list of predefined environments from which it will pull the APIs and the other artifacts.

- Pull all the APIs deployed for matching environments for a specific tenant.
- Pull all the applications created for a specific tenant.
- Pull all the application key details for a specific tenant.
- Pull all the subscriptions of a specific tenant.

## Subscription validation model

Subscriptions are validated in the Choreo Connect itself using a set of internal data stores. These data stores contain APIs, Applications, and Subscription related information.

The following are the data stores that are being used.

|Data Store|Description|
|----------|-----------|
|Application Key Mapping Data Store|Holds the consumer key and the corresponding applicationId of OAuth applications created in API Manager|
|Application Data Store|Stores information about the Applications (id, application throttling policy, etc)|
|API Data Store|Stores API information (API Name, Version, Owner, etc)|
|Subscription Data Store|Stores API Subscription data. (API id, subscribed app id, subscription status, subscription policy)|

### Subscription validation process

1. Validate the token and get the consumer key (using the aud claim of JWT or introspection response).
2. Check in the Application Key Mapping Data store and get the Application Id for the consumer key.
3. If an entry is not found for the consumer key, the subscription validation is considered failed.
4. Get the API information from the API data store. (API id)
5. Get subscription information for API id and application id from the subscription data store.
6. If subscription data is not found (in data stores and API Manager) then, the subscription is considered failed.
7. If a valid subscription is found, then the relevant data is populated into the internal context for other functions (analytics data, throttling, etc)

