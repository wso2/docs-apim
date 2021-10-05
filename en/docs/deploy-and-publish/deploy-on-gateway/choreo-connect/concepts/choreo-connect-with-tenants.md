# Choreo Connect Tenant Support.

Choreo Connect supports only a single tenant. It can not expose APIs of different tenants. A single deployment of
Adapter, Enforcer and Router should handle only a specific tenants API. If there are multiple tenants, the multiple deployments 
should handle the traffic where each tenant has a dedicated deployment.

### Configure Control Plane with Choreo Connect for a Tenant
Choreo Connect determines which tenant's APIs to be exposed by the tenant domain of the admin user used to authenticate with the
control plane (APIM). Choreo Connect pull all the APIs during the startup of that particular tenant where the admin user belongs to.
The APIs getting deployed real time will be received by the JMS topic subscription. In order to authenticate with this AMQP endpoint 
super tenant credentials are required. But Choreo Connect will drop all the events that belongs to different tenants than the one configured 
with control plane. Hence always a single deployment of Choreo Connect will receive APIs, applications, subscriptions, throttle policies and etc of a single
tenant.

```toml
    # Control plane's connection details
[controlPlane]
    enabled = true
    serviceUrl = "https://apim:9443/"
    username="admin@foo.com"  // provide the tenant admin credentials
    password="$env{cp_tenant_admin_pwd}"
    environmentLabels = ["Default"]
    retryInterval = 5
    skipSSLVerification=true
    # Message broker connection URL of the control plane
    [controlPlane.jmsConnectionParameters]
        eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'"] // provide super tenant credentials for amqp connection
```

### Configure Throttling with Choreo Connect for a Tenant
Choreo Connect publishes tenant APIs traffic data to the Traffic Manager 
component of the API Manager. Hence it needs to configure traffic data publishing endpoints and throttle decision receiving endpoints.
In case of a tenant, still all the credentials under the configuration section `[enforcer.throttling]`
should be **super tenant**

```toml
# Throttling configurations
[enforcer.throttling]
# Connect with the central traffic manager
    enableGlobalEventPublishing = true
    # The message broker context factory
    jmsConnectionInitialContextFactory = "org.wso2.andes.jndi.PropertiesFileInitialContextFactory"
    # The message broker connection URL
    jmsConnectionProviderUrl = "amqp://admin:$env{tm_admin_pwd}@carbon/carbon?brokerlist='tcp://apim:5672'"
    # Throttling configurations related to event publishing using a binary connection
    [enforcer.throttling.publisher]
    # Credentials required to establish connection between Traffic Manager
    username = "admin"
    password = "$env{tm_admin_pwd}"
    # Receiver URL and the authentication URL of the Traffic manager node/nodes
    [[enforcer.throttling.publisher.urlGroup]]
        receiverURLs = ["tcp://apim:9611"]
        authURLs = ["ssl://apim:9711"]
```