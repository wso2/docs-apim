# Choreo Connect with API Manager as Control Plane.

Choreo Connect can connect to API Manager running on cloud or on-premise as its control plane. Choreo Connect can be configured to connect with
APIM control plane, therefore the user actions like API deploying, application creation, key generation, subscription creation etc are received by the Choreo Connect seamlessly.

[![]({{base_path}}/assets/img/deploy/mgw/mgw_overview.png)]({{base_path}}/assets/img/deploy/mgw/mgw_overview.png)

## Configure Choreo Connect with API Manager

!!! info
    **Before you begin**

    - Make sure you have installed Docker and Docker Compose on your machine.

    - Download the latest [Choreo Connect release](https://github.com/wso2/product-microgateway/releases) and extract it to a folder of your choice. The extracted folder will be referred to as `CHOREO-CONNECT_HOME` here onwards.

    - This guide assumes that you have already started the WSO2 API Manager instance. If not, download the latest [release](https://github.com/wso2/product-apim/releases) and follow the steps [here](https://github.com/wso2/product-apim#installation--running).

### Step 1 - Find the APIM IP Address

In order to tell Choreo Connect where API Manager (APIM) is located, find out the IP that can be used to access the API Manager instance. If you are trying out WSO2 API Manager locally, the private IP retrived using `hostname -I` or `ipconfig` would do.

### Step 2 - Update the Choreo Connect Config File

Open the `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect/conf/config.toml` file in a text editor and update it as follows.

In the `[controlPlane.eventHub]` section,

 - set `enabled` to true
 - update `serviceUrl` with the IP and the port of API Manager
 - if you want to use a Gateway Environment other than the default, update `environmentLabels` with the name of the new Gateway Environment. If not, leave the default value `"Production and Sandbox"` as it is.

 Example
 ``` yaml
 [controlPlane.eventHub]
  enabled = true
  serviceUrl = "https://192.168.1.94:9443/"
  username="admin"
  password="$env{cp_admin_pwd}"
  environmentLabels = ["Production and Sandbox"]
  retryInterval = 5
  skipSSLVerification=true
  # Message broker connection URL of the control plane
  [controlPlane.eventHub.jmsConnectionParameters]
    eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'"]
 ``` 

!!! tip

    In API Manager, a new Gateway Environment can be created from the Admin Portal (available at `https:<apim-host>:<apim-port>/admin`) **Gateways** tab.

### Step 3 - Start the Choreo Connect

Now, let's start the Choreo Connect. Navigate to `CHOREO-CONNECT_HOME/docker-compose/choreo-connect` and execute the following command.
    
``` bash
docker-compose up -d
```

## Deploying API from Publisher portal
Following steps explains how API is getting deployed in Choreo Connect upon API deploying action triggered in the publisher portal

1. Configure Choreo Connect `[controlPlane]` configuration section to point to the API Manager
2. User creates a revision of the API from API Manager publisher portal.
3. Select the Choreo Connect as the gateway environment and deploys the API.
4. Adapter component of Choreo Connect receives the event of API deploying from the API Manager event hub component.
5. Adapter pulls the API object from the event hub upon receiving the API deploy event.
6. API is passed to the router and enforcer by the adapter.

## Choreo Connect Subscription Validation with API Manager Event Hub

Choreo Connect connects with event hub to receive different events in order to validate the subscriptions.
The following set of events are received by the Choreo Connect in order to perform the subscription validation.

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

The detailed explanation of subscription validation can be found [here]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/event-hub-subscription-validation).

## Rate Limiting

Rate limiting allows users to limit the number of incoming requests to Choreo Connect. Choreo Connect connects
with API Manager's Traffic manager component in order to publish and receive throttling data. This is called the global throttling.

To rate limit requests globally, the [distributed rate limiting](https://mg.docs.wso2.com/en/latest/publish/rate-limiting/distributed-throttling/#distributed-throttling) option can be used.

Choreo Connect supports [resource level]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/rate-limiting/adding-throttling-policies/), [subscription level](#subscription-level-throttling-api-subscriber) and [application level throttling](#application-level-throttling-application-developer).

#### Distributed rate limiting
In a deployment with multiple Choreo Connect instances, throttling becomes a challenge with node local throttling as the throttling
decision is made based on the local counter within each node. If we proceed with the node local throttling in such
environment, the API user would be allowed to send multiples of the throttling limit.I.e. if the throttling limit is set to 10,
if we have 3 gateways in a cluster, it will allow 30 requests to pass to the backend before all three gateways
throttle out requests. This will put an unexpected load on the backend. To address this requirement, Choreo Connect
supports distributed throttling where it is able to work with a central traffic management solution. In this case,
multiple Choreo Connect instances can connect with WSO2 API Manager
([WSO2 Traffic Manager]({{apim_path}}/install-and-setup/setup/distributed-deployment/product-profiles/))
and perform rate-limiting precisely. Find information on how to enable distributed rate limiting from [here](https://mg.docs.wso2.com/en/latest/publish/rate-limiting/distributed-throttling/#distributed-throttling).

!!! note
    If you start the WSO2 API Manager without providing any profile, it runs as All in One Node (All the profiles are activated). For testing purposes, you can simply start the API Manager following the [quick start guide]({{base_path}}/getting-started/quick-start-guide/) and test.

### Different levels of throttling

#### Subscription-level throttling (API subscriber)

Subscription-level throttling tiers are set to an API during the API implementation. When a user subscribes to the API through the developer portal, the subscription-level throttling tiers selected for the API will be listed from which one can be selected.

Based on the selected tier, a subscriber will be throttled out upon reaching the maximum number of requests specified in the tier, see [subscription-level throttling (API Publisher)]({{apim_path}}/deploy-and-publish/choreo-connect/rate-limiting/setting-throttling-limits/#subscription-level-throttling-api-publisher).

#### Application-level throttling (application developer)

Application-level throttling tiers are defined at the time an application is created in the API Developer Portal as shown [here]({{base_path}}/design/rate-limiting/setting-throttling-limits/#application-level-throttling-application-developer). The limits are restricted per token for a specific application.

An application is a logical collection of one or more APIs. An API is subscribed to an application. A single access token generated for an application can be used to invoke all the APIs subscribed to that application.

An application can be used to support environment restrictions. For e.g., if there is an infrastructure limitation to serve a maximum number of requests at a given time, a throttling tier can be set to an application to avoid the system being overloaded.

For more information on application-level throttling tiers, see [Application-Level Throttling tiers]({{base_path}}/design/rate-limiting/setting-throttling-limits/#application-level-throttling-application-developer).


## Revoked Tokens

Choreo Connect is required to be notified when a token is revoked by the Security Token Service (STS).
When Choreo Connect is working with JWT formatted self-contained access tokens, it does not communicate with the STS for checking the validity of the token. It considers any token with a trusted signature as valid as long as the token is not expired. 
However, this model becomes a problem when the respective token is revoked by the STS. As a result, there needs to be a mechanism where Choreo Connect gets notified when a token is revoked before its expiry.

Choreo Connect uses Real-time and Persistent Notifications to identify tokens that are revoked before their expiry. Real-time Notifications help you identify such revoked tokens in real-time after Choreo Connect server has spun up. In contrast, when using Persistent notifications, the persistent storage maintains a current list of the revoked tokens. This will help new Choreo Connect servers that spin up to obtain information about the previously revoked tokens, which still have not expired. You can configure Choreo Connect to use both Real-time and Persistent Notifications together or separately. However, WSO2 recommends that you enable both Real-time and Persistent Notifications so that Choreo Connect can have a holist view of all the tokens that have been revoked before their expiry period.

### Methods to detect JWT token revocation

- [Real-time Notifier](#real-time-notifier)
- [Persistent Notifier](#persistent-notifier)

<!-- TODO: Fix the image -->
[![JWT revocation]({{base_path}}/assets/img/publish/jwt-revocation.png)]({{base_path}}/assets/img/publish/jwt-revocation.png)

#### Real-time Notifier

When working with Real-time Notifications, Choreo Connect uses a Publisher- Subscriber model (pub-sub model) where the Security Token Service (STS) and Choreo Connects are linked using a Message Broker (MB). Whenever a revoke token request is received, the STS publishes a message to the JMS Message Broker. Choreo Connect has subscribed to the `tokenRevocation` topic, which is the JMS connection topic. When the JMS connection topic receives a message, the Message Broker propagates the message to the Choreo Connect servers. When Choreo Connect servers receive this message, it will store the revoked tokens in-memory and treat them as revoked tokens. You can't extend the Real-time Notifier to add your own implementation.

#### Persistent Notifier

When using Persistent Notifications,  Choreo Connect uses a persistent storage mechanism to link the Security Token Service (STS) and the WSO2 API Choreo Connect servers. Whenever a token revoke request is received, the STS publishes a message to the persistent storage. When a new  Choreo Connect server spins up, it pulls the list of revoked tokens from the persistent storage, and stores them in the revoked jti (JWT ID) cache. The latter mentioned process only takes place once, and the state of the token is preserved. The state of the revoked token is used at restarts and when new API Choreo Connects join the cluster of Choreo Connect servers. By default,  Choreo Connect can use WSO2 API Manager or [etcd](https://github.com/etcd-io/etcd) servers as its persistent storage when working with persistent notifications. However, unlike when using the real-time notifications, you can use any persistent storage and a custom implementation.

For more information on how to enable and work with this feature, check [How to revoke tokens]({{base_path}}/design/api-security/rejecting-revoked-tokens)

## Third party Key Managers

Third Party Key Managers can be registered at APIM Admin Portal. The issuer data are used for JWT token validation in Choreo Connect. During the Choreo Connect startup, it is  connected with the event hub and pull the list of existing Key Managers. The data are stored in issuer data store at Enforcer. If the same token service has found at `config.toml` file, the configuration data in that issuer will be overridden with Key Manager Configurations comes from APIM Admin Portal. Whenever a Key Manager event (add, update, delete) receives to Choreo Connect, issuer data store will be updated accordingly. But if it still persists in `config.toml`, delete events will not be proceed.
