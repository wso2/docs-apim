# Configure Multiple Gateways with Choreo Connect

Choreo Connect supports the configuration of multiple Gateways with WSO2 API Manager. This can be achieved with the Distributed Adapter pattern.

## Distributed Adapter pattern

Multiple Gateway environments can be registered in the WSO2 API Manager Control Plane. Each environment group includes an Adapter, an Enforcer, and a Router. The environment name used to register in the WSO2 API Manager Control Plane can be specified in the Adapter configurations. When the Adapter is started, it pulls the API artifacts related to the environment.

[![Distributed Adapter Pattern]({{base_path}}/assets/img/deploy/mgw/distributed-adapter-pattern.png){: style="width:60%"}]({{base_path}}/assets/img/deploy/mgw/distributed-adapter-pattern.png)

## Configuration of environments

Let's assume you have two environments called "choreo-connect-1" and "choreo-connect-2".

1. In each of the Adapters, add the relevant environment to `environmentLabels` in `<CHOREO-CONNECT_HOME>/docker-compose/choreo-connect-with-apim/conf/config.toml` under `controlPlane`.

    ```toml tab="Adapter 1"
    [controlPlane]
      enabled = true
      serviceUrl = "https://apim:9443/"
      username="admin"
      password="$env{cp_admin_pwd}"
      environmentLabels = ["choreo-connect-1"]
      [controlPlane.brokerConnectionParameters]
        eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'"]
        reconnectInterval = 5000
        reconnectRetryCount = 60
    ```

    ```toml tab="Adapter 2"
    [controlPlane]
      enabled = true
      serviceUrl = "https://apim:9443/"
      username="admin"
      password="$env{cp_admin_pwd}"
      environmentLabels = ["choreo-connect-2"]
      [controlPlane.brokerConnectionParameters]
        eventListeningEndpoints = ["amqp://admin:$env{cp_admin_pwd}@apim:5672?retries='10'&connectdelay='30'"]
        reconnectInterval = 5000
        reconnectRetryCount = 60
    ```
        
2. Start Choreo Connect deployment from docker-compose. 

3. Add the Gateway environments "choreo-connect-1" and "choreo-connect-2" from the Gateways in the API Manager Admin Portal.

    [![Add Gateway Environment]({{base_path}}/assets/img/deploy/mgw/add-gateway-environment.png)]({{base_path}}/assets/img/deploy/mgw/add-gateway-environment.png)

4. Deploy the API on the defined Gateway.
