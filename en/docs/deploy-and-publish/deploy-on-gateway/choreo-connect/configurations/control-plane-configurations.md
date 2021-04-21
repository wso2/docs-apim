# Control plane configurations in config.toml

The following are the configurations with regard to control plane. The configuration file ( `config.toml` ) for the Choreo Connect is located in the `CHOREO-CONNECT_HOME/docker-compose/choreo-connect/conf` directory.

|Heading|Description|
|-----------|-----------|
|`eventHub`  | Endpoint configuration which is used to fetch data from WSO2 API Manager.|

For more information follow the [Event Hub]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/concepts/event-hub/)

### Sample

The following is a sample security configurations.

``` java
[controlPlane]
  enabled = false
  serviceUrl = "https://apim:9443/"
  username="admin"
  password="$env{cp_admin_pwd}"
  environmentLabels = ["Default"]
  retryInterval = 5
  skipSSLVerification=true
  # Message broker connection URL of the control plane
    [controlPlane.jmsConnectionParameters]
        eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'"]
```
