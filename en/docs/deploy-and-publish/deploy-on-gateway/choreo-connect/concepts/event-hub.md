# Event Hub

The Event Hub acts as a mediator between the Adapter and the Control Plane. Choreo Connect uses the following methods to fetch data from WSO2 API Manager (WSO2 API-M).

- [Internal Data REST API](#internal-data-rest-api)
- [JMS Topic](#jms-topic)

!!! note
    The Event Hub is included within the Control Plane profile of WSO2 API-M. Therefore, if you use a distributed setup use the IP address of the control plane node for the configurations. For more information on profiles, see [API-M Profiles]({{base_path}}/install-and-setup/setup/distributed-deployment/product-profiles).

## Internal Data REST API

The Internal Data API (`https://<APIM_HOST>:<PORT>/internal/data/v1`) is a REST API exposed in WSO2 API Manager to retrieve data related to APIs, applications, subscriptions, Key Managers, Rate Limiting, and token revocation.

During startup, Choreo Connect invokes this API to fetch the authenticated users' tenant domain data related to the already created API, application, subscription, Key Manager, Rate Limiting and Revoked Token.

## JMS Topic

Choreo Connect has several consumers such as notification, keymanager, token revocation and rate limiting which are subscribed with relevant topics in order to receive events from the Control Plane. By enabling the Event Hub, which is within the Control Plane, in the Choreo Connect configuration file, the real-time data in WSO2 API Manager will automatically be available in Choreo Connect.

### Notification events

When a create, remove, or an update operation happens for an API, application or subscription in API Manager, the data are published to notification the JMS topic. When the notification consumer receives the event, Choreo Connect updates the in-memory data stores related to APIs, Applications, and Subscriptions.

### KeyManager events

When a create, remove, or an update operation takes place for the Key Managers that are defined in the WSO2 API-M Admin Portal, the data is published to the Keymanager JMS topic. When the event is received to the keymanager consumer, Choreo Connect updates the in-memory token issuer data store. 

!!! note
    The update in the token issuer data store takes place for remove keymanager only if that issuer is not presented in security token service configuration.

### Setting the Connection for the JMS receiver

Multiple event listening endpoints can be defined as an array to use for the connection, along with optional failover parameters. 

The following sample configuration illustrates how the `eventListeningEndpoints` configurtion for the JMS receiver can be defined:

```toml
[controlPlane.brokerConnectionParameters]
    eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'",
                               "amqp://admin:$env{cp_admin_pwd}@apim:5673?retries='20'&connectdelay='30'"]
```

| **Optional parameters** | **Default Value** | **Description** |
|-----------|-----------|----------|
| `retries`  | 1 | The number of retry attempts when connecting to the broker. |
| `connectdelay`  | None | How long (in seconds) to wait before attempting to reconnect. The recommended value is 30 seconds. |


## Event Hub Configuration

 ``` toml
 [controlPlane]
  enabled = true
  serviceURL = "https://<apim-ip>:9443/"
  username="admin"
  password="$env{cp_admin_pwd}"
  environmentLabels = ["Default"]
  retryInterval = 5
  skipSSLVerification=true

  [controlPlane.brokerConnectionParameters]
    eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@<apim-ip>:5672?retries='10'&connectdelay='30'"]
    reconnectInterval = 5000
    reconnectRetryCount = 60

  [controlPlane.httpClient] 
    requestTimeOut = 30
 ``` 

For more information, see [Control Plane Configurations]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations/control-plane-configurations/).
