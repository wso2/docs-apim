# Distributed Tracing

Performance issues, errors, and exceptions are unfortunate events that may occur in a production environment. In order to identify such an unfortunate event, observing the production environment is essential. The WSO2 Choreo Connect provides ability to observe how the gateway is handling requests via OpenTelemetry based distributed tracing implementation. By connecting WSO2 Choreo Connect to one of the supported distributed tracing systems, users are able to easily debug and identify production issues.

Supported distributed tracing systems,

- Jaeger
- Zipkin
- Azure Application Insights

## Configure Distributed Tracing

!!! note
    If you are trying out tracing capabilities of WSO2 Choreo Connect and don't have an actual deployment of Jaeger or Zipkin, you can start Choreo Connect deployment with Jaeger/Zipkin by adding one of the below containers to product docker-compose file.

    ```yaml tab="Jaeger"
    jaeger:
      image: jaegertracing/all-in-one:1.27
      ports:
        - "5775:5775"
        - "16686:16686"
        - "14268:14268"`
    ```

    ```yaml tab="Zipkin"
    zipkin:
      image: openzipkin/zipkin
      container_name: zipkin
      ports:
        - "9411:9411"
    ```

### Jaeger

Follow these steps to configure WSO2 Choreo Connect with Jaeger,

1. Add below configuration to the `config.toml`  
    ```toml
    [enforcer.tracing]
      enabled = true
      type = "jaeger"
      [enforcer.tracing.configProperties]
          endpoint = "http://jaeger:14268/api/traces"
          instrumentationName = "CHOREO-CONNECT"
          maximumTracesPerSecond = "2"
    ```  
1. Start Choreo Connect deployment.
1. [Create and Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/)
1. Invoke the newly created API and open Jaeger UI to view the traces. Ex: <http://localhost:16686>

You will be able to browse through the request traces and expand each trace to view complete trace details.

![Jaeger Trace]({{base_path}}/assets/img/deploy/mgw/trace-jaeger.png)

### Zipkin

Follow these steps to configure WSO2 Choreo Connect with Zipkin,

1. Add below configuration to the `config.toml`  
    ```toml
    [enforcer.tracing]
      enabled = true
      type = "azure"
      [enforcer.tracing.configProperties]
        endpoint = "http://zipkin:9411/api/v2/spans"
        instrumentationName = "CHOREO-CONNECT"
        maximumTracesPerSecond = "2"
    ```  
1. Start Choreo Connect deployment.
1. [Create and Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/)
1. Invoke the newly create API and open Zipkin UI to view the traces. Ex: <http://localhost:9411>
1. Filter traces by `serviceName=choreo_connect` query.

You will be able to see all traces. Detailed trace view will look like below.

![Zipkin Trace]({{base_path}}/assets/img/deploy/mgw/trace-zipkin.png)

### Azure Application Insights

Follow these steps to configure WSO2 Choreo Connect with Azure Application Insights,

1. First you need to obtain the `ConnectionString` from the Azure portal.
    * Log in to Azure portal
    * Copy the `Connection String` from the overview page of `Application Insights` resource. Ex: `InstrumentationKey=ab71943f-xxxx-xxxx-xxxx-fb2eb69ae11d;IngestionEndpoint=https://region.applicationinsights.azure.com/`
1. Set above Connection String as an environment variable in enforcer container.

    ```yaml tab="Example"
    enforcer:
      ...
      environment:
        - APPLICATIONINSIGHTS_CONNECTION_STRING=InstrumentationKey=ab71943f-xxxx-xxxx-xxxx-fb2eb69ae11d;IngestionEndpoint=https://xxxxxx.applicationinsights.azure.com/
    ```

1. Add below configuration to the `config.toml`  
    ```toml
    [enforcer.tracing]
      enabled = true
      type = "azure"
      [enforcer.tracing.configProperties]
        connectionString = "$env{APPLICATIONINSIGHTS_CONNECTION_STRING}"
        instrumentationName = "CHOREO-CONNECT"
        maximumTracesPerSecond = "2"
    ```
1. Start Choreo Connect deployment.
1. [Create and Deploy an API]({{base_path}}/deploy-and-publish/deploy-on-gateway/choreo-connect/getting-started/quick-start-guide/quick-start-guide-docker-with-apim/)
1. Invoke the newly create API 
1. Now open "Azure Application Insights" Trasaction search window and select `Dependency` for `Event types` filter  
    ![Zipkin Trace]({{base_path}}/assets/img/deploy/mgw/trace-azure-filter.png)

You will be able to see all traces. Detailed trace view will look like below.

![Azure Trace]({{base_path}}/assets/img/deploy/mgw/trace-azure.png)