# Choreo Connect Tenant Support

Choreo Connect supports only a single tenant. It cannot expose APIs of different tenants. A single deployment of Adapter, Enforcer, and Router should handle only a specific tenant's API. If there are multiple tenants, the multiple deployments should handle the traffic where each tenant has a dedicated deployment.

### Configure Control Plane with Choreo Connect for a tenant

Choreo Connect determines which tenant's APIs to be exposed by the tenant domain of the admin user used to authenticate with the Control Plane (API-M). Choreo Connect pulls all the APIs during the startup of that particular tenant where the admin user belongs to. The APIs getting deployed real time will be received by the JMS topic subscription. In order to authenticate with this AMQP endpoint, super tenant credentials are required. However, Choreo Connect will drop all the events that belong to different tenants than the one configured 
with the Control Plane. A single deployment of Choreo Connect will receive APIs, applications, subscriptions, rate limiting policies, etc. of a singletenant.

 ``` toml
 # Control plane's connection details
 [controlPlane]
  enabled = true
  serviceURL = "https://<apim-ip>:9443/"
  username="admin@foo.com"  // provide the tenant admin credentials
  password="$env{cp_tenant_admin_pwd}"
  environmentLabels = ["Default"]
  retryInterval = 5
  skipSSLVerification=true

  [controlPlane.brokerConnectionParameters]
    eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@<apim-ip>:5672?retries='10'&connectdelay='30'"] // provide super tenant 
    reconnectInterval = 5000
    reconnectRetryCount = 60

  [controlPlane.httpClient] 
    requestTimeOut = 30
 ``` 

### Configure rate limiting with Choreo Connect for a tenant

Choreo Connect publishes tenant APIs traffic data to the Traffic Manager component of the API Manager. Hence, it needs to configure traffic data publishing endpoints and rate limiting decision receiving endpoints.

In the case of a tenant, all the credentials under the configuration section `[enforcer.throttling]` should be **super tenant**

```toml
# Throttling configurations
[enforcer.throttling]
  # Connect with the central traffic manager
  enableGlobalEventPublishing = false
  # Enable global advanced throttling based on request header conditions
  enableHeaderConditions = false
  # Enable global advanced throttling based on request query parameter conditions
  enableQueryParamConditions = false
  # Enable global advanced throttling based on jwt claim conditions
  enableJwtClaimConditions = false
  # The message broker context factory
  jmsConnectionInitialContextFactory = "org.wso2.andes.jndi.PropertiesFileInitialContextFactory"
  # The message broker connection URL
  jmsConnectionProviderURL = "amqp://admin:$env{tm_admin_pwd}@carbon/carbon?brokerlist='tcp://apim:5672'"
  # Throttling configurations related to event publishing using a binary connection
  [enforcer.throttling.publisher]
    # Credentials required to establish connection between Traffic Manager
    username = "admin"
    password = "$env{tm_admin_pwd}"
    # Receiver URL and the authentication URL of the Traffic manager node/nodes
    [[enforcer.throttling.publisher.URLGroup]]
      receiverURLs = ["tcp://apim:9611"]
      authURLs = ["ssl://apim:9711"]
```
