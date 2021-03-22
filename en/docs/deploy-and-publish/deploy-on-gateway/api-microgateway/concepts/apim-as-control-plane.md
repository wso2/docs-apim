# Micorgateway with API Manager as Control Plane.

Microgateway can connect to API Manager running on cloud or on-premise as its control plane. Microgateway can be configured to connect with
APIM control plane, therefore the user actions like API deploying, application creation, key generation, subscription creation and etc are received by the
microgateway seamlessly.

[![]({{base_path}}/assets/img/deploy/mgw/mgw_overview.png)]({{base_path}}/assets/img/deploy/mgw/mgw_overview.png)

## Deploying API from Publisher portal
Following steps explains how API is getting deployed in microgateway upon API deploying action triggered in the publisher portal


1. Configure microgateway `[controlPlane]` configuration section to point to the API Manager
2. User creates a revision of the API from API Manager publisher portal.
3. Select the microgateway as the gateway environment and deploys the API.
4. Adapter component of microgateway receives the event of API deploying from the API Manager event hub component.
5. Adapter pulls the API object from the event hub upon receiving the API deploy event.
6. API is passed to the router and enforcer by the adapter.

## Microgateway Subscription Validation with API Manager Event Hub

Microgateway connects with event hub to receive different events in order to validate the subscriptions.
The following set of events are received by the microgateway in order to perform the subscription validation.

1. API Deploying events
2. Application creation Event
3. Application key generation event (Generation of consumer key and secret)
4. Subscribing an API to application event.

And also adapter pull the following details belonging to a particular tenant during the startup as well, in order to
get the events that has happened before the starting of the gateway. Adapter will have list of environments assigned to it.
Adapter will pull the APIs that are deployed in the specified set of environments only

1. Pull all the APIs deployed for matching environments for a specific tenant.
2. Pull all the applications created for a specific tenant.
3. Pull all the application key details for a specific tenant.
4. Pull all the subscriptions of a specific tenant.

The detailed explanation of subscription validation can be found [here](${{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/concepts/event-hub-subscription-validation).

##Rate Limiting

Rate limiting allows users to limit the number of incoming requests to a microgateway. The WSO2 API Microgateway connects 
with API Manager's Traffic manager component in order to publish and receive throttling data. This is called the global throttling.

To rate limit requests globally, the [distributed rate limiting](https://mg.docs.wso2.com/en/latest/publish/rate-limiting/distributed-throttling/#distributed-throttling) option can be used.

The WSO2 API Microgateway supports [resource level]({{base_path}}/deploy-and-publish/deploy-on-gateway/api-microgateway/rate-limiting/adding-throttling-policies/), [subscription level](#subscription-level-throttling-api-subscriber) and [application level throttling](#application-level-throttling-application-developer).

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

The API Microgateway is required to be notified when a token is revoked by the Security Token Service (STS).
When the API Microgateway is working with JWT formatted self-contained access tokens, it does not communicate with the STS for checking the validity of the token. It considers any token with a trusted signature as valid as long as the token is not expired. 
However, this model becomes a problem when the respective token is revoked by the STS. As a result, there needs to be a mechanism where the API Microgateway gets notified when a token is revoked before its expiry.

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
