#API Microgateway Key Concepts 

###Defining gateway specific properties

OpenAPI specification doesn't define all required properties for a API gateway. It's meant to be a descriptor of an REST endpoint. In this case that'd be the OpenAPI definition of backend endpoint. However a developer of an API gateway should be able to define,

-   Different types of endpoints
-   Gateway security
-   Rate limiting...

and many other gateway specific features per API or per Resource. Since Microgateway is using the OpenAPI definition as the SSOT (Single Source Of Truth), These additional properties should somehow go into OpenAPI definition maintained inside the Microgateway project. Microgateway utilizes OpenAPI Specification's vendor extensions for this purpose.

So to define above metioned additional API/Resource specific gateway attributes, Microgateway introduces set of vendor extensions for developers. List of available extensions are documented [here]({{base_path}}/deploy/api-microgateway/getting-started/api-microgateway-key-concepts/) .

###How to work with standard open API definition

In microgateway version 3.0.x series the open API definition required 2 mandatory wso2 specific extensions at leaset. Those were

1.  x-wso2-basePath
2.  x-wso2-production-endpoints

The x-wso2-basePath is used to group the all http resources of the open API under a single context so, it will be exposed as a sub resources of a singel API using microgateway. This is how microgateway logically separate one API from the other. The x-wso2-production-endpoints refers to the actual backend service implementation of the API. So these two details were mandatory to expose an API using microgateway.

**But with 3.1.0 onwards none of the wso2 specific open API extensions are mandatory.** Microgateway resolves base path and back end url as below

1.  **For swagger 2.0**
    The swagger 2.0 specification  defines a way of providing the [base path and the host](https://swagger.io/docs/specification/2-0/api-host-and-base-path/) of the service. If the swagger specifies the combination of **schemes, basePath and host** attributes, microgateway will drive the back end service url using host and schemes, and derive the base path using the base path attribute
2.  **For Open API 3.0**
    The open API 3.0 specification defines a way of providing [server](https://swagger.io/docs/specification/api-host-and-base-path/) url of the API defines by the open API definition. Microgateway derive the base path and the back end service url using the **servers** object defined in the open API definition.
    For if the server url is defined as ex: `http://test.com/v2` then microgateway will resolve backend service url as the given URL and it will also expose the API using the base path(context) /v2.

###Updating the API

Updating of the API is done by editing the existing open API definition. In order to update the API, the project must be built and microgateway should be re deployed again as API updates are not hot deployable.

Following properties of the open API is not recommended to be editied, as it will behave as a new API if those were edited.

-   Title
-   Version
-   basePath - If swagger 2.0. version is used
-   x-wso2-basePath
-   [servers](https://swagger.io/docs/specification/api-host-and-base-path/) objects basePath section if x-wso2-basePath is not present in the open API (this is explained in the above section **How to work with standard open API definition** ).
    For ex if servers url is defined as below.

    **Open API servers object**

    ``` yml
        servers:
        - url: https://api.example.com/v1 
    ```

 Then microgateway will expose the API using the base path(or context) /v1 if the x-wso2-basePath extension is not present. Then editing the last part of the servers url(/v1) will expose API as a different context. If editing the servers url is a must due to the changes in the actual back end service, then we can use the x-wso2-basePath extension as a fixed context and edit the servers url. So API will be exposed with the same base bath as it was before.

## OpenAPI Extensions
   
   WSO2 API Microgateway supports the following OpenAPI Extensions. You can use these extensions to override information with regard to API specifications.
   
   
   | Extension                         | Description                                                                                                            | Required/ Optional             |
   |-----------------------------------|------------------------------------------------------------------------------------------------------------------------|--------------------------------|
   | `x-wso2-basePath`                 | Base path that the gateway exposes the API.                                                                            | Optional → API level only      |
   | `x-wso2-production-endpoints`     | Specifies the actual backend of the service.                                                                           | Optional → API/Resource level  |
   | `x-wso2-sandbox-endpoints`        | Specifies the sandbox endpoint of the service if available.                                                            | Optional → API/Resource level  |
   | `x-wso2-request-interceptor`      | Specifies the interceptor used to perform transformations and mediations on the request.                               | Optional → API/Resource level  |
   | `x-wso2-response-interceptor`     | Specifies the interceptor used to perform transformations and mediations on the response.                              | Optional → API/Resource level  |
   | `x-wso2-throttling-tier`          | Specifies the rate limiting for the API or resource.                                                                   | Optional → API/Resource level  |
   | `x-wso2-cors`                     | Specifies the Cross-Origin Resource Sharing (CORS) configuration for the API.                                          | Optional → API level only      |
   | `x-wso2-endpoints `               | Defines the endpoint configuration globally which thereafter can be referred to using one of the following extensions. <li>`x-wso2-production-endpoints`</li> <li>` x-wso2-sandbox-endpoints`</li> | Optional |
   | `x-wso2-response-cache`           | Enable response caching when creating a new API with cache timeout level security                                      | Optional → API level only  |
   | `x-wso2-disable-security`         | Enables the resource to be invoked without authentication.                                                             | Optional → API/Resource level  |
   | `x-wso2-application-security`     | Set Application security (api\_key, basic\_auth, oauth2), to set optional for application level security               | Optional → API/Resource level  |
   | `x-wso2-auth-header`              | Specify the authorization header for the API in which either bearer or basic token is sent                             | Optional → API level only  |
   | `x-wso2-transports`               | Set transport types (http, https)                                                                                      | Optional → API level only      |
   | `x-wso2-mutual-ssl`               | Enable mutual SSL for an API (With optional and mandatory keywords as values)                                          | Optional → API level only      |
   | `x-wso2-owner`                    | Specifies the owner of the API. It is used to view analytics of dev first apis. (This user should be apim publisher user.)     | Optional → API level only      |
   
   !!! note 
       -   WSO2 API Microgateway supports only  the `"x-auth-type": "None"` option to disable the security. Therefore, the following concepts of the auth types in WSO2 API Manager will not work with the WSO2 API Microgateway.
           -   Application & Application User
           -   Application
           -   Application User
       -   However, if you want to expose API/resource without security, you can also use the `x-wso2-disable-security` extension. Find more information about this extension from [here](https://mg.docs.wso2.com/en/latest/publish/security/api-authentication/disabling-security/#disabling-security).
   
   You can find some samples on how these OpenAPI extensions are used in [Open API definitions](https://github.com/wso2/product-microgateway/blob/master/samples/).

##Event Hub and Subscription Validation Model
   
   When using WSO2 API Manager as the key manager with Microgateway, it can be configured to validate the API Subscriptions. For this, the same API should be published in both API Manager and Microgateway, and a valid access token (JWT or Reference token) should be obtained by subscribing to the API via an Application. Microgateway is capable of validating subscriptions only for the configured tenant (One tenant per Microgateway basis).
   
   ###Subscription Validation Model
   
   Subscriptions are validated in the Microgateway itself using a set of internal data stores. These data stores contain APIs, Applications, and Subscription related information.
   
   The following are the data stores that are being used.
   
   |Data Store|Description|
   |----------|-----------|
   |Application Key Mapping Data Store|Holds the consumer key and the corresponding applicatioId of Oauth applications created in API Manager|
   |Application Data Store|Stores information about the Applications (id, application throttling policy, etc)|
   |API Data Store|Stores API information (API Name, Version, Owner, etc)|
   |Subscription Data Store|Stores API Subscription data. (API id, subscribed app id, subscription status, subscription policy)|
   
   ####Subscription Validation Process
   
   1. Validate the token and get the consumer key (using the aud claim of JWT or introspection response).
   2. Check in the Application Key Mapping Data store and get the Application Id for the consumer key.
   3. If the Application Key Mapping is not found, invoke the internal data API and retrieve the application key mapping information.
   4. If an entry is not found for the consumer key, the subscription validation is considered failed.
   5. Get the API information from the API data store. (API id)
   6. Get subscription information for API id and application id from the subscription data store.
   7. If the subscription data is not found, invoke the internal data api and fetch any subscription data available.
   8. If subscription data is not found (in data stores and api manager) then, the subscription is considered failed.
   9. If a valid subscription is found, then the relevant data is populated into the internal context for other functions (analytics data, throttling, etc)
   
   ###The Event Hub
   
   Event Hub is the endpoint configuration which is used to fetch API, Application and Subscription data from WSO2 API Manager.
   
   Microgateway uses the below methods to fetch API and subscription-related data from API Manager.
   
   - Internal Data REST API
   - JMS Topic
   
   The Internal Data API (```https://<APIM_HOST>:<PORT>/internal/data/v1```) is a REST API exposed in WSO2 API Manager to retrieve data related to APIs, Applications, subscriptions, etc. During the startup, Microgateway invokes this API to fetch the already published API and subscription data of the configured tenant.
   
   For new API Creations and Subscription creations, API Manager publishes an event through a JMS topic. Microgateways, which are subscribed to the topic, update the in-memory data stores when the event is received.
   
   ####Event Hub Configuration
   
   ``` toml
   [apim.eventHub]
     enable = true
     service_url = "https://localhost:9443"
     internalDataContext="/internal/data/v1/"
     username="admin"
     password="admin"
     eventListeningEndpoints = "amqp://admin:admin@carbon/carbon?brokerlist='tcp://localhost:5672'"
   ```
   
   !!! note
       This feature is available from API Manager 3.2.0. If you are using an older version of API Manager, please follow the [Configuration for WSO2 API Manager]({{base_path}}/install-and-setup/configuration-for-wso2-api-manager/) to configure Microgateway correctly.

##Caching

Microgateway contains the following caching mechanisms to increase the performance of the gateway.

-   [OAuth cache](#oauth-cache)
-   [Response cache](#response-cache)

###OAuth cache

Microgateway will accept two types of OAuth tokens issued by a trusted key manager as a valid token.

1.  JWTs (Json Web Token)
2.  Opaque tokens (non-JWT)

The OAuth token is saved in OAuth cache, which is enabled by default. If a cache entry does not exist in the cache, it calls the Key Manager server. This process is carried out using Web service calls. After the Key Manager server returns the validation information, it gets stored in the Microgateway cache.

Unless an OAuth token is expired or revoked, Microgateway uses the cache to the authentication. This method reduces the number of Web service calls to the Key Manager server.

###Response cache

The API Microgateway has the ability to cache response messages for each API. Caching improves performance because the backend server does not have to process the same data for a request multiple times. You need to set an appropriate timeout period to offset the risk of stale data in the cache.

##Rate Limiting

Rate limiting allows users to limit the number of incoming requests to a microgateway. The WSO2 API Microgateway provides two rate-limiting options. They are,

-   Local rate limiting
-   Distributed rate limiting

 To rate limit requests globally, the [distributed rate limiting](https://mg.docs.wso2.com/en/latest/publish/rate-limiting/distributed-throttling/#distributed-throttling) option can be used.

The WSO2 API Microgateway supports [resource level]({{base_path}}/deploy/api-microgateway/rate-limiting/adding-throttling-policies/), [subscription level](#subscription-level-throttling-api-subscriber) and [application level throttling](#application-level-throttling-application-developer).

In a lockdown environment or in offline mode where there is no connection with the central traffic management solution, the default node-level throttling(local throttling) can be used.

####Local rate limiting
If a user wants to rate limit requests within a microgateway, the local rate limiting option can be used. When local rate limiting is enabled, WSO2 API Microgateway maintains a local counter within the microgateway and check whether the request count exceeds the throttling limit. Find information on how to enable local rate limiting from [here](https://mg.docs.wso2.com/en/latest/publish/rate-limiting/adding-throttling-policies/).

####Distributed rate limiting
In a deployment with multiple microgateways, throttling becomes a challenge with node local throttling as the throttling
decision is made based on the local counter within each node. If we proceed with the node local throttling in such
environment, the API user would be allowed to send multiples of the throttling limit.I.e. if the throttling limit is set to 10,
if we have 3 gateways in a cluster, it will allow 30 requests to pass to the backend before all three gateways
throttle out requests. This will put an unexpected load on the backend. To address this requirement, the API Microgateway
supports distributed throttling where it is able to work with a central traffic management solution. In this case,
multiple microgateways can connect with WSO2 API Manager
([WSO2 Traffic Manager]({{apim_path}}/install-and-setup/setup/distributed-deployment/product-profiles/))
and perform rate-limiting precisely. Find information on how to enable distributed rate limiting from [here](https://mg.docs.wso2.com/en/latest/publish/rate-limiting/distributed-throttling/#distributed-throttling).

!!! note
    If you start the WSO2 API Manager without providing any profile, it runs as All in One Node (All the profiles
    are activated). For testing purposes, you can simply start the API Manager following the
    [quick start guide]({{apim_path}}/getting-started/quick-start-guide/) and test.

###Different levels of throttling

####Subscription-level throttling (API subscriber)

Subscription-level throttling tiers are set to an API during the API implementation. When a user subscribes to the API through the developer portal, the subscription-level throttling tiers selected for the API will be listed from which one can be selected.

Based on the selected tier, a subscriber will be throttled out upon reaching the maximum number of requests specified in the tier, see [subscription-level throttling (API Publisher)]({{apim_path}}/deploy/ap-microgateway/rate-limiting/setting-throttling-limits/#subscription-level-throttling-api-publisher).

####Application-level throttling (application developer)

Application-level throttling tiers are defined at the time an application is created in the API Developer Portal as shown [here](https://apim.docs.wso2.com/en/latest/learn/rate-limiting/setting-throttling-limits/#application-level-throttling-application-developer). The limits are restricted per token for a specific application.

An application is a logical collection of one or more APIs. An API is subscribed to an application. A single access token generated for an application can be used to invoke all the APIs subscribed to that application.

An application can be used to support environment restrictions. For e.g., if there is an infrastructure limitation to serve a maximum number of requests at a given time, a throttling tier can be set to an application to avoid the system being overloaded.

For more information on application-level throttling tiers, see [application-level Throttling tiers](https://apim.docs.wso2.com/en/latest/learn/rate-limiting/adding-new-throttling-policies/#adding-a-new-application-level-throttling-tier).

##Revoked Tokens

The API Microgateway is required to be notified when a token is revoked by the Security Token Service (STS) in the following two instances.

1. When the API Microgateway is working with JWT formatted self-contained access tokens, it does not communicate with the STS for checking the validity of the token. It considers any token with a trusted signature as valid as long as the token is not expired. However, this model becomes a problem when the respective token is revoked by the STS. As a result, there needs to be a mechanism where the API Microgateway gets notified when a token is revoked before its expiry.
2. When the API Microgateway is authenticating requests using opaque (reference) tokens, it communicates with STS to validate the tokens. However if a token is revoked in the STS, API Microgateway doesn't get to know that token is revoked until token cache is expired. In other words, API Microgateway will allow to use revoked token until the token cache is expired. To avoid this, API Microgateway needs to get notified when a token is revoked by the STS.

WSO2 API Microgateway uses Real-time and Persistent Notifications to identify tokens that are revoked before their expiry. Real-time Notifications help you identify such revoked tokens in real-time after the WSO2 API Microgateway server has spun up. In contrast, when using Persistent notifications, the persistent storage maintains a current list of the revoked tokens. This will help new WSO2 API Microgateway servers that spin up to obtain information about the previously revoked tokens, which still have not expired. You can configure WSO2 API Microgateway to use both Real-time and Persistent Notifications together or separately. However, WSO2 recommends that you enable both Real-time and Persistent Notifications so that WSO2 API Microgateway can have a holist view of all the tokens that have been revoked before their expiry period.

###Methods to detect JWT token revocation

- [Real-time Notifier](#real-time-notifier)
- [Persistent Notifier](#persistent-notifier)

[![JWT revocation]({{base_path}}/assets/img/publish/jwt-revocation.png)]({{base_path}}/assets/img/publish/jwt-revocation.png)

####Real-time Notifier

When working with Real-time Notifications, WSO2 API Microgateway uses a Publisher- Subscriber model (pub-sub model) where the Security Token Service (STS) and WSO2 API Microgateways are linked using a Message Broker (MB). Whenever a revoke token request is received, the STS publishes a message to the JMS Message Broker. WSO2 API Microgateway has subscribed to the `tokenRevocation` topic, which is the JMS connection topic. When the JMS connection topic receives a message, the Message Broker propagates the message to the WSO2 API Microgateway servers. When the WSO2 API Microgateway servers receive this message, it will store the revoked tokens in-memory and treat them as revoked tokens. You can't extend the Real-time Notifier to add your own implementation.

####Persistent Notifier

When using Persistent Notifications, WSO2 API Microgateway uses a persistent storage mechanism to link the Security Token Service (STS) and the WSO2 API Microgateway servers. Whenever a token revoke request is received, the STS publishes a message to the persistent storage. When a new WSO2 API Microgateway server spins up, it pulls the list of revoked tokens from the persistent storage, and stores them in the revoked jti (JWT ID) cache. The latter mentioned process only takes place once, and the state of the token is preserved. The state of the revoked token is used at restarts and when new API Microgateways join the cluster of Microgateway servers. By default, WSO2 API Microgateway can use WSO2 API Manager or [etcd](https://github.com/etcd-io/etcd) servers as its persistent storage when working with persistent notifications. However, unlike when using the real-time notifications, you can use any persistent storage and a custom implementation.

For more information on how to enable and work with this feature, check [How to revoke tokens]({{base_path}}/design/api-security/rejecting-revoked-tokens)
