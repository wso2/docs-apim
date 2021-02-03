# Maintaining Separate Production and Sandbox Gateways

With WSO2 API Manager, you can maintain a production and a sandbox endpoint for a given API. The production endpoint is the actual location of the API, whereas the sandbox endpoint points to its testing/pre-production environment.

When you publish an API using the API Publisher, it gets deployed on the API Gateway. By default, there's a single Gateway instance (deployed either externally or embedded within the publisher), but you can also set up multiple Gateways:

#### Single Gateway to handle both production and sandbox requests

This is the default scenario. Because this Gateway instance handles both production and sandbox token traffic, it is called a hybrid API Gateway. When an API request comes to the API Gateway, it checks whether the requesting token is of type PRODUCTION or SANDBOX and forwards the request to the appropriate endpoint. The diagram below depicts this scenario.

[![Hybrid Gateway]({{base_path}}/assets/img/learn/hybrid-gw.png)]({{base_path}}/assets/img/learn/hybrid-gw.png)

#### Multiple Gateways to handle production and sandbox requests separately

Having a single Gateway instance to pass through both types of requests can negatively impact the performance of the production server. To avoid this, you can set up separate API Gateways. The production API Gateway handles requests that are made using PRODUCTION type tokens and the sandbox API Gateway handles requests that are made using SANDBOX type tokens.

The diagram below depicts this using two Gateways:

[![Production and sandbox gateways]({{base_path}}/assets/img/learn/production-sandbox-gws.png)]({{base_path}}/assets/img/learn/production-sandbox-gws.png)

In either of the two approaches, if an API Gateway receives an invalid token, it returns an error to the requesting client saying that the token is invalid.

You configure production and sandbox Gateways in the `<API-M_HOME>/repository/conf/deployment.toml` file in API Publisher nodes, as shown in the following example:

```toml
    [[apim.gateway.environment]]
    name = "Production"
    type = "production"
    display_in_api_console = true
    description = "This is the gateway that handles production token traffic."
    show_as_token_endpoint_url = true
    service_url = "https://localhost:9445/services/"
    username= "admin"
    password= "admin"
    ws_endpoint = "ws://localhost:9099"
    wss_endpoint = "wss://localhost:8099"
    http_endpoint = "http://localhost:8282"
    https_endpoint = "https://localhost:8245"

    [[apim.gateway.environment]]
    name = "Sandbox"
    type = "sandbox"
    display_in_api_console = true
    description = "This is the gateway that handles sandbox token traffic."
    show_as_token_endpoint_url = false
    service_url = "https://localhost:9448/services/"
    username= "admin"
    password= "admin"
    ws_endpoint = "ws://localhost:9199"
    wss_endpoint = "wss://localhost:8199"
    http_endpoint = "http://localhost:8285"
    https_endpoint = "https://localhost:8248"
```

The `service_url` parameter should have the value of the environment instance.

The `type` attribute of the environment can take the following values:

-   **Production** : A production type Gateway
-   **Sandbox** : A sandbox type Gateway
-   **Hybrid** : The Gateway handles both types of tokens

If you work with Gateways in different geographical locations, configuring multiple environments in the `<API-M_HOME>/repository/conf/deployment.toml` file is recommended. The diagram below depicts a sample setup:

[![Multi-region Gateway]({{base_path}}/assets/img/learn/multi-reigion-gw.png)]({{base_path}}/assets/img/learn/multi-reigion-gw.png)

**Figure** : API Gateways in different geographical regions

!!! info
    Note that in addition to the configuration mentioned above, all the other required configuration for Publisher and other Components should be done. If you are using a multi-tenanted setup, would need to share the registry database mount with the Gateway Sandbox and Production nodes.


